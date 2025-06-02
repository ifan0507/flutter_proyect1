/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package spring.boot.backend.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import spring.boot.backend.model.User;

/**
 *
 * @author LENOVO
 */
public interface UserRepo extends JpaRepository<User, Integer> {
    User findByEmail(String email);

    User findByName(String name);
}
