package team07.airbnb.reservation.calculation;

import org.springframework.stereotype.Component;

import java.math.BigDecimal;

@Component
public abstract class ReservationFee {
	static final BigDecimal FEE_RATE = new BigDecimal("0.07");

	abstract BigDecimal apply(BigDecimal totalPrice);
}
