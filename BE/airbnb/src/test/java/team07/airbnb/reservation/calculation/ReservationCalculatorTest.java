package team07.airbnb.reservation.calculation;

import static org.junit.jupiter.api.Assertions.*;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.time.LocalDate;

import team07.airbnb.reservation.Period;

@SpringBootTest
class ReservationCalculatorTest {
	@Autowired
	private ReservationCalculator reservationCalculator;
	private int priceForOneDay = 340000;
	private int totalPrice = 1491920;

	@Test
	void verify_calculation_of_reservation() {
		assertDoesNotThrow(() ->
			this.reservationCalculator
				.isValid(
					totalPrice,
					getReservationReport(priceForOneDay, getPeriod())));
	}

	@Test
	void verify_exception_when_calculate_reservation_total_price() {
		assertThrows(RuntimeException.class,() ->
			this.reservationCalculator
				.isValid(
					totalPrice-1,
					getReservationReport(priceForOneDay, getPeriod())));
	}

	private Period getPeriod() {
		return Period.of(LocalDate.of(2022, 5, 9), LocalDate.of(2022, 5, 13));
	}

	private ReservationReport getReservationReport(int priceForOneDay, Period period) {
		return new ReservationReport(priceForOneDay, period);
	}
}
