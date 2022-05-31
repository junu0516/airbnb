package team07.airbnb.reservation;

import java.util.List;
import java.util.Optional;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import team07.airbnb.image.Image;
import team07.airbnb.image.ImageRepository;
import team07.airbnb.room.Room;
import team07.airbnb.room.RoomService;
import team07.airbnb.user.User;
import team07.airbnb.user.UserService;

@Service
@RequiredArgsConstructor
@Transactional
public class ReservationService {
    private final UserService userService;
    private final RoomService roomService;

    private final ReservationPureRepository reservationPureRepository;
    private final ReservationRepository reservationRepository;
    private final ImageRepository imageRepository;

    /**
     * 게스트 확인
     * 숙소 조회 -> 예약 가능여부 및 가격 검증
     * 예약 저장
     * @param request
     */
    @Transactional
    public void make(ReservationRequestDto request) {
        Period period = Period.of(request.getCheckIn(), request.getCheckOut());
        isValidDate(request, period);

        Room roomInfo = roomService.getRoom(request.getRoomId());
        ReservationCalculator reservationCalculator = roomInfo.toCalculator();
        if (reservationCalculator.isNotSame(request.getTotalPrice(), period)) {
            throw new RuntimeException("cannot make reservation");
        }

        User guestInfo = userService.get(request.getGuestId());
        reservationRepository.save(Reservation.of(
            roomInfo,
            guestInfo,
            period.startAt(),
            period.endAt(),
            request.getGuestAmount(),
            request.getTotalPrice()));
    }

    @Transactional(readOnly = true)
    public ReservationDetailResponse findOne(Long reservationId) {
        Reservation reservationAndRoom = reservationPureRepository.findReservationWithRoomAndHost(reservationId);
        List<Image> images = imageRepository.findByRoomId(reservationAndRoom.reservedNo());
        return ReservationDetailResponse.of(reservationAndRoom.getInfo(), images);
    }

    private void isValidDate(ReservationRequestDto request, Period period) {
        isWithin(request.getRoomId(), period);
        isInvolved(request.getRoomId(), period);
    }

    private void isInvolved(Long roomId, Period period) {
        Optional<Reservation> reservationed = reservationRepository.findFirstByRoomIdAndStartAtBetweenOrEndAtBetween(
            roomId,
            period.startAt(), period.endAt(),
            period.startAt(),  period.endAt());

        if (reservationed.isPresent()) {
            throw new RuntimeException("make no reservation");
        }
    }

    private void isWithin(Long roomId, Period period) {
        Optional<Reservation> reservationed = reservationRepository.findFirstByRoomIdAndStartAtLessThanEqualAndEndAtGreaterThanEqual(
            roomId,
            period.startAt(),
            period.endAt());

        if (reservationed.isPresent()) {
            throw new RuntimeException("make no reservation");
        }
    }
}
