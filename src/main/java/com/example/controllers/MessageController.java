package com.example.controllers;

import com.example.domain.Message;
import com.example.domain.User;
import com.example.repos.MessageRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import javax.validation.Valid;
import java.io.IOException;
import java.util.Map;
import java.util.Set;

@Controller
public class MessageController {
    @Autowired
    private MessageRepository messageRepository;

    @GetMapping("user-messages/{user}")
    public String userMessages(@AuthenticationPrincipal User currentUser,
                               @RequestParam(required = false) Message message,
                               @PathVariable User user, Model model){
        Set<Message> messages = user.getMessages();
        model.addAttribute("messages", messages);
        model.addAttribute("isCurrentUser", currentUser.equals(user));
        model.addAttribute("userChannel", user);
        model.addAttribute("message", message);

        model.addAttribute("subscriptionsCount", user.getSubscriptions().size());
        model.addAttribute("subscribersCount", user.getSubscribers().size());
        model.addAttribute("isSubscribed", user.getSubscribers().contains(currentUser));
        return "userMessages";
    }
    @PostMapping("user-messages/{user}")
    public String editMessage(@AuthenticationPrincipal User currentUser,
                              @RequestParam ("file") MultipartFile file,
                              @RequestParam ("id") Message messageId,
                              @PathVariable User user,
                              @Valid Message message,
                              BindingResult bindingResult, Model model) throws IOException {
        if (!messageId.getAuthor().equals(currentUser)) {
            model.addAttribute("errorMessage", "Access denied");
            return "redirect:/user-messages/" + user.getId();
        }
        message.setAuthor(currentUser);

        if (bindingResult.hasErrors()) {
            Map<String, String> errorsMap = ControllerUtils.getErrors(bindingResult);
            model.mergeAttributes(errorsMap);
            model.addAttribute("message", message);

        }
        if (file.getOriginalFilename().isEmpty()) {
            model.addAttribute("fileFlash",
                    "Please, choose the file you want to upload");
        } else {
            ControllerUtils.saveFile(file, message);
            //delete attributes after success validation.
            model.addAttribute("errorMessage", null);
            model.addAttribute("fileFlash", null);
            model.addAttribute("message", null);
            messageRepository.save(message);
        }
        return "redirect:/user-messages/" + user.getId();
    }
}
