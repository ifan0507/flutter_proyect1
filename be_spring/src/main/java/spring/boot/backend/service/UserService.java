/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package spring.boot.backend.service;

import java.util.Collections;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import spring.boot.backend.model.User;
import spring.boot.backend.pyload.ChangePasswordRequest;
import spring.boot.backend.pyload.RegisterRequest;
import spring.boot.backend.repository.UserRepo;
import spring.boot.backend.utils.JwtUtil;

/**
 *
 * @author LENOVO
 */
@Service
public class UserService {

    @Autowired
    private UserRepo repo;

    @Autowired
    private JwtUtil jwtUtil;

    @Autowired
    private PasswordEncoder passwordEncoder;

    // UserService(BCryptPasswordEncoder passwordEncoder_1) {
    // this.passwordEncoder_1 = passwordEncoder_1;
    // }

    public ResponseEntity<Map<String, String>> regiaterUser(RegisterRequest userRequest) {

        BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();

        User user = new User();
        user.setName(userRequest.getName());
        user.setEmail(userRequest.getEmail());
        user.setPassword(encoder.encode(userRequest.getPassword()));
        repo.save(user);
        return ResponseEntity.ok(Collections.singletonMap("message", "Register Successfully"));
    }

    public ResponseEntity<Map<String, String>> loginUser(String email, String password) {
        User user = repo.findByEmail(email);

        if (user == null || !passwordEncoder.matches(password, user.getPassword())) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED)
                    .body(Collections.singletonMap("message", "Incorrect email or password"));
        }

        String token = jwtUtil.generateToken(user.getEmail());

        Map<String, String> response = new HashMap<>();
        response.put("message", "Login Successfully");
        response.put("token", token);
        return ResponseEntity.ok(response);
    }

    public User getUserByEmail(String email) {
        return repo.findByEmail(email);
    }

    public ResponseEntity<Map<String, String>> changePassword(String email, ChangePasswordRequest rQRequest) {
        User user = repo.findByEmail(email);

        if (user == null) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND)
                    .body(Collections.singletonMap("message", "User not found"));
        }

        if (!passwordEncoder.matches(rQRequest.getOldPassword(), user.getPassword())) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED)
                    .body(Collections.singletonMap("message", "Old password incorrect"));
        }

        user.setPassword(passwordEncoder.encode(rQRequest.getNewPassword()));
        repo.save(user);

        return ResponseEntity.ok(Collections.singletonMap("message", "Change password success fully"));
    }

}
