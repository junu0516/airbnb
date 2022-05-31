package team07.airbnb.user;

import org.springframework.stereotype.Service;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class UserService {
	private final UserRepository userRepository;

	public User get(Long userId) {
		return userRepository.findById(userId)
			.orElseThrow(() -> new RuntimeException("no exist user"));
	}
}
