package team07.airbnb.wishlist;


import javax.persistence.Entity;
import javax.persistence.FetchType;
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
@EqualsAndHashCode(of = "wishlistId")
@NoArgsConstructor
@ToString(exclude = {"user", "room"})
public class Wishlist {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long wishlistId;
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "USER_ID")
    private User user;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "ROOM_ID")
    private Room room;

    public Wishlist(User user, Room room) {
        this.user = user;
        this.room = room;
    }

}
