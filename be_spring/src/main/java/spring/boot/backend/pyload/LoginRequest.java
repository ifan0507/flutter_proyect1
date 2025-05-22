package spring.boot.backend.pyload;

import lombok.Data;

@Data
public class LoginRequest {

    private String email, password;

    public LoginRequest(String email, String password) {
        this.email = email;
        this.password = password;
    }
}
