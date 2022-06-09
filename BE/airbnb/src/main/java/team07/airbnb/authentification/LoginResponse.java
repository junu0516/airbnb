package team07.airbnb.authentification;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.ToString;

@Getter
@AllArgsConstructor
@ToString
public class LoginResponse {
    private String githubName;
    private String avatarUrl;
    private String githubEmail;
    private String JWT;
}
