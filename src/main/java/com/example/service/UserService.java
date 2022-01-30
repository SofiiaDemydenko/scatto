package com.example.service;

import com.example.domain.Roles;
import com.example.domain.User;
import com.example.repos.UserRepository;
import org.springframework.beans.factory.ObjectFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.authentication.LockedException;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import javax.servlet.http.HttpSession;
import java.util.*;
import java.util.stream.Collectors;

@Service
public class UserService implements UserDetailsService {
    @Value("${activation}")
    private String activation;

    @Autowired
    ObjectFactory<HttpSession> httpSessionFactory;
    @Autowired
    private UserRepository userRepository;
    @Autowired
    private MailService mailService;
    @Autowired
    private PasswordEncoder passwordEncoder;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException,
            LockedException {
        User user = userRepository.findByUsername(username);
        if(user == null){
            throw new UsernameNotFoundException("Bad credentials");
        }
        if (user.getActivationCode() != null ) {
            throw new LockedException("Email is not activated");
        }
        return user;
    }
    public boolean addUser(User user){
        User userByDb = userRepository.findByUsername(user.getUsername());
        if(userByDb != null){
            return false;
        }
        user.setActive(true);
        user.setRoles(Collections.singleton(Roles.USER));
        user.setActivationCode(UUID.randomUUID().toString());
        user.setPassword(passwordEncoder.encode(user.getPassword())); //registration.

        userRepository.save(user);
        sendMessage(user);
        return true;
    }

    private void sendMessage(User user) {
        if(!StringUtils.isEmpty(user.getEmail())){
            String message = String.format("Dear, %s\n" +
                    "Welcome to the Scatto.\n" +
                    "Please, visit this page to confirm your email: %s%s",
                    user.getUsername(), activation, user.getActivationCode());
            mailService.send(user.getEmail(), "Activation code", message);
        }
    }

    public boolean activateUser(String code) {
        User user = userRepository.findByActivationCode(code);
        if(user == null){
            return false;
        }
        user.setActivationCode(null);
        userRepository.save(user);
        return true;
    }

    public List<User> findAll() {
        return userRepository.findAll();
    }

    public void saveUser(User user, String username, Map<String, String> form) {
        user.setUsername(username);
        Set<String> roles = Arrays.stream(Roles.values())
                .map(Roles::name)
                .collect(Collectors.toSet());
        user.getRoles().clear();
        for(String key : form.keySet()){
            if(roles.contains(key)){
                user.getRoles().add(Roles.valueOf(key));
            }
        }
        userRepository.save(user);
    }

    public void updateProfile(User user, String email, String password, String password2) {
        String userEmail = user.getEmail();
        boolean isEmailChanged = (email != null && !userEmail.equals(email)) ||
                (userEmail != null && !email.equals(userEmail));
        if(isEmailChanged){
            user.setEmail(email);
            if(!StringUtils.isEmpty(email)){
                user.setActivationCode(UUID.randomUUID().toString());
            }
        }
        if(!StringUtils.isEmpty(password) && !StringUtils.isEmpty(password2) && password.equals(password2)){
            user.setPassword(passwordEncoder.encode(password));
        }
        userRepository.save(user);
        if(isEmailChanged){
            sendMessage(user);
        }
    }
    public void deleteUser(User user) {
        userRepository.delete(user);
        HttpSession session = httpSessionFactory.getObject();
        session.invalidate();
    }

    public void subscribe(User currentUser, User user) {
        user.getSubscribers().add(currentUser);
        userRepository.save(user);
    }

    public void unsubscribe(User currentUser, User user) {
        user.getSubscribers().remove(currentUser);
        userRepository.save(user);
    }
}
