import UIKit

class TrackedViewController: UIViewController {
    private let tracker: Tracker
    private let screen: Screen
    
    init(tracker: Tracker, screen: Screen) {
        self.tracker = tracker
        self.screen = screen
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { nil }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let event = TrackEvent(
            name: screen.name,
            description: "show a \(screen.name) scene"
        )
        tracker.track(event: event)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        let event = TrackEvent(
            name: screen.name,
            description: "dismiss a \(screen.name) scene"
        )
        tracker.track(event: event)
    }
}
