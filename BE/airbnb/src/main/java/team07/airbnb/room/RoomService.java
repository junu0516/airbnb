package team07.airbnb.room;

import java.util.List;

import lombok.RequiredArgsConstructor;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import team07.airbnb.dto.RoomDetailResponse;
import team07.airbnb.image.Image;
import team07.airbnb.image.ImageRepository;
import team07.airbnb.wishlist.Wishlist;
import team07.airbnb.wishlist.WishlistRepository;

@Service
@RequiredArgsConstructor
@Transactional
public class RoomService {

    private final RoomRepository roomRepository;
    private final ImageRepository imageRepository;
    private final WishlistRepository wishlistRepository;

    @Transactional(readOnly = true)
    public RoomDetailResponse findOne(Long roomId) {
        Long userId = 1L; // 더미데이터 - 추후 API명세 수정 필요
        Room findRoom = roomRepository.findRoomWithHostById(roomId)
            .orElseThrow(() -> new EmptyResultDataAccessException("해당 id를 가진 Room이 없습니다. 잘못된 요청", 1));
        List<Image> roomImages = imageRepository.findByRoomId(roomId);
        List<Wishlist> wishlists = wishlistRepository.findByUserId(userId);

        return RoomDetailResponse.of(findRoom, roomImages, wishlists, userId);
    }
}
