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

	protected static Period of(LocalDate startAt, LocalDate endAt) {
		return new Period(startAt, endAt);
	}

	protected boolean isAbove(int range) {
		long between = ChronoUnit.DAYS.between(this.startAt, this.endAt);
		return between >= range;
	}

	protected LocalDate startAt() {
		return this.startAt;
	}

	protected LocalDate endAt() {
		return this.endAt;
	}
}
