package team07.airbnb.authentification;

import org.apache.tomcat.util.codec.binary.Base64;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.*;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;

import java.util.Map;


@Service
public class OauthService {

    @Value("${oauth.user.client-id}")
    private String clientId;
    @Value("${oauth.user.client-secret}")
    private String clientSecret;
    @Value("${oauth.user.redirect-url}")
    private String redirectUrl;
    @Value("${oauth.provider.token-url}")
    private String tokenUrl;
    @Value("${oauth.provider.user-info-url}")
    private String userInfoUrl;

    public String generateAccessToken(String code) {
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);
        headers.setBasicAuth(clientId, clientSecret);

        MultiValueMap<String, String> parameters = new LinkedMultiValueMap<>();
        parameters.set("code", code);
        parameters.set("grant_type", "client_credentials");

        HttpEntity<MultiValueMap<String, String>> request = new HttpEntity<>(parameters, headers);
        ResponseEntity<Map> response = new RestTemplate().postForEntity(tokenUrl, request, Map.class);

        return response.getBody().get("access_token").toString();
    }

    public Map<String, String> getUserAttributes(String accessToken) {
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);
        headers.setBearerAuth(accessToken);

        HttpEntity<Map<String, String>> request = new HttpEntity<>(headers);
        ResponseEntity<Map> response = new RestTemplate().exchange(userInfoUrl, HttpMethod.GET, request, Map.class);

        return response.getBody();
    }
}
