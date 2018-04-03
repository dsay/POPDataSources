import UIKit



public protocol TableViewDataSource: CollectionDataSource {
    func emptyView() -> UIView
    
    /**
     *  Base methods
     */
    
    func cellHeight(for tableView: UITableView, at indexPath: IndexPath) -> CGFloat
    
    /**pod
     *  Section configurator methods
     */
    func headerTitle(for tableView: UITableView, in section: Int) -> String?
    
    func footerTitle(for tableView: UITableView, in section: Int) -> String?
    
    func headerHeight(for tableView: UITableView, in section: Int) -> CGFloat
    
    func footerHeight(for tableView: UITableView, in section: Int) -> CGFloat
    
    func headerView(for tableView: UITableView, in section: Int) -> UIView?
    
    func footerView(for tableView: UITableView, in section: Int) -> UIView?
    
    /**
     *  Selectors
     */
    
    func willDisplay(header: UIView, for tableView: UITableView, in section: Int)
    
    func canEditRow(for tableView: UITableView, at  indexPath: IndexPath) -> Bool
    
    func editActions(for tableView: UITableView, at indexPath: IndexPath) -> [UITableViewRowAction]?
}

/**
 *  Optional methods
 */
public extension TableViewDataSource {
    func emptyView() -> UIView {
        return UIView()
    }
    
    func headerTitle(for tableView: UITableView, in section: Int) -> String? {
        return nil
    }
    
    func footerTitle(for tableView: UITableView, in section: Int) -> String? {
        return nil
    }
    
    func headerHeight(for tableView: UITableView, in section: Int) -> CGFloat {
        return CGFloat.leastNonzeroMagnitude
    }
    
    func footerHeight(for tableView: UITableView, in section: Int) -> CGFloat {
        return CGFloat.leastNonzeroMagnitude
    }
    
    func headerView(for tableView: UITableView, in section: Int) -> UIView? {
        return nil
    }
    
    func footerView(for tableView: UITableView, in section: Int) -> UIView? {
        return nil
    }
    
    func willDisplay(header: UIView, for tableView: UITableView, in section: Int){
    }
    
    func canEditRow(for tableView: UITableView, at  indexPath: IndexPath) -> Bool {
        return false
    }
    
    func editActions(for tableView: UITableView, at indexPath: IndexPath) -> [UITableViewRowAction]? {
        return nil
    }
}
