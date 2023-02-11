import Domain

public final class FeedViewModel: ViewModel {
    
    public var eventOnChange: BindWith<[EventViewData]>?
    
    private let requester: Requester
    private let mapper: BindWithReturn<[Event], [EventViewData]>
    
    public init(
        requester: Requester,
        mapper: @escaping BindWithReturn<[Event], [EventViewData]>
    ) {
        self.requester = requester
        self.mapper = mapper
    }
    
    public func load() {
        requester.request { [mapper, eventOnChange] result in
            guard let events = try? result.get() else {
                eventOnChange?([EventViewData(name: "\t\t\t❌❌❌ ERROR ❌❌❌")])
                return
            }
            
            let viewDatas = mapper(events)
            eventOnChange?(viewDatas)
        }
    }
}
