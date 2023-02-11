public struct LogEvent {
    public let description: String
    
    public init(description: String) {
        self.description = description
    }
}

public protocol Logger {
    func log(event: LogEvent)
}
