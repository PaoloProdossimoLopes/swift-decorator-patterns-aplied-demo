import UIKit

protocol FeedCoordinate {
    func toDetail(_ controller: UIViewController, with title: String)
}

enum FeedFactory {
    static func create(tracker: Tracker, logger: Logger, coordinate: FeedCoordinate) -> FeedViewController {
        let requester = FeedRequester()
            .log(logger)
            .dispathMain()
        
        let mapper = FeedEventMapper.mapper
        let viewModel = FeedViewModel(requester: requester, mapper: mapper)
        
        let controller = FeedViewController(tracker: tracker, viewModel: viewModel)
        controller.title = "Feed"
        
        viewModel.eventOnChange = { [weak controller] viewDatas in
            let action = trackActionDecorator(tracker: tracker, action: { [coordinate] viewData in
                guard let controller = controller else { return }
                coordinate.toDetail(controller, with: viewData.title)
            })
            let models = FeedListMapper.map(viewDatas, action: action)
            controller?.updateCells(models)
        }
        
        return controller
    }
}

enum DetailFactory {
    static func create(with title: String, tracker: Tracker) -> UIViewController {
        let detailController = TrackedViewController(tracker: tracker, screen: .detail)
        detailController.view.backgroundColor = .white
        detailController.title = title
        return detailController
    }
}
