package team07.airbnb.search;

import java.util.List;

import team07.airbnb.reservation.Period;

public interface SearchRepository {
	List<SearchRoomDto> searchLocation(SearchParam searchParam, List<Long> reservationList);

	List<SearchReservationRoomDto> findByReservationDate(Period period);
}
