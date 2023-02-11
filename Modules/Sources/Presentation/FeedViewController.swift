import UIKit
import UseCases

public final class FeedViewController: UITableViewController {
    
    private let viewModel: ViewModel
    private var cellViewDatas = [CellViewData]() {
        didSet {
            tableView.reloadData()
            hideLoader()
        }
    }
    
    public init(viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    public required init?(coder: NSCoder) { nil }
    
    override public func loadView() {
        super.loadView()
        view = tableView
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        let refresher = UIRefreshControl()
        refresher.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
        tableView.refreshControl = refresher
        
        loads()
    }
    
    public func updateCells(_ viewDatas: [CellViewData]) {
        cellViewDatas = viewDatas
    }
    
    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cellViewDatas.count
    }
    
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        cell.textLabel?.text = cellViewDatas[indexPath.row].title
        cell.selectionStyle = .none
        return cell
    }
    
    public override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewData = cellViewDatas[indexPath.row]
        viewData.action?(viewData)
    }
}

private extension FeedViewController {
    
    func showLoader() {
        tableView.refreshControl?.beginRefreshing()
    }
    
    func hideLoader() {
        tableView.refreshControl?.endRefreshing()
    }
    
    func loads() {
        showLoader()
        viewModel.load()
    }
    
    @objc func didPullToRefresh() {
        loads()
    }
}
