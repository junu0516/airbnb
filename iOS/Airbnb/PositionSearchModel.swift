import Foundation

class PositionSearchModel {
    
    var bindUI:() -> Void = {}
    private var isSearching: Bool = false {
        didSet {
            self.bindUI()
        }
    }
    private var filteredSamples = [RoomPosition]()
    private let categories: [RoomPositionCategory] = [
        .init(categoryLiteral: "서울시"),
        .init(categoryLiteral: "부산시"),
        .init(categoryLiteral: "제주도")
    ]
    private let samples: [RoomPosition] = [
        .init(address: "양재"),
        .init(address: "서울특별시 서초구 양재동"),
        .init(address: "양재 시민의 숲"),
        .init(address: "양재IC")
    ]
 
    func rowsCount() -> Int {
        return isSearching ? filteredSamples.count : categories.count
    }
    
    func titleText(in rowIndex: Int) -> String {
        return isSearching ? filteredSamples[rowIndex].address : categories[rowIndex].categoryLiteral
    }
    
    func setIsSearching(_ isSearching: Bool) {
        self.isSearching = isSearching
    }
    
    func updateSearchResults(searchText: String?) {
        guard let searchText = searchText else {
            return
        }
        if searchText.count <= 0 {
            self.isSearching = false
            return
        }
        self.filteredSamples = samples.filter{ $0.address.contains(searchText) }
        self.isSearching = true
    }
}
