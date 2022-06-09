package team07.airbnb.reservation.calculation;

import java.math.BigDecimal;

public interface FeeOrTax {
	BigDecimal calculate(BigDecimal totalAmount);
}
