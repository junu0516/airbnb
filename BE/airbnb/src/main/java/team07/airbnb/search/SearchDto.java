package team07.airbnb.search;

import static team07.airbnb.search.SearchDto.LocationRequestFields.CHECKIN_DATE;
import static team07.airbnb.search.SearchDto.LocationRequestFields.CHECKOUT_DATE;
import static team07.airbnb.search.SearchDto.LocationRequestFields.GUEST_AMOUNT;
import static team07.airbnb.search.SearchDto.LocationRequestFields.LOCATION;
import static team07.airbnb.search.SearchDto.LocationRequestFields.MAX_PRICE;
import static team07.airbnb.search.SearchDto.LocationRequestFields.MIN_PRICE;

import org.apache.logging.log4j.util.Strings;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Map;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.RequiredArgsConstructor;
import team07.airbnb.reservation.Period;
import team07.airbnb.reservation.calculation.WeeklyDiscountPolicy;

public class SearchDto {
	@Getter
	@RequiredArgsConstructor
	enum LocationRequestFields {
		LOCATION("request[location]"),
		CHECKIN_DATE("request[checkinDate]"),
		CHECKOUT_DATE("request[checkoutDate]"),
		MIN_PRICE("request[minPrice]"),
		MAX_PRICE("request[maxPrice]"),
		GUEST_AMOUNT("request[guestAmount]");

		private final String text;
	}
	@Data
	@AllArgsConstructor
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

		public static LocationRequest of(Map<String, Object> request) {
			return new LocationRequest(
				(String)request.get(LOCATION.getText()),
				toCheckIn(request),
				toCheckout(request),
				Integer.parseInt((String)request.get(MIN_PRICE.getText())),
				Integer.parseInt((String)request.get(MAX_PRICE.getText())),
				Integer.parseInt((String)request.get(GUEST_AMOUNT.getText())));
			}

		/**
		 * toCheckIn(), toCheckout()
		 * - 요청 데이터에서 날짜가 null 일 경우, 요청 날짜 ~ 요청날짜 + 30일 이후의 날짜로 변환
		 * @param request
		 * @return
		 */
		private static LocalDate toCheckout(Map<String, Object> request) {
			if (Strings.isBlank((String)request.get(CHECKOUT_DATE.getText()))) {
				return LocalDate.now().plusDays(30);
			}

			if (request.get(CHECKOUT_DATE.getText()) instanceof String) {
				return LocalDate.parse((CharSequence)request.get(CHECKOUT_DATE.getText()),
					DateTimeFormatter.ISO_DATE);
			}
			return LocalDate.now().plusDays(30);
		}

		private static LocalDate toCheckIn(Map<String, Object> request) {
			if (Strings.isBlank((String)request.get(CHECKIN_DATE.getText()))) {
				return LocalDate.now();
			}
			if (request.get(CHECKIN_DATE.getText()) instanceof String) {
				return LocalDate.parse((CharSequence)request.get(CHECKIN_DATE.getText()), DateTimeFormatter.ISO_DATE);
			}
			return LocalDate.now();
		}

		public SearchParam toSearchParam() {
			return new SearchParam(
				location.trim(),
				checkinDate,
				checkoutDate,
				getSearchPrice(getPeriod()),
				guestAmount
			);
		}

		public Period getPeriod() {
			return Period.of(checkinDate, checkoutDate);
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

	@Data
	public static class RoomsResponse {
		private final int numberOfRooms;
		private final List<RoomCard> rooms;

		public RoomsResponse(int numberOfRooms, List<RoomCard> rooms) {
			this.numberOfRooms = numberOfRooms;
			this.rooms = rooms;
		}
	}

	@Data
	public static class RoomCard {
		private Long roomId;
		private String roomName;
		private int price;
		private int totalPrice;
		private String thumbnailImage;
		private boolean isWished;
		private BigDecimal latitude;
		private BigDecimal longitude;

		@Builder
		public RoomCard(Long roomId, String roomName, int price, int totalPrice, String thumbnailImage,
			boolean isWished,
			BigDecimal latitude, BigDecimal longitude) {
			this.roomId = roomId;
			this.roomName = roomName;
			this.price = price;
			this.totalPrice = totalPrice;
			this.thumbnailImage = thumbnailImage;
			this.isWished = isWished;
			this.latitude = latitude;
			this.longitude = longitude;
		}
	}
}
