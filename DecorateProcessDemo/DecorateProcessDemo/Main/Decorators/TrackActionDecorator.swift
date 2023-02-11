func trackActionDecorator(tracker: Tracker, action: @escaping BindWith<CellViewData>) -> BindWith<CellViewData> {
    return { [tracker, action] viewData in
        let event = TrackEvent(name: "Did tapped", description: viewData.title)
        tracker.track(event: event)
        action(viewData)
    }
}
