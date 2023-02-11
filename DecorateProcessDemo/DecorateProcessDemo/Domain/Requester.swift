struct Event {
    let name: String
}

protocol Requester {
    func request(completion: @escaping BindWith<Result<[Event], Error>>)
}
