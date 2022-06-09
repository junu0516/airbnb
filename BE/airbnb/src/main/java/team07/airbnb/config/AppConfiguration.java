package team07.airbnb.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import lombok.RequiredArgsConstructor;
import team07.airbnb.reservation.calculation.DiscountPolicy;
import team07.airbnb.reservation.calculation.ReservationFeeAndTax;
import team07.airbnb.reservation.calculation.RoomCleaningFee;
import team07.airbnb.reservation.calculation.WeeklyDiscountPolicy;

@RequiredArgsConstructor
@Configuration
public class AppConfiguration {
	private final RoomCleaningFee roomCleaningFee;
	private final ReservationFeeAndTax reservationFeeAndTax;

	@Bean
	public DiscountPolicy discountPolicy() {
		return new WeeklyDiscountPolicy(roomCleaningFee, reservationFeeAndTax);
	}
}
