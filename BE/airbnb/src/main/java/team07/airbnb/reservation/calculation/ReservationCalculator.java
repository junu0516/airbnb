package team07.airbnb.reservation.calculation;

import org.springframework.stereotype.Component;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Component
public class ReservationCalculator {
	private final DiscountPolicy discountPolicy;

	public void isValid(int totalPrice, ReservationReport reservationReport) {
		if (this.isNotSame(totalPrice, reservationReport)) {
			throw new RuntimeException("요청 예약 금액이 유효하지 않습니다.");
		}
	}

	private boolean isNotSame(int totalPrice, ReservationReport reservationReport) {
		int calculate = discountPolicy.settle(reservationReport).intValue();
		return calculate != totalPrice;
	}
}
