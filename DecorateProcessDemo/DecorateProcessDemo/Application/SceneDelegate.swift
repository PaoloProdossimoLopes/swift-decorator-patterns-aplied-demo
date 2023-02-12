import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    private var coordinator: AppCoorindatorDelegate?
    private let tracker = AnalyticsTrackerAdapter()
    private let logger = LoggerAdapter()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        coordinator = .init(tracker: tracker, logger: logger)
        coordinator?.scene(scene, willConnectTo: session, options: connectionOptions)
    }
}
