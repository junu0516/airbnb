package team07.airbnb.reservation.calculation;

import org.springframework.stereotype.Component;

import java.math.BigDecimal;

@Component
public class ReservationFee {
	private static final BigDecimal feeRate = new BigDecimal("0.07");

	public BigDecimal apply(BigDecimal totalPrice) {
		return totalPrice.multiply(this.feeRate);
	}
}
