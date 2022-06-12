import Foundation
import GooglePlaces

final class PositionSearchUseCase {

    private let token = GMSAutocompleteSessionToken()
    private let client = GMSPlacesClient()

    private (set) var isSearching = Observable<Bool>(false)
    private  (set) var filteredSamples = [RoomPosition]()
    private let categories: [RoomPositionCategory]
    private let samples: [RoomPosition]
    
    init(_ mockFactory: PositionSearchFactory) {
        self.categories = mockFactory.categories
        self.samples = mockFactory.dataList
    }

    func rowsCount() -> Int {
        return isSearching.value ? filteredSamples.count : categories.count
    }
    
    func titleText(in rowIndex: Int) -> String {
        return isSearching.value ? filteredSamples[rowIndex].address : categories[rowIndex].categoryLiteral
    }

    func setIsSearching(_ isSearching: Bool) {
        self.isSearching.value = isSearching
    }

    func updateSearchResults(predictions: [String]) {
        if predictions.isEmpty {
            self.isSearching.value = false
            return
        }
        
        self.filteredSamples = predictions.map { return RoomPosition(address: $0) }
        self.isSearching.value = true
    }
    
    func fetchPredctionList(searchText: String) {
        var predictions: [String] = []
        client.findAutocompletePredictions(fromQuery: searchText,
                                           filter: nil,
                                           sessionToken: token) { [weak self] results, error in
            if error != nil { return }
            results?.forEach { predictions.append($0.attributedPrimaryText.string) }
            self?.updateSearchResults(predictions: predictions)
        }
    }
}
