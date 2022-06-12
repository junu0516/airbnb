import Foundation

final class MockNetworkServiceManager: NetworkService {
    
    enum MockData {
        case roomList
        
        var fileName: String {
            switch self {
            case .roomList:
                return "roomList"
            }
        }
    }
    
    //Mock 객체 내부에서 사용할 사용자 정의 에러 열거형
    enum TestError: Error, CustomStringConvertible {
        case mockDataNotLoaded
        case expectedError
        
        var description: String {
            switch self {
            case .mockDataNotLoaded:
                return "Mock Data Not Loaded"
            case .expectedError:
                return "Expected Error"
            }
        }
    }
    
    //미리 성공, 실패 여부를 결정
    var shouldFail: Bool = true
    var mockResponseData: Data?
    
    //필요 시 로컬에 미리 저장된 json 데이터를 가지고옴
    func loadMockData(mockData: MockData) {
        guard let path = Bundle.main.url(forResource: mockData.fileName, withExtension: "json") else { return }
        guard let data: Data = try? Data(contentsOf: path) else { return }
        self.mockResponseData = data
    }
    
    func request(endPoint: EndPoint,
                 body: Data?,
                 completion: @escaping (Result<Data, Error>) -> Void) {
        
        switch shouldFail {
        case false:
            //성공한 응답가지고 클로저 호출
            completion(.success(mockResponseData ?? Data()))
        case true:
            //실패한 응답 가지고 클로저 호출
            completion(.failure(TestError.expectedError))
        }
    }
}
