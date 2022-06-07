import XCTest
@testable import Airbnb

class ReservationModelTest: XCTestCase {

    private var reservation: Reservation!
    
    override func setUp(){
        super.setUp()
        let checkInDate = DateComponents(year: 2022, month:5, day:17)
        let checkOutDate = DateComponents(year: 2022, month:6, day:4)
        self.reservation = Reservation(checkInDate: checkInDate, checkOutDate: checkOutDate, guestsCount: 3, priceForOneDay: 70358)
    }
    
    /*
    1. 초기화 테스트
        - setUp 후 인스턴스가 nil이 아닌 지 여부를 체크
        - Reservation 객체 내부에서, 체크인&체크아웃 간의 날짜 차이가 2일인 지를 체크
     */
    func test_initialization() {
        XCTAssertNotNil(self.reservation)
        XCTAssertEqual(reservation.checkOutDate.getDateInterval(from: reservation.checkInDate), 2)
        XCTAssertNotEqual(reservation.checkOutDate.getDateInterval(from: reservation.checkInDate), 1)
    }
    
    //각 연산프로퍼티의 리턴값 테스트
    func test_calculating_prices() {
        XCTAssertEqual(reservation.totalPrice, 1338631)
        XCTAssertEqual(reservation.cleaningPrice, 25328)
        XCTAssertEqual(reservation.discountedPricePerWeek, -50657)
        XCTAssertEqual(reservation.tax, 8865)
    }
    
    //요청 객체 파싱 테스트
    func test_encoding_to_json() {
        let jsonHandler = JsonHandler()
        let json = jsonHandler.convertObjectToJson(from: self.reservation)
        XCTAssertNotNil(json)
    }
}
