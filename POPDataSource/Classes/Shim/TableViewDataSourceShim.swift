import UIKit

internal enum Section: Int {
    case header, footer
}

open class TableViewDataSourceShim: NSObject {
    
    public var isNeedCacheCell: Bool = true
    public var isNeedCacheSection: Bool = true

    public var emptyView: UIView?
    public weak var tableView: UITableView?

    public var dataSource: TableViewDataSource {
        didSet {
            tableView?.reloadData()
            
            rowCache.removeAll()
            headerCache.removeAll()
            footerCache.removeAll()
        }
    }
        
    internal var rowCache = [IndexPath: CGFloat]()
    
    internal var headerCache = [Int: CGFloat]()
    internal var footerCache = [Int: CGFloat]()
    
    public init(_ dataSource: TableViewDataSource, tableView: UITableView? = nil) {
        self.dataSource = dataSource
        self.tableView = tableView
    }
    
    internal func emptyView(for numberOfRows: Int) {
         if numberOfRows == 0 {
             tableView?.show(emptyView)
         } else {
             tableView?.hideEmptyView()
         }
     }
    
    internal subscript (i: Int, section: Section) -> CGFloat? {
        get {
            return (section == .header) ? headerCache[i] : footerCache[i]
        }
        set {
            guard isNeedCacheSection else { return }
            
            if section == .header {
                headerCache[i] = newValue
            } else {
                footerCache[i] = newValue
            }
        }
    }
    
    internal subscript (cell: IndexPath) -> CGFloat? {
        get {
            return rowCache[cell]
        }
        set {
            guard isNeedCacheCell else { return }
            
            rowCache[cell] = newValue
        }
    }
}
