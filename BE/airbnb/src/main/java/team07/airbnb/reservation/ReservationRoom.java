package team07.airbnb.reservation;

import java.time.LocalDate;

public class ReservationRoom {
	private final String title;
	private final String address;
	private final String hostName;
	private Period period;
	private int numberOfGuest;
	private int totalPrice;

	public ReservationRoom(String title, String address, String hostNickName) {
		this.title = title;
		this.address = address;
		this.hostName = hostNickName;
	}

	void applyGuest(Period period, int numberOfGuest, int totalPrice) {
		this.period = period;
		this.numberOfGuest = numberOfGuest;
		this.totalPrice = totalPrice;
	}

	String getTitle() {
		return title;
	}

	String getAddress() {
		return address;
	}

	String getHostName() {
		return hostName;
	}

	LocalDate checkIn() {
		return period.startAt();
	}

	LocalDate checkOut() {
		return period.endAt();
	}

	int getNumberOfGuest() {
		return numberOfGuest;
	}

	int getTotalPrice() {
		return totalPrice;
	}
}
