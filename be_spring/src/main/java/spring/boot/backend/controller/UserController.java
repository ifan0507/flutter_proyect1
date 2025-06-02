/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package spring.boot.backend.controller;

import java.util.Collection;
import java.util.Collections;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RestController;
import spring.boot.backend.model.User;
import spring.boot.backend.pyload.ChangePasswordRequest;
import spring.boot.backend.pyload.LoginRequest;
import spring.boot.backend.pyload.RegisterRequest;
import spring.boot.backend.service.UserService;
import spring.boot.backend.utils.JwtUtil;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.PathVariable;

/**
 *
 * @author LENOVO
 */
@RestController
@CrossOrigin // dont forgot to add this
public class UserController {

    @Autowired
    private UserService service;

    @Autowired
    private JwtUtil jwtUtil;

    @PostMapping("/register")
    private ResponseEntity<Map<String, String>> registerUser(@RequestBody RegisterRequest registerRequest) {
        // save the registerRequest
        return service.regiaterUser(registerRequest);
    }

    @PostMapping("/login")
    public ResponseEntity<Map<String, String>> login(@RequestBody LoginRequest request) {
        return service.loginUser(request.getEmail(), request.getPassword());
    }

    @GetMapping("/profile")
    public ResponseEntity<?> getProfile(Authentication authentication) {

        String email = authentication.getName();

        User user = service.getUserByEmail(email);
        if (user == null) {
            return ResponseEntity.badRequest().body("User tidak ditemukan");
        }
        return ResponseEntity.ok(user);
    }

    @PutMapping("change-password")
    public ResponseEntity<Map<String, String>> changePassword(@RequestBody ChangePasswordRequest cRequest,
            @RequestHeader("Authorization") String authHeader) {

        if (!authHeader.startsWith("Bearer ")) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED)
                    .body(Collections.singletonMap("message", "Expayed token"));
        }

        String token = authHeader.substring(7);
        String email = jwtUtil.getUsernameFromToken(token);

        if (!jwtUtil.validateToken(token)) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED)
                    .body(Collections.singletonMap("message", "Token tidak valid atau sudah kedaluwarsa"));
        }

        return service.changePassword(email, cRequest);
    }

}
