package team07.airbnb.reservation;


import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequiredArgsConstructor
public class ReservationController {
    private final ReservationService reservationService;

    @GetMapping("/reserve/{reservationId}")
    public ReservationDetailResponse detailReservation(@PathVariable Long reservationId) {
        return reservationService.findOne(reservationId);
    }
}
