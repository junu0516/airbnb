package team07.airbnb.reservation;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;

public class Period {
	private final LocalDate startAt;
	private final LocalDate endAt;

	private Period(LocalDate startAt, LocalDate endAt) {
		this.startAt = startAt;
		this.endAt = endAt;
	}

	public static Period of(LocalDate startAt, LocalDate endAt) {
		return new Period(startAt, endAt);
	}

	public boolean isLonger(int range) {
		long between = getBetween();
		return between >= range;
	}

	private long getBetween() {
		return ChronoUnit.DAYS.between(this.startAt, this.endAt);
	}

	public LocalDate startAt() {
		return this.startAt;
	}

	public LocalDate endAt() {
		return this.endAt;
	}

	public BigDecimal getDays() {
		return BigDecimal.valueOf(getBetween());
	}
}
