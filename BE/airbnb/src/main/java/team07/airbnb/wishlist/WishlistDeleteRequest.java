package team07.airbnb.wishlist;

import lombok.Getter;
import org.springframework.lang.NonNull;

@Getter
public class WishlistDeleteRequest {

    @NonNull
    private Long wishlistId;
    @NonNull
    private Long roomId;
    @NonNull
    private Long userId;

}
