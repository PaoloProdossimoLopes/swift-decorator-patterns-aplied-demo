import Foundation

public final class NetworkRequester {
    public init() { }
    
    public func get(_ url: URL, completion: @escaping BindWith<Result<[Root], Error>>) {
        let task = URLSession.shared.dataTask(with: url, completionHandler: { data, resp, error in
            
            guard let data = data, error == nil else {
                return completion(.failure(error!))
            }
            
            let decoder = JSONDecoder()
            let decodedError = NSError(domain: "decoded error", code: -1)
            guard let decoded = try? decoder.decode([Root].self, from: data) else {
                return completion(.failure(decodedError))
            }
            
            completion(.success(decoded))
        })
        
        task.resume()
    }
    
    public struct Root: Decodable {
        public let name: String
    }
}
