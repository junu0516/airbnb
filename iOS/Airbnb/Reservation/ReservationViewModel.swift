import Foundation

final class ReservationViewModel {
    
    private (set)var reservation = Observable<Reservation>(Reservation())
    private let repository: ReservationRepository
    
    init(reservationRepository repository: ReservationRepository) {
        self.repository = repository
    }
    
    func sendReservationRequest() {
        repository.sendPostRequest(requestBody: Data()) {
            DispatchQueue.main.async {
               print("예약 요청")
            }
        }
    }
}
