import UIKit
import Domain
import UseCases
import Presentation

protocol FeedCoordinate {
    func toDetail(_ controller: UIViewController, with title: String)
}

enum FeedFactory {
    static func create(tracker: Tracker, logger: Logger, coordinate: FeedCoordinate) -> FeedViewController {
        let requester = createRequester(logger: logger)
        let viewModel = createViewModel(requester: requester)
        let controller = createController(viewModel: viewModel)
        
        viewModel.eventOnChange = { [weak controller] viewDatas in
            onEventChangeHandler(
                viewDatas: viewDatas, tracker: tracker,
                controller: controller, coordinate: coordinate
            )
        }
        
        bindViewModel(
            viewModel: viewModel, controller: controller,
            tracker: tracker, coordinate: coordinate
        )
        
        return controller
    }
}

private extension FeedFactory {
    static func createRequester(logger: Logger) -> Requester {
        return FeedRequesterAdapter()
            .log(logger)
            .dispathMain()
    }
    
    static func createViewModel(requester:  Requester) -> FeedViewModel {
        let mapper = FeedEventMapper.mapper
        return FeedViewModel(requester: requester, mapper: mapper)
    }
    
    static func createController(viewModel: ViewModel) -> FeedViewController {
        let controller = FeedViewController(viewModel: viewModel)
        controller.title = "Feed"
        return controller
    }
    
    static func bindViewModel(
        viewModel: FeedViewModel, controller: FeedViewController,
        tracker: Tracker, coordinate: FeedCoordinate
    ) {
        viewModel.eventOnChange = { [weak controller] viewDatas in
            onEventChangeHandler(
                viewDatas: viewDatas, tracker: tracker,
                controller: controller, coordinate: coordinate
            )
        }
    }
    
    static func onEventChangeHandler(
        viewDatas: [EventViewData], tracker: Tracker,
        controller: FeedViewController?, coordinate: FeedCoordinate
    ) {
        let action = trackActionDecorator(tracker: tracker, action: { [coordinate] viewData in
            guard let controller = controller else { return }
            coordinate.toDetail(controller, with: viewData.title)
        })
        let models = FeedListMapper.map(viewDatas, action: action)
        controller?.updateCells(models)
    }
}
