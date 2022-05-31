package team07.airbnb.room;

import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequiredArgsConstructor
public class RoomController {

    private final RoomService roomService;

    @GetMapping("/airbnb/room/{roomId}")
    public RoomDetailResponse showRoom(@PathVariable Long roomId) {
        return roomService.findOne(roomId);
    }

}
