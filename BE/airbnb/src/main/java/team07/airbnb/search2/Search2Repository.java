package team07.airbnb.search2;

import org.springframework.data.jpa.repository.JpaRepository;
import team07.airbnb.room.Room;

public interface Search2Repository extends JpaRepository<Room, Long> {

}
