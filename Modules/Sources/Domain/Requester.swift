public struct Event {
    public let name: String
    
    public init(name: String) {
        self.name = name
    }
}

public protocol Requester {
    func request(completion: @escaping BindWith<Result<[Event], Error>>)
}
