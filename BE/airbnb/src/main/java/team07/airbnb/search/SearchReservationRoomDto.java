package team07.airbnb.search;

import com.querydsl.core.annotations.QueryProjection;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class SearchReservationRoomDto {
	private Long roomId;

	@QueryProjection
	public SearchReservationRoomDto(Long roomId) {
		this.roomId = roomId;
	}
}
