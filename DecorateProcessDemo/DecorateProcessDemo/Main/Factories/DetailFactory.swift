import UIKit

enum DetailFactory {
    static func create(with title: String) -> UIViewController {
        let detailController = UIViewController()
        detailController.view.backgroundColor = .white
        detailController.title = title
        return detailController
    }
}
