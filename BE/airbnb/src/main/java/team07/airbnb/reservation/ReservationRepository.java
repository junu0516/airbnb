package team07.airbnb.reservation;


import javax.persistence.EntityManager;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;

@Repository
@RequiredArgsConstructor
public class ReservationRepository {

    private final EntityManager em;

    public Reservation findReservationWithRoomAndHost(Long reservationId) {
        return em.createQuery("select re from Reservation re join fetch re.room ro join fetch ro.host where re.reservationId=:reservationId", Reservation.class)
            .setParameter("reservationId", reservationId).getSingleResult();
    }

}
