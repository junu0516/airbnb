package team07.airbnb.authentification;

import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

@RestController
@RequiredArgsConstructor
public class OauthController {

    private final OauthService oauthService;
    private final JwtProvider jwtProvider;

    @GetMapping("/login/oauth")
    public ResponseEntity<LoginResponse> oauthGithub(@RequestParam String code) {
        String accessToken = oauthService.generateAccessToken(code);
        Map<String, String> userAttributes = oauthService.getUserAttributes(accessToken);
        String gitJWT = jwtProvider.createToken("gitJWT");

        LoginResponse loginResponse = new LoginResponse(userAttributes.get("login"),userAttributes.get("avatar_url"), userAttributes.get("email"), gitJWT);
        return ResponseEntity.ok().body(loginResponse);
    }


}
