package team07.airbnb.address;

import java.math.BigDecimal;
import javax.persistence.Embeddable;

@Embeddable
public class Address {

    private String country;
    private String state;
    private String city;
    private BigDecimal longitude;
    private BigDecimal latitude;

}
