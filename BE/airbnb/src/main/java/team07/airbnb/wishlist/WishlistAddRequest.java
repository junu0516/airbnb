package team07.airbnb.wishlist;

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
