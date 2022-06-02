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
    public void make(ReservationRequestDto request) {
        Period period = Period.of(request.getCheckIn(), request.getCheckOut());
        isValidDate(request, period);

        Room roomInfo = roomService.getRoom(request.getRoomId());
        ReservationCalculator reservationCalculator = roomInfo.toCalculator();
        if (reservationCalculator.isNotSame(request.getTotalPrice(), period)) {
            throw new RuntimeException("요청 예약 금액이 유효하지 않습니다.");
        }

        User guestInfo = userService.get(request.getGuestId());
        reservationRepository.save(Reservation.builder()
                .room(roomInfo)
                .user(guestInfo)
                .startAt(period.startAt())
                .endAt(period.endAt())
                .numberOfGuest(request.getGuestAmount())
                .totalPrice(request.getTotalPrice())
            .build());
    }

    @Transactional(readOnly = true)
    public ReservationDetailResponse findOne(Long reservationId) {
        Reservation reservationAndRoom = reservationPureRepository.findReservationWithRoomAndHost(reservationId);
        List<Image> images = imageRepository.findByRoomId(reservationAndRoom.reservedNo());
        return ReservationDetailResponse.of(reservationAndRoom.getInfo(), images);
    }

    private void isValidDate(ReservationRequestDto request, Period period) {
        isAlreadyReservationRoom(request.getRoomId(), period);
        isFewDaysAlreadyReservationRoom(request.getRoomId(), period);
    }

    private void isAlreadyReservationRoom(Long roomId, Period period) {
        Optional<Reservation> reservationed = reservationRepository.findFirstByRoomIdAndStartAtLessThanEqualAndEndAtGreaterThanEqual(
            roomId,
            period.startAt(),
            period.endAt());

        if (reservationed.isPresent()) {
            throw new RuntimeException("방을 예약하려는 날짜에 이미 예약이 차있습니다.");
        }
    }

    private void isFewDaysAlreadyReservationRoom(Long roomId, Period period) {
        Optional<Reservation> reservationed = reservationRepository.findFirstByRoomIdAndStartAtBetweenOrEndAtBetween(
            roomId,
            period.startAt(), period.endAt(),
            period.startAt(),  period.endAt());

        if (reservationed.isPresent()) {
            throw new RuntimeException("일부 날짜는 예약 할 수 없습니다.");
        }
    }
}
