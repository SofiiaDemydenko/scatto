package com.example.controllers;

import com.example.domain.Roles;
import com.example.domain.User;
import com.example.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@Controller
@RequestMapping("/user")
public class UserController {
    private final UserService userService;
    @Autowired
    public UserController(UserService userService) {
        this.userService = userService;
    }

    @GetMapping
    @PreAuthorize("hasAnyAuthority('ADMIN')")
    public String showAllUsers(Model model){
        model.addAttribute("users", userService.findAll());
        return "allUsers";
    }
    @GetMapping("{user}")
    @PreAuthorize("hasAnyAuthority('ADMIN')")
    public String editUser(@PathVariable("user") User user, Model model){
        model.addAttribute("user", user);
        model.addAttribute("roles", Roles.values());
        return "editUser";
    }
    @PostMapping
    @PreAuthorize("hasAnyAuthority('ADMIN')")
    public String saveUser(@RequestParam String username,
                           @RequestParam Map<String, String> form,
                           @RequestParam("userId")User user){
        userService.saveUser(user, username, form);
        return "redirect:/user";
    }
    @PostMapping("deleteUser")
    @PreAuthorize("hasAnyAuthority('ADMIN')")
    public String deleteUser(@RequestParam("userId")User user){
        userService.deleteUser(user);
        return "redirect:/user";
    }
    @GetMapping("profile")
    public String getProfile(Model model, @AuthenticationPrincipal User user){
        model.addAttribute("email", user.getEmail());
        model.addAttribute("password",user.getPassword());
        model.addAttribute("id", user.getId());
        return "profile";
    }
    @PostMapping("profile")
    public String updateProfile( @AuthenticationPrincipal User user,
                                 @RequestParam String password,
                                 @RequestParam String password2,
                                 @RequestParam String email){
            userService.updateProfile(user, email, password, password2);
        return "redirect:/main";
    }
    @GetMapping("delete/{user}")
    public String delete(@PathVariable("user") User user, Model model){
        model.addAttribute("username", user.getUsername());
        model.addAttribute("id", user.getId());
        return "deletion";
    }
    @PostMapping("delete")
    public String delete(@AuthenticationPrincipal User user,
                         @RequestParam String confirmation,
                         Model model){
        if(confirmation != null && confirmation.equals("confirm")){
            userService.deleteUser(user);
            return "greeting";
        }else {
            model.addAttribute("message", "Confirmation was failed.");
            model.addAttribute("username", user.getUsername());
            return "deletion";
        }
    }
    @GetMapping("{type}/{user}")
    public String getSubscribers(@PathVariable User user,
                                 @PathVariable String type, Model model){
        model.addAttribute("user", user);
        if(type.equals("subscribers")){
            model.addAttribute("subscribers", user.getSubscribers());
        }else{
            model.addAttribute("subscriptions", user.getSubscriptions());
        }
        return "subscriptions";
    }
    @GetMapping("subscribe/{user}")
    public String subscribe(@AuthenticationPrincipal User currentUser,
                            @PathVariable User user){
        userService.subscribe(currentUser, user);
        return "redirect:/user-messages/" + user.getId();
    }
    @GetMapping("unsubscribe/{user}")
    public String unsubscribe(@AuthenticationPrincipal User currentUser,
                            @PathVariable User user){
        userService.unsubscribe(currentUser, user);
        return "redirect:/user-messages/" + user.getId();
    }
}
