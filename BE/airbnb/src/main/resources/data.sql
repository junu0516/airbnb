
insert into user
(USERNAME, USER_EMAIL, USER_PHONE, USER_ROLE, PROFILE_IMAGE)
values
    ('sally', 'sally@email.com', '010-1234-1234', 'guest', 'https://sally-airbnb.s3.ap-northeast-2.amazonaws.com/%ED%98%B8%EC%8A%A4%ED%8A%B8+%EC%9D%B4%EB%AF%B8%EC%A7%80/%ED%8C%8C%EC%9D%B4%ED%8C%85.png'),
    ('zzangmin', 'zzangmin@email.com', '010-7890-1234', 'host','https://sally-airbnb.s3.ap-northeast-2.amazonaws.com/%ED%98%B8%EC%8A%A4%ED%8A%B8+%EC%9D%B4%EB%AF%B8%EC%A7%80/%EC%A7%B1%EA%B5%AC-%ED%94%84%EB%A1%9C%ED%95%84.PNG'),
    ('공유', 'gongicheol@email.com', '010-2345-1234', 'host','https://sally-airbnb.s3.ap-northeast-2.amazonaws.com/%ED%98%B8%EC%8A%A4%ED%8A%B8+%EC%9D%B4%EB%AF%B8%EC%A7%80/%EA%B3%B5%EC%9C%A0-%ED%94%84%EB%A1%9C%ED%95%84.PNG'),
    ('BoGum', 'BoGumn@email.com', '010-1111-1234', 'host','https://sally-airbnb.s3.ap-northeast-2.amazonaws.com/%ED%98%B8%EC%8A%A4%ED%8A%B8+%EC%9D%B4%EB%AF%B8%EC%A7%80/%EB%B0%95%EB%B3%B4%EA%B2%80-%ED%94%84%EB%A1%9C%ED%95%84.jpg');

insert into ROOM
(ROOM_PRICE_PER_DAY, ROOM_NAME, MAX_NUMBER_OF_GUEST, ROOM_TYPE, NUMBER_OF_BED, NUMBER_OF_TOILET, ROOM_DESCRIPTION, HOST_ID, ROOM_COUNTRY, ROOM_STATE, ROOM_CITY, ROOM_LONGITUDE, ROOM_LATITUDE)
values
(340000, 'Euji님이 호스팅하는 집 전체', 6, 'RESIDENCE', 3, 2, '계곡 옆 시냇물 소리와 함께 조용한곳에서 프라이빗하게 힐링하다 가실수 잇는 숙소입니다!', 2, "한국", "경기도", "안양시", 37.5866076, 126.9726223),
(200000, 'Doyle님이 호스팅하는 게스트 스위트 전체', 8,'RESIDENCE',3,2,'알펜시아 리조트 1km 거리 위치해 있습니다. 겨울엔 스키타러 오시기 좋습니다. 여름에 워터파크 골프장 삼양목장 둘러보시면 좋습니다.', 2, "한국", "충청도", "안양시", 37.5866076, 126.9726223),
(281429,'다솜님이 호스팅하는 펜션',8,'PENSION',2,2,'사천해변과 가까운 평온한 시골마을 한옥집에서 편안한 시간 보내세요.', 3, "한국", "경상도", "포항시", 37.5866076, 126.9726223),
(212571,'은주님이 호스팅하는 공동 주택 전체',6,'RESIDENCE',4,2,'거실과 침실에 멋진 바다를 품은 숙소입니다. 고층에서 보이는 바다뷰가 마음을 평온하게 해줄꺼예요. 거실에 가만히 앉아 바다를 바라보며 힐링하셔요.', 3, "한국", "평안남도", "냉면시", 37.5866076, 126.9726223),
(258571,'마당가님이 호스팅하는 전원주택 전체',6,'PENSION',3,2,'250평 이상의 넓은 앞마당에서의 힐링과 야외 정자에서 오붓한 저녁식사가 가능한 독채 입니다. 앞마당에 펼쳐진 밤 조경도 너무 이쁜 숙소 입니다. 내부 공간 40평으로 온가족 편히 쉬다 가실수 있게 마련해 놓았습니다.', 4, "한국", "제주도", "삼다수시", 37.5866076, 126.9726223),
(550000,'형철님이 호스팅하는 저택 전체',6,'PENSION',3,2,'강원도 평창 뇌운계곡에 위치한 프라이빗한 풀빌라펜션입니다. 독채펜션으로 주변시선을 신경쓰지않고 오롯이 고객님들만이 프라이빗하게 즐기수있는 펜션입니다.', 4, "한국", "거제도", "꼬막시", 37.5866076, 126.9726223);


