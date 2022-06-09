package team07.airbnb.reservation.calculation;

import org.springframework.stereotype.Component;

import java.math.BigDecimal;

@Component
public class WeeklyDiscountPolicy extends DiscountPolicy{
	public static final BigDecimal NONE_DISCOUNTED_AMOUNT = BigDecimal.ZERO;
	private static final int discountConditionDays = 7;
	private static final BigDecimal weeklyDiscountRate = new BigDecimal("0.04");

	public WeeklyDiscountPolicy(FeeOrTax... feeOrTaxes) {
		super(feeOrTaxes);
	}

	@Override
	public BigDecimal getDiscounted(ReservationReport reservationReport) {
		if (reservationReport.appliedPeriod(discountConditionDays)) {
			return reservationReport.getPriceOfRoom().multiply(weeklyDiscountRate);
		}
		return NONE_DISCOUNTED_AMOUNT;
	}
}
