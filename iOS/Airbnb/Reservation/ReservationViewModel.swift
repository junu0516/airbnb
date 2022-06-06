import Foundation

final class ReservationViewModel {
    
    private (set)var reservation = Observable<Reservation>(Reservation())
    private (set)var reservationPrices = Observable<[ReservationPrice]>([])
    private let repository: ReservationRepository
    
    init(reservationRepository repository: ReservationRepository) {
        self.repository = repository
    }
    
    func sendReservationRequest() {
        repository.sendPostRequest(bodyObj: reservation.value) {
            DispatchQueue.main.async {
               print("예약 요청")
            }
        }
    }
}
