package team07.airbnb.room;

import java.util.List;
import java.util.Optional;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.data.jpa.repository.JpaRepository;

public interface RoomRepository extends JpaRepository<Room, Long> {

    @Query(value = "select r from Room r join fetch r.host where r.id=:roomId")
    Optional<Room> findRoomWithHostById(@Param("roomId") Long roomId);
}
