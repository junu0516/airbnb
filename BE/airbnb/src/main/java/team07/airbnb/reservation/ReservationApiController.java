package team07.airbnb.reservation;


import lombok.RequiredArgsConstructor;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;

import javax.validation.Valid;

@RequiredArgsConstructor
@RequestMapping("/airbnb/room/make/reservation")
@RestController
public class ReservationApiController {
    private final ReservationService reservationService;

    @ResponseStatus(HttpStatus.CREATED)
    @PostMapping
    public void makeReservation(@Valid @RequestBody ReservationRequestDto request) {
        reservationService.make(request);
    }

    @GetMapping("/{reservationId}")
    public ReservationDetailResponse detailReservation(@PathVariable Long reservationId) {
        return reservationService.findOne(reservationId);
    }
}
