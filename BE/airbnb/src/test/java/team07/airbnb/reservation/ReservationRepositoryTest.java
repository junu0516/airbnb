package team07.airbnb.reservation;

import static org.assertj.core.api.Assertions.assertThat;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase;
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;
import org.springframework.test.context.ActiveProfiles;

import java.time.LocalDate;
import java.util.Arrays;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

import team07.airbnb.room.Room;
import team07.airbnb.room.RoomRepository;
import team07.airbnb.user.User;
import team07.airbnb.user.UserRepository;

@ActiveProfiles("dev")
@AutoConfigureTestDatabase(replace = AutoConfigureTestDatabase.Replace.NONE)
@DataJpaTest
class ReservationRepositoryTest {
	private static final int[] startAtArr = {9, 16};
	public static final long ROOM_ID = 1L;
	private final ReservationRepository reservationRepository;
	private final UserRepository userRepository;
	private final RoomRepository roomRepository;

	private Room room;
	private User user;

	public ReservationRepositoryTest(
		@Autowired ReservationRepository reservationRepository,
		@Autowired UserRepository userRepository,
		@Autowired RoomRepository roomRepository) {
		this.reservationRepository = reservationRepository;
		this.userRepository = userRepository;
		this.roomRepository = roomRepository;
	}

	@BeforeEach
	void beforeEach() {
		user = userRepository.findById(ROOM_ID).orElseThrow(() -> new RuntimeException("error of user"));
		room = roomRepository.findById(ROOM_ID).orElseThrow(() -> new RuntimeException("error"));
		for (Reservation reservation : getReservation()) {
			reservationRepository.save(reservation);
		}
	}

	@Test
	@DisplayName("요청받은 숙소의 예약 날짜기간에 대해 해당 숙소의 예약 날짜들과 겹치지 않음을 확인한다.")
	void make_reservation_date() {
		int emptyDate = startAtArr[1] + 5;
		LocalDate startAt = LocalDate.of(2022, 5, emptyDate);
		LocalDate endAt = LocalDate.of(2022, 5, emptyDate + 4);
		Optional<Reservation> actual = reservationRepository.findFirstByRoomIdAndStartAtBetweenOrEndAtBetween(
			ROOM_ID,
			startAt, endAt,
			startAt, endAt);

		assertThat(actual.isEmpty()).isTrue();
	}

	@Test
	@DisplayName("요청받은 숙소의 예약 날짜기간에 대해 해당 숙소의 예약 날짜들과 중복됨을 확인한다.")
	void not_make_reservation_because_of_full() {
		int filledDate = startAtArr[1];
		LocalDate startAt = LocalDate.of(2022, 5, filledDate);
		LocalDate endAt = LocalDate.of(2022, 5, filledDate + 1);
		Optional<Reservation> actual = reservationRepository.findFirstByRoomIdAndStartAtBetweenOrEndAtBetween(
			ROOM_ID,
			startAt, endAt,
			startAt, endAt);

		assertThat(actual.isEmpty()).isFalse();
	}

	@Test
	@DisplayName("예약 요청에 대해 다른 숙소의 부분 기간이 중복되는 날짜이지만, 해당하지 않은 숙소는 예약 가능하다")
	void reservation_room() {
		int filledDate = startAtArr[1];
		LocalDate startAt = LocalDate.of(2022, 5, filledDate);
		LocalDate endAt = LocalDate.of(2022, 5, filledDate + 1);
		Optional<Reservation> actual = reservationRepository.findFirstByRoomIdAndStartAtBetweenOrEndAtBetween(
			2L,
			startAt, endAt,
			startAt, endAt);
		assertThat(actual.isEmpty()).isTrue();
		assertThat(actual.isPresent()).isFalse();
	}
	@Test
	@DisplayName("1일 예약 요청에 대해 해당 숙소의 예약날짜와 중복 여부 확인한다.")
	void reservation_one_day() {
		int filledDate = startAtArr[1]+1;
		LocalDate oneDay = LocalDate.of(2022, 5, filledDate);
		Optional<Reservation> actual = reservationRepository.findFirstByRoomIdAndStartAtLessThanEqualAndEndAtGreaterThanEqual(
			ROOM_ID,
			oneDay,
			oneDay);

		assertThat(actual.isEmpty()).isFalse();
	}

	@Test
	@DisplayName("기간내 수일 예약 요청에 대해 해당 숙소의 예약날짜와 중복 여부 확인한다.")
	void invalid_reservation_duplicated_date() {
		int filledDate = startAtArr[1]+1;
		LocalDate startAt = LocalDate.of(2022, 5, filledDate);
		LocalDate endAt = LocalDate.of(2022, 5, filledDate+1);
		Optional<Reservation> actual = reservationRepository.findFirstByRoomIdAndStartAtLessThanEqualAndEndAtGreaterThanEqual(
			ROOM_ID,
			startAt,
			endAt);

		assertThat(actual.isEmpty()).isFalse();
	}

	@Test
	@DisplayName("기간내 수일 예약 요청에 대해 다른 숙소는 예약 가능하다.")
	void reservation_date() {
		int filledDate = startAtArr[1]+1;
		LocalDate startAt = LocalDate.of(2022, 5, filledDate);
		LocalDate endAt = LocalDate.of(2022, 5, filledDate+1);
		Optional<Reservation> actual = reservationRepository.findFirstByRoomIdAndStartAtLessThanEqualAndEndAtGreaterThanEqual(
			2L,
			startAt,
			endAt);

		assertThat(actual.isEmpty()).isTrue();
	}

	//  9 ~ 13
	// 16 ~ 20
	private List<Reservation> getReservation() {
		int days = 4;
		return Arrays.stream(startAtArr)
			.mapToObj(startAt -> {
				int endAt = startAt + days;
				int totalPrice = 340000 * (endAt - startAt + 1);
				return new Reservation(room, user, LocalDate.of(2022, 5, startAt), LocalDate.of(2022, 5, endAt), 3,
					totalPrice);
			}).collect(Collectors.toList());
	}
}
