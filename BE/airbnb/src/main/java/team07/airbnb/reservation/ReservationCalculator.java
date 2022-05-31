package team07.airbnb.reservation;

import java.math.BigDecimal;

public class ReservationCalculator {
	private static final int discountConditionDays = 7;
	private static final BigDecimal weeklyDiscountRate = new BigDecimal("0.04");
	private static final BigDecimal ratioOfCleaningFee = new BigDecimal("0.02");
	private static final BigDecimal feeRate = new BigDecimal("0.07");
	private static final BigDecimal taxRate = new BigDecimal("0.1");
	private BigDecimal totalPrice;

	public ReservationCalculator(int primeCost) {
		this.totalPrice = new BigDecimal(primeCost);
	}

	public static ReservationCalculator of(int price) {
		return new ReservationCalculator(price);
	}

	public boolean isNotSame(int totalPrice, Period period) {
		int calculate = this.calculate(period);
		return calculate != totalPrice;
	}

	private int calculate(Period period) {
		if (period.isAbove(discountConditionDays)) { // 7일 이상 할인 여부
			totalPrice = totalPrice.subtract(totalPrice.multiply(weeklyDiscountRate));
		}
		BigDecimal cleaningFee = totalPrice.multiply(ratioOfCleaningFee);
		BigDecimal fee = totalPrice.multiply(feeRate);
		BigDecimal tax = fee.multiply(taxRate);
		// 총 금액
		BigDecimal payment = totalPrice.subtract(cleaningFee).subtract(fee).subtract(tax);
		return payment.intValueExact();
	}
}
