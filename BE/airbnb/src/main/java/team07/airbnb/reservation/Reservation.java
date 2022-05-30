package team07.airbnb.reservation;

import java.time.LocalDate;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import team07.airbnb.room.Room;
import team07.airbnb.user.User;

@Entity
@NoArgsConstructor
@EqualsAndHashCode(of = "reservationId")
public class Reservation {

    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long reservationId;
    @ManyToOne
    @JoinColumn(name = "ROOM_ID")
    private Room room;
    @ManyToOne
    @JoinColumn(name = "GUEST_ID")
    private User user;
    private LocalDate startAt;
    private LocalDate endAt;
    private int numberOfGuest;
    private int totalPrice;

}
