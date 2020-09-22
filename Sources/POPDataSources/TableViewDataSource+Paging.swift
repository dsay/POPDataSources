import UIKit

open class PagingDataSource: TableViewDataSource, DataSourcesContainable {
    
    public enum Status {
        case new
        case normal
        case loading
        case reachedLast
    }
    
    public typealias Result = (Bool, [TableViewDataSource]) -> Void
    public typealias Loader = (_ result: @escaping Result) -> Void
    
    public var status: Status = .new
    public var dataSources: [TableViewDataSource] = []
    public var spinner = UIActivityIndicatorView(style: .gray)

    private let loader: Loader!
    private weak var tableView: UITableView?
    
    public init(_ dataSources: [TableViewDataSource] = [], _ loader: @escaping Loader) {
        self.dataSources = dataSources
        self.loader = loader
    }
    
    public func numberOfSections(for tableView: UITableView) -> Int {
        self.tableView = tableView
        
        if status == .loading {
            startAnimation()
        }
        
        return numberOfSections()
    }
    
    public func willDisplay(row: UITableViewCell, in tableView: UITableView, at indexPath: IndexPath) {
        let dataSource = self.dataSource(at: indexPath.section)
        dataSource.willDisplay(row: row, in: tableView, at: indexPath)
        
        let lastSectionIndex = tableView.numberOfSections - 1
        let lastRowIndex = tableView.numberOfRows(inSection: lastSectionIndex) - 1
        if indexPath.section ==  lastSectionIndex && indexPath.row == lastRowIndex {
            willDisplayLastCell()
        }
    }
    
   private func willDisplayLastCell() {
        guard status != .reachedLast else { return }
        
        startAnimation()
        
        status = .loading

        loader({ [weak self] isReachedLast, dataSources in
            if isReachedLast {
                 self?.status = .reachedLast
            } else {
                self?.status = .normal
            }
            self?.stopAnimation()
            self?.dataSources += dataSources
            self?.tableView?.reloadData()
        })
    }
    
    public func reloadData() {
        
        startAnimation()
        
        status = .loading
        
        loader({ [weak self] isReachedLast, dataSources in
            if isReachedLast {
                self?.status = .reachedLast
            } else {
                self?.status = .normal
            }
            self?.stopAnimation()
            self?.dataSources = dataSources
            self?.tableView?.reloadData()
        })
    }

    public func isAnimated() ->  Bool {
        return status == .loading
    }
    
    public func startAnimation() {
        guard let tableView = tableView else { return }
        
        spinner.startAnimating()
        spinner.frame = CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 44)
        
        tableView.tableFooterView = spinner
    }
    
    public func stopAnimation() {
        guard let tableView = tableView else { return }
        
        tableView.tableFooterView = nil
        
        tableView.setContentOffset(tableView.contentOffset, animated: false)
    }
}
