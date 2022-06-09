package team07.airbnb.wishlist;

import java.util.ArrayList;
import java.util.List;
import lombok.Getter;

@Getter
public class WishlistsResponse {
    private Long userId;
    private List<WishlistResponse> wishlists = new ArrayList<>();

    public WishlistsResponse(Long userId, List<WishlistResponse> wishlists) {
        this.userId = userId;
        this.wishlists = wishlists;
    }

    @Getter
    static class WishlistResponse {
        private final Long wishlistId;
        private final Long roomId;
        private final String roomName;
        private final int price;
        private final String thumbnailImage;
        private final double averageOfStar;
        private final int numberOfReviews;

        public WishlistResponse(Long wishlistId, Long roomId, String roomName, int price,
            String thumbnailImage, double averageOfStar, int numberOfReviews) {
            this.wishlistId = wishlistId;
            this.roomId = roomId;
            this.roomName = roomName;
            this.price = price;
            this.thumbnailImage = thumbnailImage;
            this.averageOfStar = averageOfStar;
            this.numberOfReviews = numberOfReviews;
        }
    }

}
