import Domain
import Infra

final class LoggerAdapter: Logger {
    private let tracker: ProblemLogger
    
    init(tracker: ProblemLogger = ProblemLogger()) {
        self.tracker = tracker
    }
    
    func track(event: TrackEvent) {
        let model = ProblemEvent(name: event.name, description: event .description)
        tracker.log(event: model)
    }
    
    func log(event: LogEvent) {
        print("🚨 DEBUG:")
        print("\t Description: \(event.description)")
    }
}
