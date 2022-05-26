import Foundation

class PositionSearchModel {
    
    private (set) var isSearching = Observable<Bool>(false)
    private var filteredSamples = [RoomPosition]()
    private let categories: [RoomPositionCategory]
    private let samples: [RoomPosition]
    
    init(_ mockFactory: PositionSearchFactory) {
        self.categories = mockFactory.categories
        self.samples = mockFactory.datas
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
    
    func updateSearchResults(searchText: String?) {
        guard let searchText = searchText else {
            return
        }
        if searchText.count <= 0 {
            self.isSearching.value = false
            return
        }
        self.filteredSamples = samples.filter{ $0.address.contains(searchText) }
        self.isSearching.value = true
    }
}
