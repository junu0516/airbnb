package team07.airbnb.reservation;

import java.time.LocalDate;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.ToString;
import team07.airbnb.room.Room;
import team07.airbnb.user.User;

@Entity
@NoArgsConstructor
@EqualsAndHashCode(of = "reservationId")
@ToString(exclude = {"room", "user"})
@Getter
public class Reservation {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long reservationId;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "ROOM_ID")
    private Room room;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "GUEST_ID")
    private User user;

    private LocalDate startAt;

    private LocalDate endAt;

    private int numberOfGuest;

    private int totalPrice;
}
