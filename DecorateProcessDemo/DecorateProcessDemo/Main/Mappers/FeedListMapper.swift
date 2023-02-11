enum FeedListMapper {
    static func map(_ viewDatas: [EventViewData], action: @escaping BindWith<CellViewData>) -> [CellViewData] {
        viewDatas.map { CellViewData(title: $0.name, action: action) }
    }
}
