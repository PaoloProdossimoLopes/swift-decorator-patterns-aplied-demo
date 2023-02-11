import Foundation

final class FeedRequester: Requester {
    func request(completion: @escaping BindWith<Result<[Event], Error>>) {
        if Bool.random() {
            let url = URL(string: "https://jsonplaceholder.typicode.com/users")
            let task = URLSession.shared.dataTask(with: url!, completionHandler: { data, resp, error in
                
                guard let data = data, error == nil else {
                    return completion(.failure(error!))
                }
                
                let decoder = JSONDecoder()
                let decodedError = NSError(domain: "decoded error", code: -1)
                guard let decoded = try? decoder.decode([Root].self, from: data) else {
                    return completion(.failure(decodedError))
                }
                let model = decoded.map { Event(name: $0.name) }
                
                completion(.success(model))
            })
            task.resume()
        } else {
            let unexpectedError = NSError(domain: "unexpected error", code: -2)
            completion(.failure(unexpectedError))
        }
    }
    
    struct Root: Decodable {
        let name: String
    }
}
