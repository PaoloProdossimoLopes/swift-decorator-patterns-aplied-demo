import Foundation
import Domain

final class LogDecorator<T> {
    let decoratee: T
    let logger: Logger
    
    init(decoratee: T, logger: Logger) {
        self.decoratee = decoratee
        self.logger = logger
    }
}

extension LogDecorator: Requester where T: Requester {
    func request(completion: @escaping BindWith<Result<[Event], Error>>) {
        decoratee.request { [logger] result in
            if case .failure(let error) = result {
                let event = LogEvent(description: error.localizedDescription)
                logger.log(event: event)
            }
        
            completion(result)
        }
    }
}
