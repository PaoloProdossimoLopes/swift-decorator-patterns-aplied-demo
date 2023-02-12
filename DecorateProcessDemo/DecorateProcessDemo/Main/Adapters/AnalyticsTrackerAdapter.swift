import Domain
import Infra

final class AnalyticsTrackerAdapter: Tracker {
    private let tracker: AnalyticsTracker
    
    init(tracker: AnalyticsTracker = AnalyticsTracker()) {
        self.tracker = tracker
    }
    
    func track(event: TrackEvent) {
        let model = AnalyticsEvent(name: event.name, description: event .description)
        tracker.track(event: model)
    }
}
