package team07.airbnb.dto;

import lombok.Getter;
import org.springframework.lang.NonNull;

@Getter
public class WishlistAddRequest {

    @NonNull
    private Long roomId;
    @NonNull
    private Long userId;
    @NonNull
    private boolean isWished;

}
