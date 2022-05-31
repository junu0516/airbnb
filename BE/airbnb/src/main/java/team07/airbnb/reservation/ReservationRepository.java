package team07.airbnb.reservation;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.repository.query.Param;

import java.time.LocalDate;
import java.util.Optional;

public interface ReservationRepository extends JpaRepository<Reservation, Long> {
	Optional<Reservation> findFirstByRoomIdAndStartAtBetweenOrEndAtBetween(
		@Param("roomId") Long roomId,
		@Param("checkInA") LocalDate checkInA, @Param("checkOutA") LocalDate checkOutA,
		@Param("checkInB") LocalDate checkInB, @Param("checkOutB")LocalDate checkOutB);

	Optional<Reservation> findFirstByRoomIdAndStartAtLessThanEqualAndEndAtGreaterThanEqual(
		@Param("roomId") Long roomId,
		@Param("dayA") LocalDate oneDayA,
		@Param("dayB") LocalDate oneDayB);
}
