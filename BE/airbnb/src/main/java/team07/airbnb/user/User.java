package team07.airbnb.user;

import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

import lombok.AllArgsConstructor;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.ToString;

@ToString
@AllArgsConstructor
@NoArgsConstructor
@EqualsAndHashCode(of = "userId")
@Entity
@Getter
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
}
