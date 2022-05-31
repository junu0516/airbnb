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

	protected void applyGuest(Period period, int numberOfGuest, int totalPrice) {
		this.period = period;
		this.numberOfGuest = numberOfGuest;
		this.totalPrice = totalPrice;
	}

	protected String getTitle() {
		return title;
	}

	protected String getAddress() {
		return address;
	}

	protected String getHostName() {
		return hostName;
	}

	protected LocalDate checkIn() {
		return period.startAt();
	}

	protected LocalDate checkOut() {
		return period.endAt();
	}

	protected int getNumberOfGuest() {
		return numberOfGuest;
	}

	protected int getTotalPrice() {
		return totalPrice;
	}
}
