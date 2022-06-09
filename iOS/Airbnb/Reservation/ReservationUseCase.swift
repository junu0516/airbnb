import Foundation

struct ReservationUseCase {
    
    private (set)var reservation: Observable<Reservation>
    private (set)var reservationPrices = Observable<[ReservationPrice]>([])
    private let repository: ReservationRepository
    
    init(reservationRepository repository: ReservationRepository, reservation: Reservation) {
        self.reservation = Observable<Reservation>(reservation)
        self.repository = repository
    }
    
    func sendReservationRequest() {
        repository.sendPostRequest(bodyObj: reservation.value) {
            DispatchQueue.main.async {
               print("예약 요청")
            }
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
