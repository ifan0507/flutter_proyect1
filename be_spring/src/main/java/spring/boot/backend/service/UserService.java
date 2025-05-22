/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package spring.boot.backend.service;

import java.util.Collections;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import spring.boot.backend.model.User;
import spring.boot.backend.pyload.LoginRequest;
import spring.boot.backend.pyload.RegisterRequest;
import spring.boot.backend.repository.UserRepo;

/**
 *
 * @author LENOVO
 */
@Service
public class UserService {

    @Autowired
    private UserRepo repo;
    @Autowired
    private PasswordEncoder passwordEncoder;

    public String regiaterUser(RegisterRequest userRequest) {

        BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();

        User user = new User();
        user.setName(userRequest.getName());
        user.setEmail(userRequest.getEmail());
        user.setPassword(encoder.encode(userRequest.getPassword()));
        repo.save(user);
        return "User registered Successfully";
    }

    public ResponseEntity<Map<String, String>> loginUser(String email, String password) {
        try {
            User user = repo.findByEmail(email)
                    .orElseThrow(() -> new RuntimeException("Email tidak ditemukan"));

            if (!passwordEncoder.matches(password, user.getPassword())) {
                return ResponseEntity.status(HttpStatus.UNAUTHORIZED)
                        .body(Collections.singletonMap("message", "Incorrect email or password"));
            }

            return ResponseEntity.ok(Collections.singletonMap("message", "Login Successfully"));

        } catch (RuntimeException ex) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND)
                    .body(Collections.singletonMap("message", ex.getMessage()));
        }
    }

}
