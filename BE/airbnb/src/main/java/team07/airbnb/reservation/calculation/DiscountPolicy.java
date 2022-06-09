package team07.airbnb.reservation.calculation;

import java.math.BigDecimal;
import java.util.Arrays;
import java.util.List;

public abstract class DiscountPolicy {
	private final List<FeeOrTax> feeOrTaxList;

	public DiscountPolicy(FeeOrTax... feeOrTaxes) {
		this.feeOrTaxList = Arrays.asList(feeOrTaxes);
	}

	public BigDecimal settle(ReservationReport reservationReport) {
		BigDecimal discountedAmount = reservationReport.getMinus(getDiscounted(reservationReport));
		return this.feeOrTaxList.stream()
			.map(feeOrTax -> feeOrTax.calculate(discountedAmount))
			.reduce(discountedAmount, BigDecimal::add);
	}

	abstract BigDecimal getDiscounted(ReservationReport reservationReport);
}
