package team07.airbnb.reservation.calculation;

import java.math.BigDecimal;

import lombok.AllArgsConstructor;
import team07.airbnb.reservation.Period;

@AllArgsConstructor
public class ReservationReport {
	private final Period period;
	private BigDecimal priceOfRoom;

	public ReservationReport(int priceOfRoom, Period period) {
		this.priceOfRoom = new BigDecimal(priceOfRoom);
		this.period = period;
	}

	boolean appliedPeriod(int days) {
		return period.isLonger(days);
	}

	public BigDecimal getPriceOfRoom() {
		return priceOfRoom;
	}

	public BigDecimal getMinus(BigDecimal discounted) {
		return this.priceOfRoom.subtract(discounted);
	}
}