insert into IMAGE
(IMAGE_LINK, IMAGE_ORDER, ROOM_ID)
values
    ('https://sally-airbnb.s3.ap-northeast-2.amazonaws.com/1-%EC%A7%84%EB%B6%80%EB%A9%B4-%EC%9D%80%EC%A7%801.PNG',1,1),
    ('https://sally-airbnb.s3.ap-northeast-2.amazonaws.com/1-%EC%A7%84%EB%B6%80%EB%A9%B4-%EC%9D%80%EC%A7%802.PNG',2,1),
    ('https://sally-airbnb.s3.ap-northeast-2.amazonaws.com/1-%EC%A7%84%EB%B6%80%EB%A9%B4-%EC%9D%80%EC%A7%803.PNG',3,1),
    ('https://sally-airbnb.s3.ap-northeast-2.amazonaws.com/1-%EC%A7%84%EB%B6%80%EB%A9%B4-%EC%9D%80%EC%A7%804.PNG',4,1),


    ('https://sally-airbnb.s3.ap-northeast-2.amazonaws.com/2-%ED%8F%89%EC%B0%BD-%EB%B3%B4%EB%AF%BC1.PNG',1,2),
    ('https://sally-airbnb.s3.ap-northeast-2.amazonaws.com/2-room-1.jpg',2,2),
    ('https://sally-airbnb.s3.ap-northeast-2.amazonaws.com/2-room-3.jpg',3,2),

    ('https://sally-airbnb.s3.ap-northeast-2.amazonaws.com/3-%EA%B0%95%EB%A6%89-%EB%8B%A4%EC%86%9C1.PNG',1,3),
    ('https://sally-airbnb.s3.ap-northeast-2.amazonaws.com/3-%EA%B0%95%EB%A6%89-%EB%8B%A4%EC%86%9C2.PNG',2,3),
    ('https://sally-airbnb.s3.ap-northeast-2.amazonaws.com/3-%EA%B0%95%EB%A6%89-%EB%8B%A4%EC%86%9C3.PNG',3,3),

    ('https://sally-airbnb.s3.ap-northeast-2.amazonaws.com/4-%EA%B3%A0%EC%84%B1%EA%B5%B0-%EC%9D%80%EC%A3%BC-1.PNG',1,4),
    ('https://sally-airbnb.s3.ap-northeast-2.amazonaws.com/4-%EA%B3%A0%EC%84%B1%EA%B5%B0-%EC%9D%80%EC%A3%BC-2.PNG',2,4),
    ('https://sally-airbnb.s3.ap-northeast-2.amazonaws.com/4-%EA%B3%A0%EC%84%B1%EA%B5%B0-%EC%9D%80%EC%A3%BC-3.PNG',3,4),

    ('https://sally-airbnb.s3.ap-northeast-2.amazonaws.com/5-%EC%B6%98%EC%B2%9C-%EB%A7%88%EB%8B%B9%EA%B0%80-1.PNG',1,5),
    ('https://sally-airbnb.s3.ap-northeast-2.amazonaws.com/5-%EC%B6%98%EC%B2%9C-%EB%A7%88%EB%8B%B9%EA%B0%80-2.PNG',2,5),
    ('https://sally-airbnb.s3.ap-northeast-2.amazonaws.com/5-%EC%B6%98%EC%B2%9C-%EB%A7%88%EB%8B%B9%EA%B0%80-3.PNG',3,5),

    ('https://sally-airbnb.s3.ap-northeast-2.amazonaws.com/6-%ED%8F%89%EC%B0%BD-%ED%98%95%EC%B2%A0-1.PNG',1,6),
    ('https://sally-airbnb.s3.ap-northeast-2.amazonaws.com/6-%ED%8F%89%EC%B0%BD-%ED%98%95%EC%B2%AD-2.PNG',2,6),
    ('https://sally-airbnb.s3.ap-northeast-2.amazonaws.com/6-%ED%8F%89%EC%B0%BD-%ED%98%95%EC%B2%A0-3.PNG',3,6);

insert into RESERVATION
(ROOM_ID, GUEST_ID, START_AT, END_AT, NUMBER_OF_GUEST, TOTAL_PRICE)
VALUES
(1, 1, '2022-05-15', '2022-05-17', 3, 1020000);
