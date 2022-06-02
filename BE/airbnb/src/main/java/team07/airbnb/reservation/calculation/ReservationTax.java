package team07.airbnb.reservation.calculation;

import org.springframework.stereotype.Component;

import java.math.BigDecimal;

@Component
public class ReservationTax {
	private static final BigDecimal taxRate = new BigDecimal("0.1");

	BigDecimal apply(BigDecimal totalPrice) {
		return totalPrice.multiply(this.taxRate);
	}
}
