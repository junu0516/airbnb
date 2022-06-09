package team07.airbnb.search;

import com.querydsl.core.annotations.QueryProjection;

import java.math.BigDecimal;

import lombok.Data;
import lombok.NoArgsConstructor;
import team07.airbnb.address.Address;
import team07.airbnb.reservation.Period;

@Data
@NoArgsConstructor
public class SearchRoomDto {
	private Long roomId;
	private String roomName;
	private int price;
	private String thumbnailImage;
	private boolean isWished;
	private Address address;

	@QueryProjection
	public SearchRoomDto(Long roomId, String roomName, int price, String thumbnailImage, boolean isWished,
		Address address) {
		this.roomId = roomId;
		this.roomName = roomName;
		this.price = price;
		this.thumbnailImage = thumbnailImage;
		this.isWished = isWished;
		this.address = address;
	}

	public BigDecimal getLongitude() {
		return this.address.getRoomLongitude();
	}

	public BigDecimal getLatitude() {
		return this.address.getRoomLatitude();
	}

	public int calculateTotalPrice(Period period) {
		return BigDecimal.valueOf(this.price).multiply(period.getDays()).intValueExact();
	}
}
