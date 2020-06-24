import UIKit

open class SegmentDataSourceShim: TableViewDataSourceShim {
    
    public var selectIndex: Int {
        get {
            return _selectedIndex
        }
        set {
            selectIndex(newValue)
        }
    }
    
    public var dataSources: [TableViewDataSource] {
        didSet {
            selectIndex(0)
        }
    }
    
    private var _selectedIndex = 0
    
    public init(_ dataSources: [TableViewDataSource], tableView: UITableView? = nil) {
        guard let dataSource = dataSources.last else {
            fatalError("DataSeources can't be empty please use EmptyDataSource!")
        }
        self.dataSources = dataSources
        super.init(dataSource)
        self.tableView = tableView
        selectIndex(0)
    }
    
    private func selectIndex(_ index: Int) {
        _selectedIndex = index
        if index >= 0 && index < dataSources.count {
            dataSource = dataSources[index]
            tableView?.reloadData()
        }
    }
}
