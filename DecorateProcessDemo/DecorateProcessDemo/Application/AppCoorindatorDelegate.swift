import UIKit

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
        let controller = FeedFactory.create(tracker: tracker, logger: logger, coordinate: self)
        let navigation = UINavigationController(rootViewController: controller)
        return navigation
    }
}

extension AppCoorindatorDelegate: FeedCoordinate {
    func toDetail(_ controller: UIViewController, with title: String) {
        let detailController = DetailFactory.create(with: title, tracker: tracker)
        controller.navigationController?.pushViewController(detailController, animated: true)
    }
}
