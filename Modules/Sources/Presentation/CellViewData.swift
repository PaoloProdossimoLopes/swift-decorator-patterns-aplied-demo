public struct CellViewData {
    public let title: String
    public let action: BindWith<CellViewData>?
    
    public init(title: String, action: BindWith<CellViewData>?) {
        self.title = title
        self.action = action
    }
}
