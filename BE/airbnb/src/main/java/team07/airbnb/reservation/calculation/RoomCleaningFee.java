package team07.airbnb.reservation.calculation;

import org.springframework.stereotype.Component;

import java.math.BigDecimal;

@Component
public class RoomCleaningFee implements FeeOrTax{
	private static final BigDecimal ratioOfCleaningFee = new BigDecimal("0.02");

	@Override
	public BigDecimal calculate(BigDecimal totalAmount) {
		return totalAmount.multiply(this.ratioOfCleaningFee);
	}
}
