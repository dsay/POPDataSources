import UIKit

public protocol TableViewDataSource {    
    /**
     *  Base methods
     */
    func numberOfSections(for tableView: UITableView) -> Int
    
    func numberOfRows(for tableView: UITableView, in section: Int) -> Int
    
    func cellHeight(for tableView: UITableView, at indexPath: IndexPath) -> CGFloat

    func cell(for tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell
    
    /**
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
    func didSelectRow(in tableView: UITableView, at indexPath: IndexPath)
    
    func didHighlightRow(in tableView: UITableView, at indexPath: IndexPath)
    
    func didUnhighlightRow(in tableView: UITableView, at indexPath: IndexPath)
    
    func willDisplay(row: UITableViewCell, in tableView: UITableView, at indexPath: IndexPath)
    
    func willDisplay(header: UIView, for tableView: UITableView, in section: Int)
    
    func willDisplay(footer: UIView, for tableView: UITableView, in section: Int)
    
    /**
     *  Edit
     */

    func canEditRow(for tableView: UITableView, at  indexPath: IndexPath) -> Bool
    
    func editActions(for tableView: UITableView, at indexPath: IndexPath) -> [UITableViewRowAction]?
    
    func trailingSwipeActions(for tableView: UITableView, at indexPath: IndexPath) -> UISwipeActionsConfiguration?
    
    func leadingSwipeActions(for tableView: UITableView, at indexPath: IndexPath) -> UISwipeActionsConfiguration?
    
    /**
     *  Scroll
     */
    
    func didStartScrolling(for tableView: UITableView)
    
    func didEndScrolling(for tableView: UITableView)
}

/**
 *  Optional methods
 */
public extension TableViewDataSource {
    func emptyView() -> UIView {
        return UIView()
    }
    
    func numberOfSections(for tableView: UITableView) -> Int {
        return 0
    }
    
    func cellHeight(for tableView: UITableView, at indexPath: IndexPath) -> CGFloat {
        return 0
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
    
    func didSelectRow(in tableView: UITableView, at indexPath: IndexPath) {
    }
    
    func didHighlightRow(in tableView: UITableView, at indexPath: IndexPath) {
    }
    
    func didUnhighlightRow(in tableView: UITableView, at indexPath: IndexPath) {
    }
    
    func willDisplay(row: UITableViewCell, in tableView: UITableView, at indexPath: IndexPath) {
    }
    
    func willDisplay(header: UIView, for tableView: UITableView, in section: Int) {
    }
    
    func willDisplay(footer: UIView, for tableView: UITableView, in section: Int) {
    }
    
    func canEditRow(for tableView: UITableView, at  indexPath: IndexPath) -> Bool {
        return false
    }
    
    func editActions(for tableView: UITableView, at indexPath: IndexPath) -> [UITableViewRowAction]? {
        return nil
    }
    
    func trailingSwipeActions(for tableView: UITableView, at indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        return nil
    }
    
    func leadingSwipeActions(for tableView: UITableView, at indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        return nil
    }

    func didStartScrolling(for tableView: UITableView) {
        
    }
    
    func didEndScrolling(for tableView: UITableView) {
        
    }
}
