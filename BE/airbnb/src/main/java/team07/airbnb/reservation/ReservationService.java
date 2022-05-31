package team07.airbnb.reservation;

import java.util.List;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import team07.airbnb.image.Image;
import team07.airbnb.image.ImageRepository;

@Service
@RequiredArgsConstructor
@Transactional
public class ReservationService {
    private final ReservationRepository reservationRepository;
    private final ImageRepository imageRepository;

    @Transactional(readOnly = true)
    public ReservationDetailResponse findOne(Long reservationId) {
        Reservation reservationAndRoom = reservationRepository.findReservationWithRoomAndHost(reservationId);
        List<Image> images = imageRepository.findByRoomId(reservationAndRoom.getRoom().getId());
        return ReservationDetailResponse.of(reservationAndRoom, images);
    }
}
