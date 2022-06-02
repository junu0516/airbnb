package team07.airbnb.search;

import team07.airbnb.reservation.Period;

public class SearchParam {
	private final String location;
	private final Period period;
	private final SearchPrice searchPrice;
	private final int guestAmount;

	public SearchParam(String location, Period period, SearchPrice searchPrice, int guestAmount) {
		this.location = location;
		this.period = period;
		this.searchPrice = searchPrice;
		this.guestAmount = guestAmount;
	}
}
