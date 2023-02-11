public protocol Tracker {
    func track(event: TrackEvent)
}

public struct TrackEvent {
    public let name: String
    public let description: String
    
    public init(name: String, description: String) {
        self.name = name
        self.description = description
    }
}
