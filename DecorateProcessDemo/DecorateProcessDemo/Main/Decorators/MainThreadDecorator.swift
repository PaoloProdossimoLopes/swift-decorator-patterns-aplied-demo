import Foundation
import Domain

final class MainThreadDecorator<T> {
    let decoratee: T
    
    init(decoratee: T) {
        self.decoratee = decoratee
    }
}

extension MainThreadDecorator: Requester where T: Requester {
    func request(completion: @escaping BindWith<Result<[Event], Error>>) {
        decoratee.request { result in
            if Thread.isMainThread {
               completion(result)
            } else {
                DispatchQueue.main.async {
                    completion(result)
                }
            }
        }
    }
}
