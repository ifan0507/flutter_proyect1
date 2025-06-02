package spring.boot.backend.pyload;

import lombok.Data;

@Data
public class ChangePasswordRequest {
    private String oldPassword, newPassword;
}
