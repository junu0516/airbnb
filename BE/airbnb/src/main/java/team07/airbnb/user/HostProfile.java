package team07.airbnb.user;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Getter
public class HostProfile {

    private final String nickname;
    private final String profileImage;

}
