package team07.airbnb.reservation.calculation;

import org.springframework.stereotype.Component;

import java.math.BigDecimal;

import lombok.RequiredArgsConstructor;
import team07.airbnb.reservation.Period;

@RequiredArgsConstructor
@Component
public class ReservationCalculator {
	private final WeeklyDiscountPolicy weeklyDiscountPolicy;
	private final RoomCleaningFee roomCleaningFee;
	private final ReservationFee reservationFee;
	private final ReservationTax reservationTax;
	private ReservationReport reservationReport;

	public void add(ReservationReport reservationReport) {
		this.reservationReport = reservationReport;
	}

	public boolean isNotSame(int totalPrice, Period period) {
		int calculate = this.calculate(period);
		return calculate != totalPrice;
	}

	private int calculate(Period period) {
		BigDecimal weeklyDiscounted = this.weeklyDiscountPolicy.getDiscounted(this.reservationReport);
		BigDecimal totalPrice = this.reservationReport.getMinus(weeklyDiscounted);

		BigDecimal cleaningFee = roomCleaningFee.apply(totalPrice);
		BigDecimal fee = reservationFee.apply(totalPrice);
		BigDecimal tax = reservationTax.apply(fee);
		// 총 금액
		BigDecimal payment = totalPrice.subtract(cleaningFee).subtract(fee).subtract(tax);
		return payment.intValueExact();
	}
}
