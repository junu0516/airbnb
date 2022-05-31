package team07.airbnb.room;

import org.springframework.stereotype.Service;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class RoomService {
	private final RoomRepository roomRepository;

	public Room getRoom(Long roomId) {
		return roomRepository.findById(roomId)
			.orElseThrow(() -> new RuntimeException("no entity"));
	}
}
