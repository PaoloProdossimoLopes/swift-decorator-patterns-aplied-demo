public struct AnalyticsEvent {
    public let name: String
    public let description: String
    
    public init(name: String, description: String) {
        self.name = name
        self.description = description
    }
}

public final class AnalyticsTracker {
    
    public init() { }
    
    public func track(event: AnalyticsEvent) {
        print("📡 Tracking:")
        print("\t Name:\(event.name)")
        print("\t Description:\(event.description)")
    }
}
