package team07.airbnb.user;

import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.AllArgsConstructor;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import lombok.ToString;

@ToString
@AllArgsConstructor
@NoArgsConstructor
@EqualsAndHashCode(of = "userId")
@Table(name = "airbnb_user")
@Entity
public class User {

    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long userId;
    private String username;
    private String profileImage;
    private String userEmail;
    @Enumerated(EnumType.STRING)
    private UserRole role;
    private String userPhone;


    public User(String userEmail, String username, String userPhone, UserRole role) {
        this.userEmail = userEmail;
        this.username = username;
        this.userPhone = userPhone;
        this.role = role;
    }
}
