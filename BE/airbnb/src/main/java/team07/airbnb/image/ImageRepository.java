package team07.airbnb.image;

import java.util.List;
import javax.persistence.EntityManager;
import lombok.RequiredArgsConstructor;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface ImageRepository extends JpaRepository<Image, Long> {


    @Query("select i from Image i where i.room.id=:roomId")
    List<Image> findByRoomId(@Param("roomId") Long roomId);

//    public List<Image> findByRoomId(Long roomId) {
//        return em.createQuery("select i from Image i where i.room.id=:roomId", Image.class)
//            .setParameter("roomId", roomId)
//            .getResultList();
//    }
}
