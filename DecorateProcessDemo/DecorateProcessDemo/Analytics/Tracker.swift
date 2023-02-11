protocol Tracker {
    func track(event: TrackEvent)
}

struct TrackEvent {
    let name: String
    let description: String
}
