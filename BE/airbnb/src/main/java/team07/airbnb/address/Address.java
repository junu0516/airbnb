package team07.airbnb.address;

import java.math.BigDecimal;
import javax.persistence.Embeddable;
import lombok.Getter;
import lombok.ToString;

@Embeddable
@Getter
@ToString
public class Address {

    private String roomCountry;
    private String roomState;
    private String roomCity;
    private BigDecimal roomLongitude;
    private BigDecimal roomLatitude;

}
