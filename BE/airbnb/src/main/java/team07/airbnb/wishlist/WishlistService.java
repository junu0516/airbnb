package team07.airbnb.wishlist;

import java.util.List;
import java.util.stream.Collectors;

import lombok.RequiredArgsConstructor;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.stereotype.Service;

import org.springframework.transaction.annotation.Transactional;
import team07.airbnb.image.Image;
import team07.airbnb.image.ImageRepository;
import team07.airbnb.room.Room;
import team07.airbnb.room.RoomRepository;
import team07.airbnb.user.User;
import team07.airbnb.user.UserRepository;
import team07.airbnb.wishlist.WishlistsResponse.WishlistResponse;

@Service
@RequiredArgsConstructor
@Transactional
public class WishlistService {
    private final WishlistRepository wishlistRepository;
    private final UserRepository userRepository;
    private final RoomRepository roomRepository;
    private final ImageRepository imageRepository;

    public void addOne(WishlistAddRequest request) {
        User user = userRepository.findById(request.getUserId())
            .orElseThrow(() -> new EmptyResultDataAccessException("해당 id를 가진 User가 없습니다. 잘못된 요청", 1));

        Room room = roomRepository.findById(request.getRoomId())
            .orElseThrow(() -> new EmptyResultDataAccessException("해당 id를 가진 Room이 없습니다. 잘못된 요청", 1));

        wishlistRepository.save(new Wishlist(user, room));
    }

    public void deleteOne(WishlistDeleteRequest request) {
        Wishlist wishlist = wishlistRepository.findById(request.getWishlistId())
            .orElseThrow(() -> new EmptyResultDataAccessException("해당 id를 가진 Wishlist가 없습니다. 잘못된 요청", 1));

        User user = userRepository.findById(request.getUserId())
            .orElseThrow(() -> new EmptyResultDataAccessException("해당 id를 가진 User가 없습니다. 잘못된 요청", 1));
        if (!wishlist.isContainsRequestUser(user)) {
            throw new IllegalArgumentException("요청 userId의 wishlist가 아닙니다. 삭제 불가");
        }

        Room room = roomRepository.findById(request.getRoomId())
            .orElseThrow(() -> new EmptyResultDataAccessException("해당 id를 가진 Room이 없습니다. 잘못된 요청", 1));
        if (!wishlist.isContainsRequestRoom(room)) {
            throw new IllegalArgumentException("wishlist에 해당하는 roomId와 요청 roomId가 일치하지 않습니다. 잘못된 요청");
        }
        wishlistRepository.delete(wishlist);
    }

    @Transactional(readOnly = true)
    public WishlistsResponse findAll(Long userId) {
        List<Wishlist> wishlists = wishlistRepository.findWishlistWithRoomAndImageOrderEqualsOneByUserId(userId);
        List<WishlistResponse> wishlistResponses =
                wishlists.stream()
                        .map(i -> new WishlistResponse(i.getWishlistId(), i.roomId(), i.getRoom().getRoomName(), i.getRoom().getRoomPricePerDay(), i.getRoom().getImages().get(0).getImageLink(), 4.9, 123))
                        .collect(Collectors.toList());
        return new WishlistsResponse(userId, wishlistResponses);
    }

}
