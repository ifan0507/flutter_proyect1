/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package spring.boot.backend.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;
import spring.boot.backend.model.User;
import spring.boot.backend.pyload.LoginRequest;
import spring.boot.backend.pyload.RegisterRequest;
import spring.boot.backend.service.UserService;

/**
 *
 * @author LENOVO
 */
@RestController
@CrossOrigin // dont forgot to add this
public class UserController {

    @Autowired
    private UserService service;

    @PostMapping("/register")
    private ResponseEntity<String> registerUser(@RequestBody RegisterRequest registerRequest) {
        // save the registerRequest
        String msg = service.regiaterUser(registerRequest);

        return new ResponseEntity<String>(msg, HttpStatus.OK);
    }

    @PostMapping("/login")
    public ResponseEntity<Map<String, String>> login(@RequestBody LoginRequest request) {
        return service.loginUser(request.getEmail(), request.getPassword());
    }
}
