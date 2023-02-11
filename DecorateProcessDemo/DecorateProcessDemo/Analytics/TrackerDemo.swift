import Domain

final class TrackerDemo: Tracker {
    func track(event: TrackEvent) {
        print("📡 Tracking:")
        print("\t Name:\(event.name)")
        print("\t Description:\(event.description)")
    }
}
