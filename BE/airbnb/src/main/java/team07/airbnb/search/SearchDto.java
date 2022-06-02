package team07.airbnb.search;

import java.time.LocalDate;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

import lombok.Data;
import lombok.NoArgsConstructor;
import team07.airbnb.reservation.Period;
import team07.airbnb.reservation.calculation.WeeklyDiscountPolicy;

public class SearchDto {
	@Data
	@NoArgsConstructor
	public static class LocationRequest {
		@NotNull
		@Size(min = 2)
		private String location;
		private LocalDate checkinDate;
		private LocalDate checkoutDate;
		private int minPrice;
		private int maxPrice;
		private int guestAmount;
		private int infantAmount;

		public SearchParam toSearchParam() {
			Period period = Period.of(checkinDate, checkoutDate);
			return new SearchParam(
				location,
				period,
				getSearchPrice(period),
				guestAmount
			);
		}

		private SearchPrice getSearchPrice(Period period) {
			return SearchPrice.builder()
				.weeklyDiscountPolicy(new WeeklyDiscountPolicy())
				.period(period)
				.minPrice(minPrice)
				.maxPrice(maxPrice)
				.build();
		}
	}

	public static class RoomsResponse {
	}
}
