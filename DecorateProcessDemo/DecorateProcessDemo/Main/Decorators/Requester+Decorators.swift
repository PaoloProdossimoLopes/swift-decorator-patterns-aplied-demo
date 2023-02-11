import Domain

extension Requester {
    func log(_ logger: Logger) -> Requester {
        LogDecorator(decoratee: self, logger: logger)
    }
    
    func dispathMain() -> Requester {
        MainThreadDecorator(decoratee: self)
    }
}
