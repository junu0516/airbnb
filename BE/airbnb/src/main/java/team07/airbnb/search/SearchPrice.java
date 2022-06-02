package team07.airbnb.search;

import java.math.BigDecimal;

import lombok.AccessLevel;
import lombok.Builder;
import team07.airbnb.reservation.Period;
import team07.airbnb.reservation.calculation.ReservationReport;
import team07.airbnb.reservation.calculation.WeeklyDiscountPolicy;

public class SearchPrice {
	private final WeeklyDiscountPolicy weeklyDiscountPolicy;
	private final ReservationReport minPriceInfo;
	private final ReservationReport maxPriceInfo;
	private final int minPrice;
	private final int maxPrice;

	@Builder(access = AccessLevel.PACKAGE)
	public SearchPrice(WeeklyDiscountPolicy weeklyDiscountPolicy,
		Period period, int minPrice, int maxPrice) {
		this.weeklyDiscountPolicy = weeklyDiscountPolicy;
		this.minPriceInfo = new ReservationReport(minPrice, period);
		this.maxPriceInfo = new ReservationReport(maxPrice, period);
		this.minPrice = minPrice;
		this.maxPrice = maxPrice;
	}

	public int minPriceOfWeeklyDiscount() {
		BigDecimal minDiscounted = this.weeklyDiscountPolicy.getDiscounted(minPriceInfo);
		return minDiscounted.intValueExact();
	}

	public int maxPriceOfWeeklyDiscount() {
		BigDecimal maxDiscounted = this.weeklyDiscountPolicy.getDiscounted(maxPriceInfo);
		return maxDiscounted.intValueExact();
	}
}
