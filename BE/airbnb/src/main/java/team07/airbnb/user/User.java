package team07.airbnb.user;

import java.util.ArrayList;
import java.util.List;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

import javax.persistence.OneToMany;
import lombok.AllArgsConstructor;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import lombok.ToString;
import team07.airbnb.wishlist.Wishlist;

@ToString
@AllArgsConstructor
@NoArgsConstructor
@EqualsAndHashCode(of = "userId")
@Entity
public class User {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long userId;

    private String username;

    private String profileImage;

    private String userEmail;

    @Enumerated(EnumType.STRING)
    private UserRole userRole;

    private String userPhone;

    public User(String userEmail, String username, String userPhone, UserRole role) {
        this.userEmail = userEmail;
        this.username = username;
        this.userPhone = userPhone;
        this.userRole = role;
    }

    public String nickName() {
        return this.username;
    }

    public Long getUserId() {
        return userId;
    }

    public HostProfile getHost() {
        return new HostProfile(this.username, this.profileImage);
    }
}
