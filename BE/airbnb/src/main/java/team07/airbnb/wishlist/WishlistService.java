package team07.airbnb.wishlist;

import lombok.RequiredArgsConstructor;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.stereotype.Service;

import team07.airbnb.room.Room;
import team07.airbnb.room.RoomRepository;
import team07.airbnb.user.User;
import team07.airbnb.user.UserRepository;

@Service
@RequiredArgsConstructor
public class WishlistService {

    private final WishlistRepository wishlistRepository;
    private final UserRepository userRepository;
    private final RoomRepository roomRepository;

    public void addOne(WishlistAddRequest wishlistAddRequest) {
        User user = userRepository.findById(wishlistAddRequest.getUserId())
            .orElseThrow(() -> new EmptyResultDataAccessException("해당 id를 가진 User가 없습니다. 잘못된 요청", 1));

        Room room = roomRepository.findById(wishlistAddRequest.getRoomId())
            .orElseThrow(() -> new EmptyResultDataAccessException("해당 id를 가진 Room이 없습니다. 잘못된 요청", 1));


        wishlistRepository.save(new Wishlist(user, room));
        //Wishlist wishlist = new Wishlist(user, room);
    }

}
