## 숙소예약시스템

### rest api

| protocol | api                          | description        |
|----------|------------------------------|--------------------|
| GET      | /airbnb                      | 첫 페이지              |
| GET      | /airbnb/search               | 검색                 |
| GET      | /airbnb/search/rooms         | 검색목록 결과 or 숙소 목록   |
| GET      | /airbnb/room/1               | 숙소 상세 보기           |
| POST      | /airbnb/room/make/reservation | 예약하기               |
| GET      | /airbnb/room/reservation/list | 사용자 예약 목록 조회       |
| GET      | /airbnb/room/reservation/list/1 | 사용자 예약 상세 조회       |
| GET      | /airbnb/wishlist             | 위시리스트 추가하기         |
| GET      | /airbnb/wishlists            | 위시리스트 목록 조회        |
| DELETE   | /airbnb/wishlist/1           | 위시리스트 취소           |
| GET      | ~~/airbnb/search/rooms/map~~ | ~~검색 중 지도에서 숙소 목록 보기~~ |



### [swagger 실행 url](http://localhost:8080/swagger-ui/index.html)

#### ReservationApi

- POST : /airbnb/room/make/reservation

``` json
    {
        "roomId" : 1, 
        "guestId" : 1,
        "checkIn" : "2022-05-09",
        "checkOut" : "2022-05-13",
        "guestAmount" : 3,
        "priceForOneDay" : 340000,
        "discountedPricePerWeek" : 0,
        "cleaningPrice" : 6800,
        "fee": 23800,
        "tax" : 2380,
        "totalPrice" : 307020
    }
```

- GET : /1

