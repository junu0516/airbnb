package team07.airbnb.image;

import java.util.List;
import javax.persistence.EntityManager;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;

@Repository
@RequiredArgsConstructor
public class ImageRepository {
    private final EntityManager em;

    public List<Image> findByRoomId(Long roomId) {
        return em.createQuery("select i from Image i where i.room.id=:roomId", Image.class)
            .setParameter("roomId", roomId)
            .getResultList();
    }
}
