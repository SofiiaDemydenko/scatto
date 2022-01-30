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
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import javax.validation.Valid;
import java.io.IOException;
import java.util.Map;

@Controller
public class MainController {

    private final MessageRepository messageRepository;
    @Autowired
    /*
         This annotation is not necessary, 'cos there's a constructor here.
         This means to get the bean called messageRepository.
         Which is auto-generated by Spring, and designed for data handle.
     */
    public MainController(MessageRepository messageRepository) {
        this.messageRepository = messageRepository;
    }

    @GetMapping
    public String greeting(Map<String, Object> model){
        return "greeting";
    }
    @GetMapping("/main")
    public String main(@RequestParam String filter,
                       Model model){
        Iterable<Message> messages;
        if(filter != null && !filter.isEmpty()){
            messages = messageRepository.findByTag(filter);
        }else{
            messages = messageRepository.findAll();
        }
        model.addAttribute("messages", messages);
        model.addAttribute("filter", filter);
        return "main";
    }
    @PostMapping("/main")
    public String add(
            @AuthenticationPrincipal User user,
            @RequestParam ("file") MultipartFile file,
            @Valid Message message,
            BindingResult bindingResult, Model model) throws IOException {
        message.setAuthor(user);
        if(bindingResult.hasErrors()){
            Map<String, String> errorsMap = ControllerUtils.getErrors(bindingResult);
            model.mergeAttributes(errorsMap);
            model.addAttribute("message", message);
        }
        if(file.getOriginalFilename().isEmpty()){
            model.addAttribute("fileFlash",
                    "Please, choose the file you want to upload");
        }
        else{
            ControllerUtils.saveFile(file, message);

            //delete attributes after success validation.
            model.addAttribute("fileFlash", null);
            model.addAttribute("message", null);
            messageRepository.save(message);
        }
        Iterable<Message> messages = messageRepository.findAll();
        model.addAttribute("messages", messages);
        return "main";
    }
}
