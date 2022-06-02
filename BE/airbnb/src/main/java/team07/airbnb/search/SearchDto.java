package team07.airbnb.search;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

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
		private final int numberOfRooms;
		private final List<RoomCard> rooms = new ArrayList<>();

		public RoomsResponse(int numberOfRooms) {
			this.numberOfRooms = numberOfRooms;
		}
	}

	public static class RoomCard {
		private final Long roomId;
		private final String roomName;
		private final int price;
		private final int totalPrice;
		private final String thumbnailImage;
		private final String averageOfStar;
		private final int numberOfReviews;
		private final boolean isWished;
		private final String latitude;
		private final String logitude;

		public RoomCard(Long roomId, String roomName, int price, int totalPrice, String thumbnailImage,
			String averageOfStar, int numberOfReviews, boolean isWished, String latitude, String logitude) {
			this.roomId = roomId;
			this.roomName = roomName;
			this.price = price;
			this.totalPrice = totalPrice;
			this.thumbnailImage = thumbnailImage;
			this.averageOfStar = averageOfStar;
			this.numberOfReviews = numberOfReviews;
			this.isWished = isWished;
			this.latitude = latitude;
			this.logitude = logitude;
		}
	}
}
