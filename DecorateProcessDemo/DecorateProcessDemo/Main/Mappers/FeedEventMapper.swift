import Domain
import UseCases

enum FeedEventMapper {
    static func mapper(events: [Event]) -> [EventViewData] {
        events.map { EventViewData(name: $0.name) }
    }
}
