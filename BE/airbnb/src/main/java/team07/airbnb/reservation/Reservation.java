package team07.airbnb.reservation;

import java.time.LocalDate;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;

import lombok.AccessLevel;
import lombok.Builder;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import lombok.ToString;
import team07.airbnb.room.Room;
import team07.airbnb.user.User;

@ToString(exclude = {"room", "user"})
@NoArgsConstructor
@EqualsAndHashCode(of = "reservationId")
@Entity
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

    @Builder(access = AccessLevel.PROTECTED)
    public Reservation(Room room, User user, LocalDate startAt, LocalDate endAt, int numberOfGuest, int totalPrice) {
        this.room = room;
        this.user = user;
        this.startAt = startAt;
        this.endAt = endAt;
        this.numberOfGuest = numberOfGuest;
        this.totalPrice = totalPrice;
    }

    Long reservedNo() {
        return this.room.getId();
    }

    ReservationRoom getInfo() {
        ReservationRoom reservationRoom = this.room.getReservationRoom();
        reservationRoom.applyGuest(Period.of(startAt, endAt), this.numberOfGuest, this.totalPrice);
        return reservationRoom;
    }
}
