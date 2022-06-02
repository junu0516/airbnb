import Foundation

struct RoomSearchUseCase {
    
    private var searchCondition = Observable<SearchCondition>(SearchCondition())
    
    init(searchCondition: SearchCondition) {
        self.searchCondition.value = searchCondition
    }    
}

struct SearchCondition {
    private let positionTitle: String
    private let longitude: Double
    private let latitude: Double
    
    init() {
        self.positionTitle = ""
        self.longitude = 0
        self.latitude = 0
    }
    
    init(positionTitle: String, logntitude: Double, latitude: Double) {
        self.positionTitle = positionTitle
        self.longitude = logntitude
        self.latitude = latitude
    }
}
