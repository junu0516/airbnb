package team07.airbnb.image;

import java.util.List;
import java.util.stream.Collectors;
import javax.persistence.Column;
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

@Entity
@NoArgsConstructor
@EqualsAndHashCode(of = "id")
@ToString(exclude = "room")
@Getter
public class Image {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "IMAGE_ID")
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "ROOM_ID")
    private Room room;

    private String imageLink;

    private int imageOrder;

    public static List<String> imageEntitiesToStringList(List<Image> images) {
        return images.stream().map(Image::getImageLink)
            .collect(Collectors.toList());
    }
}
