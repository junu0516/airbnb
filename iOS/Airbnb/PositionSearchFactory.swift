import Foundation

struct PositionSearchFactory {
    private (set)var categories: [RoomPositionCategory] = []
    private (set)var datas: [RoomPosition] = []
    
    init(categoryCount: Int, dataCount: Int) {
        self.categories = generateCategories(count: categoryCount)
        self.datas = generateDatas(count: dataCount)
    }
        
    func generateCategories(count: Int) -> [RoomPositionCategory] {
        if count >= mockCategories.count {
            return mockCategories
        }
        return Array(mockCategories[0..<count])
    }
    
    func generateDatas(count: Int) -> [RoomPosition] {
        if count >= mockDatas.count {
            return mockDatas
        }
        return Array(mockDatas[0..<count])
    }
    
    private let mockCategories: [RoomPositionCategory] = [
        .init(categoryLiteral: "서울시"),
        .init(categoryLiteral: "부산시"),
        .init(categoryLiteral: "제주도"),
        .init(categoryLiteral: "울산"),
        .init(categoryLiteral: "대구"),
        .init(categoryLiteral: "대전"),
        .init(categoryLiteral: "경주"),
        .init(categoryLiteral: "김해"),
        .init(categoryLiteral: "고양시"),
        .init(categoryLiteral: "전주")
    ]
    private let mockDatas: [RoomPosition] = [
        .init(address: "양재"),
        .init(address: "서울특별시 서초구 양재동"),
        .init(address: "양재 시민의 숲"),
        .init(address: "양재IC"),
        .init(address: "부산시 동래구"),
        .init(address: "만덕 터미널"),
        .init(address: "사직운동장"),
        .init(address: "광안리")
    ]
}
