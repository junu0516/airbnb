import XCTest
@testable import Airbnb

class PositionSearchModelTest: XCTestCase {

    func testCategoryCount_whenNotSearching_returnCategoryCount() throws {
        let categoryCount = 5
        let factory = PositionSearchFactory(categoryCount: categoryCount, dataCount: 8)
        let model = PositionSearchModel(factory)
        
        XCTAssertFalse(model.isSearching.value)
        XCTAssertEqual(model.rowsCount(), categoryCount, "Searching results is Category count")
    }
    
    func testCategoryCount_whenSearching_returnDataCount() throws {
        let factory = PositionSearchFactory(categoryCount: 1, dataCount: 5)
        let model = PositionSearchModel(factory)
        
        model.setIsSearching(true)
        model.updateSearchResults(searchText: "양재")
        
        XCTAssertTrue(model.isSearching.value)
        XCTAssertEqual(model.rowsCount(), 4, "Searching results count is matched")
    }
}
