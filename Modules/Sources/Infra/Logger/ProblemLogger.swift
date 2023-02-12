public struct ProblemEvent {
    public let name: String
    public let description: String
    
    public init(name: String, description: String) {
        self.name = name
        self.description = description
    }
}

public final class ProblemLogger {
    
    public init() { }
    
    public func log(event: ProblemEvent) {
        print("🚨 DEBUG:")
        print("\t Description: \(event.description)")
    }
}
