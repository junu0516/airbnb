# Airbnb✈️ :: iOS Project
> **기한**: 2022.05.23 ~ 06.10 (3주)
> 
> 프로젝트에 대한 자세한 내용은 [👉 Notion](https://www.notion.so/CodeSquad-7team-a5ef4a1acbad48c48b22198e288e2860) 에서 확인할 수 있습니다

## ✨ 앱 소개

![Simulator Screen Recording - iPhone 12 mini - 2022-06-10 at 10 58 01](https://user-images.githubusercontent.com/68586291/173380529-a2df55b6-7dfe-4104-ae06-0bf563760ed2.gif)

### 장소 검색

- google place api 를 사용해 검색어 자동 완성

### 검색결과: 카드리스트
    
- Alamofire을 사용하여 서버로 필요한 데이터를 요청합니다.    
- CollectionView를 통해 검색 결과를 서버로부터 응답받은 데이터를 카드리스트 형식으로 보여줍니다.

### 검색결과: 지도

- google api 를 이용해 숙소 위치를 가격 정보가 나타나는 마커로 표시합니다.
- 지도 하단에 숙소 검색결과 카드리스트를 CollectionView를 통해 보여줍니다.

### 숙소 상세
    
- Alamofire을 사용하여 서버로 필요한 데이터를 요청합니다.    
- CollectionView를 통해 서버로부터 API 요청을 통해 응닫받은 데이터를 화면에 보여줍니다

### 숙소 예약

- 각종 수수료 계산이 적용된 최종 예약금액을 서버로 POST 요청 보내서 숙소 예약을 처리합니다.
- POST 요청에 대한 결과를 응답받아 화면에 보여줍니다.

## Development Environment

### iOS(Client)

- [MVVM 을 기반으로 한 설계 패턴, OOP(객체지향설계)](https://github.com/junu0516/airbnb/wiki/%5BiOS%5D-%EA%B0%9D%EC%B2%B4-%EC%A7%80%ED%96%A5-%EC%84%A4%EA%B3%84)
- [XCTest(Unit Test)](https://github.com/junu0516/airbnb/wiki/%5BiOS%5D-Unit-Test)
- Swift5
- CocoaPod
- Alamofire 5.1
- GoogleMaps 6.2.1, GooglePlaces 6.2.1

### BackEnd(Server)

- Springboot
- Spring Data JPA
- Querydsl
- AWS ec2, VPC, S3
- clean code, OOP
- Test - junit5, Swagger(통합case)

## 팀원
|`iOS` [@Jed](https://github.com/junu0516)| `iOS` [@Rosa](https://github.com/Jinsujin)| `BE` [@Sally](https://github.com/sally-ksh) |`BE` [@zzangmin](https://github.com/leezzangmin)|
|--|--|--|--|
|[👉 회고](https://github.com/junu0516/airbnb/wiki/%ED%9A%8C%EA%B3%A0:-Jed)|[👉 회고](https://github.com/junu0516/airbnb/wiki/%ED%9A%8C%EA%B3%A0:-Rosa)|-|-|


