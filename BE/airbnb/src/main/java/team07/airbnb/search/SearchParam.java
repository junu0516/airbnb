package team07.airbnb.search;

import java.time.LocalDate;
import java.util.Objects;

import lombok.AccessLevel;
import lombok.NoArgsConstructor;

@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class SearchParam {
	private String location;
	private LocalDate startAt;
	private LocalDate endAt;
	private SearchPrice searchPrice;
	private int guestAmount;

	public SearchParam(String location, LocalDate startAt, LocalDate endAt, SearchPrice searchPrice, int guestAmount) {
		this.location = location;
		this.startAt = startAt;
		this.endAt = endAt;
		this.searchPrice = searchPrice;
		this.guestAmount = guestAmount;
	}

	public String getLocation() {
		return location;
	}

	public LocalDate getStartAt() {
		return startAt;
	}

	public LocalDate getEndAt() {
		return endAt;
	}

	public int getMaxPrice() {
		return Objects.isNull(searchPrice) ? 0 : searchPrice.getMaxPrice();
	}

	public int getMinPrice() {
		return Objects.isNull(searchPrice) ? 0 : searchPrice.getMinPrice();
	}

	public int getGuestAmount() {
		return guestAmount;
	}
}
