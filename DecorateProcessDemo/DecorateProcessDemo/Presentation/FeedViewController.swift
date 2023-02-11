import UIKit

struct CellViewData {
    let title: String
    let action: BindWith<CellViewData>?
}

final class FeedViewController: TrackedViewController, UITableViewDelegate, UITableViewDataSource {
    
    private let viewModel: ViewModel
    private var cellViewDatas = [CellViewData]() {
        didSet {
            tableView.reloadData()
            hideLoader()
        }
    }
    
    private lazy var tableView: UITableView = {
        let refresher = UIRefreshControl()
        refresher.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
        
        let table = UITableView()
        table.refreshControl = refresher
        table.delegate = self
        table.dataSource = self
        
        return table
    }()
    
    override func loadView() {
        super.loadView()
        view = tableView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loads()
    }
    
    init(tracker: Tracker, viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(tracker: tracker, screen: .feed)
    }
    
    required init?(coder: NSCoder) { nil }
    
    func updateCells(_ viewDatas: [CellViewData]) {
        cellViewDatas = viewDatas
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cellViewDatas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        cell.textLabel?.text = cellViewDatas[indexPath.row].title
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewData = cellViewDatas[indexPath.row]
        viewData.action?(viewData)
    }
    
    private func showLoader() {
        tableView.refreshControl?.beginRefreshing()
    }
    
    private func hideLoader() {
        tableView.refreshControl?.endRefreshing()
    }
    
    private func loads() {
        showLoader()
        viewModel.load()
    }
    
    @objc private func didPullToRefresh() {
        loads()
    }
}
