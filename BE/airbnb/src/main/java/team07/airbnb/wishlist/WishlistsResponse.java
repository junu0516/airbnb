package team07.airbnb.wishlist;

import java.util.ArrayList;
import java.util.List;
import lombok.Getter;

@Getter
public class WishlistsResponse {
    private Long userId;
    private List<WishlistResponse> wishlists = new ArrayList<>();

    public WishlistsResponse(Long userId) {
        this.userId = userId;
    }

    public void addWishlistResponse(WishlistResponse wishlistResponse) {
        this.wishlists.add(wishlistResponse);
    }
}
