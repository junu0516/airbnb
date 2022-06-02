package team07.airbnb.room;

import com.fasterxml.jackson.annotation.JsonProperty;
import java.util.List;
import lombok.AllArgsConstructor;
import lombok.Getter;
import team07.airbnb.address.Address;
import team07.airbnb.image.Image;
import team07.airbnb.wishlist.Wishlist;

@Getter
@AllArgsConstructor
public class RoomDetailResponse {
    private Long roomId;
    private List<String> images;
    @JsonProperty("isWished")
    private boolean isWished;
    private String title;
    private double averageOfStar;
    private int numberOfReviews;
    private String address;
    private String hostName;
    private String profileOfHost; //이미지링크
    private int maxNumberOfPeople;
    private RoomType roomType;
    private int bedCount;
    private int bathroomCount;
    private String description;
    private int priceForOneDay;

    public static RoomDetailResponse of(Room room, List<Image> images, List<Wishlist> wishlists, Long userId) {
        return new RoomDetailResponse(
            room.getId(),
            Image.imageEntitiesToStringList(images),
            isUserWishRoom(wishlists, userId), // api 명세 수정필요
            room.getRoomName(),
            4.8, // 수정필요
            127, //수정필요
            room.getAddress().divisions(),
            room.hostProfile().getNickname(),
            room.hostProfile().getProfileImage(),
            room.getMaxNumberOfGuest(),
            room.getRoomType(),
            room.getNumberOfBed(),
            room.getNumberOfToilet(),
            room.getRoomDescription(),
            room.getRoomPricePerDay());
    }

    private static boolean isUserWishRoom(List<Wishlist> wishlists, Long userId) {
        return wishlists.stream()
            .anyMatch(wishlist -> wishlist.guestId() == userId);
    }
}
