package team07.airbnb.search;

import static org.assertj.core.api.Assertions.assertThat;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.Arguments;
import org.junit.jupiter.params.provider.MethodSource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.ActiveProfiles;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.util.List;
import java.util.stream.Stream;

import team07.airbnb.reservation.Period;

@ActiveProfiles("dev")
@SpringBootTest
@Transactional
class SearchRepositoryImplTest {
	private final SearchRepositoryImpl searchRepository;

	public SearchRepositoryImplTest(@Autowired SearchRepositoryImpl searchRepository) {
		this.searchRepository = searchRepository;
	}

	// todo 테스트용 데이터 통한 테스트

	@Test
	@DisplayName("최소 검색어 지역명 검색 요청에 대한 조회 결과를 확인한다.")
	void check_result_of_searching_by_location() {
		SearchParam searchParam = new SearchParam("강원", LocalDate.now(), LocalDate.now().plusDays(30), null, 0);
		List<SearchRoomDto> roomCards = searchRepository.searchLocation(searchParam, List.of(1L));

		if (roomCards.size() > 0) {
			roomCards.stream().forEach(System.out::println);
		}
		assertThat(roomCards).extracting("address.roomState").contains("강원도");
	}

	@ParameterizedTest(name = "{index} 예약 기간이 겹친 날짜")
	@MethodSource("reservationDates")
	@DisplayName("요청 기간내 예약된 숙소 목록 조회 결과를 확인한다.")
	void check_list_of_reservation_within_period_of_request(Period period) {
		List<SearchReservationRoomDto> reservationDate = searchRepository.findByReservationDate(period);

		assertThat(reservationDate).hasSizeGreaterThan(0);
	}

	private static Stream<Arguments> reservationDates() {
		return Stream.of(
			Arguments.of(Period.of(LocalDate.of(2022, 5, 15), LocalDate.of(2022, 05, 17))),
			Arguments.of(Period.of(LocalDate.of(2022, 5, 14), LocalDate.of(2022, 05, 18)))
		);
	}
}
