package team07.airbnb.reservation;

import java.time.LocalDate;
import java.time.temporal.ChronoUnit;

public class Period {
	private final LocalDate startAt;
	private final LocalDate endAt;

	private Period(LocalDate startAt, LocalDate endAt) {
		this.startAt = startAt;
		this.endAt = endAt;
	}

	static Period of(LocalDate startAt, LocalDate endAt) {
		return new Period(startAt, endAt);
	}

	boolean isLonger(int range) {
		long between = ChronoUnit.DAYS.between(this.startAt, this.endAt);
		return between >= range;
	}

	LocalDate startAt() {
		return this.startAt;
	}

	LocalDate endAt() {
		return this.endAt;
	}
}
