package team07.airbnb.wishlist;

import lombok.RequiredArgsConstructor;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;
import team07.airbnb.dto.WishlistAddRequest;

@RestController
@RequiredArgsConstructor
public class WishlistController {

    private final WishlistService wishlistService;

    @PostMapping("/airbnb/wishlist")
    public String addWishlist(@Validated @RequestBody WishlistAddRequest wishlistAddRequest, BindingResult bindingResult) {
        wishlistService.addOne(wishlistAddRequest);
        return "OK!";
    }


}
