package team07.airbnb.search;

import com.fasterxml.jackson.databind.ObjectMapper;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@RequestMapping("/airbnb/search")
@RestController
public class SearchApiController {
	private final SearchService searchService;

	// ?location="강원"&checkinDate=""&checkoutDate=""&minPrice=0&maxPrice=0&guestAmount=0
	@GetMapping
	public ResponseEntity<SearchDto.RoomsResponse> searchRegion(@RequestParam HashMap<String, Object> request) {
		SearchDto.RoomsResponse response = searchService.findRoomsOfRegion(SearchDto.LocationRequest.of(request));
		return ResponseEntity.ok().body(response);
	}
}
