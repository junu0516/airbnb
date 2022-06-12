import Foundation

final class ReservationUseCase {
    
    private (set)var reservation: Observable<Reservation>
    private (set)var reservationPrices = Observable<[ReservationPrice]>([])
    private let repository: ReservationRepository
    private (set)var reservationResultFlag: Observable<Bool>?
    
    init(reservationRepository repository: ReservationRepository, reservation: Reservation) {
        self.reservation = Observable<Reservation>(reservation)
        self.reservationResultFlag = Observable<Bool>(true)
        self.repository = repository
    }
    
    func sendReservationRequest() {
        repository.sendPostRequest(bodyObj: reservation.value) { [weak self] result in
            self?.reservationResultFlag?.value = result
        }
    }
    
    func generateReservationPrices() -> [ReservationPrice] {
        let checkInDate = reservation.value.checkInDate
        let checkOutDate = reservation.value.checkOutDate
        let interval = checkOutDate.getDateInterval(from: checkInDate)
        
        let priceForOneDay = reservation.value.priceForOneDay
        let discountedPricePerWeek = reservation.value.discountedPricePerWeek
        let cleaningCost = reservation.value.cleaningPrice
        let serviceFee = reservation.value.fee
        let accomodationFee = reservation.value.tax
        
        return [
            .init(title: .originalPrice(price: "\(priceForOneDay.toDecimalString() ?? "")", dates: "\(interval)"), value: priceForOneDay*interval),
            .init(title: .weeklyDiscount, value: discountedPricePerWeek),
            .init(title: .cleaningCost, value: cleaningCost),
            .init(title: .serviceFee, value: serviceFee),
            .init(title: .accomodationFee, value: accomodationFee)
        ]
    }
}
