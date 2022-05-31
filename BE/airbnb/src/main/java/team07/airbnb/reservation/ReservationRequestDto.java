package team07.airbnb.reservation;

import java.time.LocalDate;

import javax.validation.constraints.Min;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Positive;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class ReservationRequestDto {
	@NotNull @Positive
	private Long roomId;
	@NotNull @Positive
	private Long guestId;
	@NotNull
	private LocalDate checkIn;
	@NotNull
	private LocalDate checkOut;
	@Positive
	private int guestAmount;
	@Min(11000)
	private int priceForOneDay;
	@Min(0)
	private int discountedPricePerWeek;
	@Positive
	private int cleaningPrice;
	@Positive
	private int fee;
	@Positive
	private int tax;
	@Positive
	private int totalPrice;

	public ReservationRequestDto(Long roomId, Long guestId, LocalDate checkIn, LocalDate checkOut, int guestAmount,
		int priceForOneDay, int discountedPricePerWeek, int cleaningPrice, int fee, int tax, int totalPrice) {
		this.roomId = roomId;
		this.guestId = guestId;
		this.checkIn = checkIn;
		this.checkOut = checkOut;
		this.guestAmount = guestAmount;
		this.priceForOneDay = priceForOneDay;
		this.discountedPricePerWeek = discountedPricePerWeek;
		this.cleaningPrice = cleaningPrice;
		this.fee = fee;
		this.tax = tax;
		this.totalPrice = totalPrice;
	}
}
