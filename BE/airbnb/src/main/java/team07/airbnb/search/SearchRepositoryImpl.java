package team07.airbnb.search;

import static team07.airbnb.image.QImage.image;
import static team07.airbnb.reservation.QReservation.reservation;
import static team07.airbnb.room.QRoom.room;
import static team07.airbnb.wishlist.QWishlist.wishlist;

import com.querydsl.core.types.Predicate;
import com.querydsl.core.types.dsl.BooleanExpression;
import com.querydsl.jpa.impl.JPAQueryFactory;

import org.springframework.stereotype.Repository;
import org.springframework.util.StringUtils;

import java.util.List;

import javax.persistence.EntityManager;

import team07.airbnb.reservation.Period;

@Repository
public class SearchRepositoryImpl implements SearchRepository{
	private final JPAQueryFactory queryFactory;

	public SearchRepositoryImpl(EntityManager entityManager) {
		this.queryFactory = new JPAQueryFactory(entityManager);
	}

	@Override
	public List<SearchReservationRoomDto> findByReservationDate(Period period) {
		return queryFactory
			.select(new QSearchReservationRoomDto(
				reservation.room.id.as("roomId"))
			).from(reservation)
			.where(startAtBetween(period)
				.and(endAtBetween(period))
				.or(startAtLoeAndEndAtGoe(period))
			).fetch();
	}

	@Override
	public List<SearchRoomDto> searchLocation(SearchParam searchParam, List<Long> roomIds) {
		return queryFactory
			.select(new QSearchRoomDto(
				room.id.as("roomId"),
				room.roomName,
				room.roomPricePerDay.as("price"),
				image.imageLink.as("thumbnailImage"),
				wishlist.isNotNull().as("isWished"),
				room.address))
			.from(room)
			.innerJoin(image).on(room.id.eq(image.room.id))
			.leftJoin(wishlist).on(room.id.eq(wishlist.room.id))
			.where(
				image.imageOrder.eq(1),
				room.id.notIn(roomIds),
				locationStartWith(searchParam.getLocation()),
				priceGoe(searchParam.getMinPrice()),
				priceLoe(searchParam.getMaxPrice()),
				peoplesGoe(searchParam.getGuestAmount())
				)
			.fetch();
	}

	private BooleanExpression startAtLoeAndEndAtGoe(Period period) {
		return reservation.startAt.loe(period.startAt()).and(reservation.endAt.goe(period.endAt()));
	}

	private BooleanExpression endAtBetween(Period period) {
		return reservation.endAt.between(period.startAt(), period.endAt());
	}

	private BooleanExpression startAtBetween(Period period) {
		return reservation.startAt.between(period.startAt(), period.endAt());
	}

	private BooleanExpression locationStartWith(String location) {
		return StringUtils.hasText(location) ?
			room.address.roomCity.contains(location)
				.or(room.address.roomState.contains(location))
				.or(room.address.roomCity.contains(location))
			: room.address.roomCountry.eq("한국");
	}

	private BooleanExpression priceGoe(int minPrice) {
		return minPrice > 0 ? room.roomPricePerDay.goe(minPrice) : null;
	}

	private BooleanExpression priceLoe(int maxPrice) {
		return maxPrice > 0 ? room.roomPricePerDay.goe(maxPrice) : null;
	}

	private Predicate peoplesGoe(int guestAmount) {
		return guestAmount > 0 ? room.maxNumberOfGuest.goe(guestAmount) : null;
	}
}

/*  // client? repository?
	private BooleanExpression startAtGoe(LocalDate startAt) {
		return Objects.isNull(startAt) ?
			reservation.startAt.goe(LocalDate.now())
			: reservation.startAt.goe(startAt);
	}

	private BooleanExpression dateLoe(LocalDate endAt) {
		return Objects.isNull(endAt) ?
			reservation.endAt.loe(LocalDate.now().plusDays(30))
			: reservation.endAt.loe(endAt);
	}*/
