import XCTest
@testable import Airbnb

class ReservationViewModelTest: XCTestCase {

    private var viewModel: ReservationViewModel!
    
    override func setUp(){
        super.setUp()
        let repository = ReservationRepository(networkHandler: MockNetworkHandler(), jsonHandler: JsonHandler())
        self.viewModel = ReservationViewModel(reservationRepository: repository)        
    }
    
    /*
       ReservationPrice 객체 배열 생성 관련 테스트
     */
    func test_generating_prices() {
        
        //우선 Observable<[ReservationPrice]>의 value 속성의 Nil 여부 확인
        XCTAssertNotNil(self.viewModel.reservation.value)
        //빈 배열이 들어있는지 value 속성에 있는 배열 인스턴스의 길이 0 이하인지 확인
        XCTAssertLessThanOrEqual(self.viewModel.reservationPrices.value.count, 0)
        
        //generateReservationPrices() 메소드 호출 후, value 속성에 있는 배열 인스턴스의 길이가 1 이상인지 확인
        let prices = self.viewModel.generateReservationPrices()
        self.viewModel.reservationPrices.value = prices
        XCTAssertGreaterThan(self.viewModel.reservationPrices.value.count, 1)
    }
    
    /*
        예약 POST 요청 관련 테스트
     */
    func test_sending_reservation_request() {
        
    }
    
}
