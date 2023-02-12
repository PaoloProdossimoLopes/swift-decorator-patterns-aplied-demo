import Foundation
import Infra
import Domain

final class FeedRequesterAdapter: Requester {
    private let network: NetworkRequester
    
    init(network: NetworkRequester = NetworkRequester()) {
        self.network = network
    }
    
    func request(completion: @escaping BindWith<Result<[Event], Error>>) {
        if Bool.random() {
            let url = URL(string: "https://jsonplaceholder.typicode.com/users")!
            network.get(url) { result in
                switch result {
                case .success(let response):
                    let model = response.map { Event(name: $0.name) }
                    completion(.success(model))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        } else {
            let unexpectedError = NSError(domain: "unexpected error", code: -2)
            completion(.failure(unexpectedError))
        }
    }
}
