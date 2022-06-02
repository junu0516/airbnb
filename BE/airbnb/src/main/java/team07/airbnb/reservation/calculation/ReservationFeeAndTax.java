package team07.airbnb.reservation.calculation;

import org.springframework.stereotype.Component;

import java.math.BigDecimal;

@Component
public class ReservationFeeAndTax extends ReservationFee{
	private static final BigDecimal TAX_RATE = new BigDecimal("0.1");

	@Override
	BigDecimal apply(BigDecimal totalPrice) {
		BigDecimal fee = totalPrice.multiply(FEE_RATE);
		BigDecimal tax = fee.multiply(TAX_RATE);
		return fee.add(tax);
	}
}
