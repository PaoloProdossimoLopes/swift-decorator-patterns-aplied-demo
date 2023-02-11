import UIKit
import Domain

final class AppCoorindatorDelegate: NSObject, UIWindowSceneDelegate {
    var window: UIWindow?
    
    private let tracker: TrackerDemo
    private let logger: LoggerDemo
    
    init(tracker: TrackerDemo, logger: LoggerDemo) {
        self.tracker = tracker
        self.logger = logger
    }
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = makeScene()
        window?.makeKeyAndVisible()
    }
    
    private func makeScene() -> UIViewController {
        defer { trackPresentation(screen: .detail) }
        
        let controller = FeedFactory.create(tracker: tracker, logger: logger, coordinate: self)
        let navigation = UINavigationController(rootViewController: controller)
        return navigation
    }
}

extension AppCoorindatorDelegate: FeedCoordinate {
    func toDetail(_ controller: UIViewController, with title: String) {
        defer { trackPresentation(screen: .detail) }
        
        let detailController = DetailFactory.create(with: title)
        controller.navigationController?.pushViewController(detailController, animated: true)
    }
    
    private func trackPresentation(screen: Screen) {
        let event = TrackEvent(
            name: screen.name,
            description: "show a \(screen.name) scene"
        )
        tracker.track(event: event)
    }
}
