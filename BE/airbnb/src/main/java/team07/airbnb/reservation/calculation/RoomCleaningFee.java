package team07.airbnb.reservation.calculation;

import org.springframework.stereotype.Component;

import java.math.BigDecimal;

@Component
public class RoomCleaningFee {
	private static final BigDecimal ratioOfCleaningFee = new BigDecimal("0.02");

	BigDecimal apply(BigDecimal totalPrice) {
		return totalPrice.multiply(this.ratioOfCleaningFee);
	}
}
