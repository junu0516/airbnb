package team07.airbnb.wishlist;

import lombok.RequiredArgsConstructor;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequiredArgsConstructor
public class WishlistController {

    private final WishlistService wishlistService;

    @PostMapping("/airbnb/wishlist")
    public String addWishlist(@Validated @RequestBody WishlistAddRequest request, BindingResult bindingResult) {
        wishlistService.addOne(request);
        return "OK!";
    }

    @DeleteMapping("/airbnb/wishlist")
    public String deleteWishlist(@Validated @RequestBody WishlistDeleteRequest request, BindingResult bindingResult) {
        wishlistService.deleteOne(request);
        return "OK!";
    }

    @GetMapping("/airbnb/wishlists")
    public WishlistsResponse showAll() {
        Long userId = 1L; // 추후 유저 연동 필요
        return wishlistService.findAll(userId);
    }


}
