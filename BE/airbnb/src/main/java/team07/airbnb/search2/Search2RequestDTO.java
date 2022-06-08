package team07.airbnb.search2;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.lang.NonNull;

import java.time.LocalDate;

@Data
@NoArgsConstructor
public class Search2RequestDTO {
    @NonNull
    private LocalDate checkinDate;
    @NonNull
    private LocalDate checkoutDate;
    @NonNull
    private int guestAmount;
    @NonNull
    private String location;
    @NonNull
    private int minPrice;
    @NonNull
    private int maxPrice;

}
