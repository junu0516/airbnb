package team07.airbnb.dto;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;
import lombok.Getter;
import team07.airbnb.address.Address;
import team07.airbnb.image.Image;
import team07.airbnb.reservation.Reservation;

@Getter
public class ReservationDetailResponse {

     private String roomName;
     private Address address;
     private List<String> images = new ArrayList<>();
     private LocalDate startAt;
     private LocalDate endAt;
     private String hostName;
     private int guestAmount;
     private int totalPrice;

     public ReservationDetailResponse(String roomName, Address address,
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

     public static ReservationDetailResponse of(Reservation reservation, List<Image> images) {
          return new ReservationDetailResponse(
              reservation.getRoom().getRoomName(),
              reservation.getRoom().getAddress(),
              imageEntitiesToStringList(images),
              reservation.getStartAt(),
              reservation.getEndAt(),
              reservation.getRoom().getHost().getUsername(),
              reservation.getNumberOfGuest(),
              reservation.getTotalPrice());
     }

     private static List<String> imageEntitiesToStringList(List<Image> images) {
          return images.stream().map(i -> i.getImageLink())
              .collect(Collectors.toList());
     }

}
