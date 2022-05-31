package team07.airbnb.room;

import java.util.Optional;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface RoomRepository extends CrudRepository<Room, Long> {

    @Query(value = "select r from Room r join fetch r.host where r.id=:roomId", nativeQuery = false)
    Optional<Room> findRoomWithHostById(@Param("roomId") Long roomId);
}
