package team07.airbnb.reservation.calculation;

import org.springframework.stereotype.Component;

import java.math.BigDecimal;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Component
public class ReservationCalculator {
	private final WeeklyDiscountPolicy weeklyDiscountPolicy;
	private final RoomCleaningFee roomCleaningFee;
	private final ReservationFeeAndTax reservationFeeAndTax;
	private ReservationReport reservationReport;

	public void add(ReservationReport reservationReport) {
		this.reservationReport = reservationReport;
	}

	public void isValid(int totalPrice) {
		if (this.isNotSame(totalPrice)) {
			throw new RuntimeException("요청 예약 금액이 유효하지 않습니다.");
		}
	}

	private boolean isNotSame(int totalPrice) {
		int calculate = this.calculate();
		return calculate != totalPrice;
	}

	private int calculate() {
		BigDecimal weeklyDiscounted = this.weeklyDiscountPolicy.getDiscounted(this.reservationReport);
		BigDecimal totalPrice = this.reservationReport.getMinus(weeklyDiscounted);

		BigDecimal cleaningFee = roomCleaningFee.apply(totalPrice);
		BigDecimal feeAndTax = reservationFeeAndTax.apply(totalPrice);
		// 총 금액
		BigDecimal payment = totalPrice.subtract(cleaningFee).subtract(feeAndTax);
		return payment.intValueExact();
	}
}
