package team07.airbnb.address;

import java.math.BigDecimal;
import javax.persistence.Embeddable;
import lombok.ToString;

@Embeddable
@ToString
public class Address {
    private
    static final String ADDRESS_TEXT = "%s %s %s";
    private String roomCountry;

    private String roomState;

    private String roomCity;

    private BigDecimal roomLongitude;

    private BigDecimal roomLatitude;

    public String divisions() {
        return String.format(ADDRESS_TEXT, roomCity, roomState, roomCountry);
    }

    public BigDecimal getRoomLongitude() {
        return roomLongitude;
    }

    public BigDecimal getRoomLatitude() {
        return roomLatitude;
    }

    public void setRoomLongitude(BigDecimal roomLongitude) {
        this.roomLongitude = roomLongitude;
    }

    public void setRoomLatitude(BigDecimal roomLatitude) {
        this.roomLatitude = roomLatitude;
    }
}
