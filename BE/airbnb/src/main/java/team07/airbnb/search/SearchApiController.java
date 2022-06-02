package team07.airbnb.search;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.validation.Valid;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@RequestMapping("/airbnb/search")
@RestController
public class SearchApiController {
	private final SearchService searchService;

	@GetMapping
	public ResponseEntity searchRegion(@Valid @RequestBody SearchDto.LocationRequest request) {
		SearchDto.RoomsResponse response = searchService.findRoomsOfRegion(request);
		return ResponseEntity.ok().body(response);
	}
}
