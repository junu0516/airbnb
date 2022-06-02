package team07.airbnb.reservation;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

import lombok.AccessLevel;
import lombok.Builder;
import lombok.Getter;
import team07.airbnb.image.Image;

@Getter
public class ReservationDetailResponse {
     private String roomName;
     private String address;
     private List<String> images = new ArrayList<>();
     private LocalDate startAt;
     private LocalDate endAt;
     private String hostName;
     private int guestAmount;
     private int totalPrice;

     @Builder(access = AccessLevel.PRIVATE)
     public ReservationDetailResponse(String roomName, String address,
         List<String> images, LocalDate startAt, LocalDate endAt, String hostName, int guestAmount,
         int totalPrice) {
          this.roomName = roomName;
          this.address = address;
          this.images = images;
          this.startAt = startAt;
          this.endAt = endAt;
          this.hostName = hostName;
          this.guestAmount = guestAmount;
          this.totalPrice = totalPrice;
     }

     public static ReservationDetailResponse of(ReservationRoom reservation, List<Image> images) {
          return ReservationDetailResponse.builder()
              .roomName(reservation.getTitle())
              .address(reservation.getAddress())
              .images(Image.imageEntitiesToStringList(images))
              .startAt(reservation.checkIn())
              .endAt(reservation.checkOut())
              .hostName(reservation.getHostName())
              .guestAmount(reservation.getNumberOfGuest())
              .totalPrice(reservation.getTotalPrice())
              .build();
     }

}
