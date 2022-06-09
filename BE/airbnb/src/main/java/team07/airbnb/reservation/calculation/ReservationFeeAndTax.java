package team07.airbnb.reservation.calculation;

import static team07.airbnb.reservation.calculation.ReservationFee.FEE_RATE;

import org.springframework.stereotype.Component;

import java.math.BigDecimal;

@Component
public class ReservationFeeAndTax implements FeeOrTax{
	private static final BigDecimal TAX_RATE = new BigDecimal("0.1");

	@Override
	public BigDecimal calculate(BigDecimal totalAmount) {
		BigDecimal fee = totalAmount.multiply(FEE_RATE);
		BigDecimal tax = fee.multiply(TAX_RATE);
		return fee.add(tax);
	}
}
