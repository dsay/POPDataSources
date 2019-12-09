import UIKit

fileprivate enum Section: Int {
    case header, footer
}

open class TableViewDataSourceShim: NSObject {
    
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
    
    private var rowCache = [IndexPath: CGFloat]()
    
    private var headerCache = [Int: CGFloat]()
    private var footerCache = [Int: CGFloat]()
    
    public init(_ dataSource: TableViewDataSource, tableView: UITableView? = nil) {
        self.dataSource = dataSource
        self.tableView = tableView
    }
    
    private func emptyView(for numberOfRows: Int) {
         if numberOfRows == 0 {
             tableView?.show(emptyView)
         } else {
             tableView?.hideEmptyView()
         }
     }
    
    fileprivate subscript (i: Int, section: Section) -> CGFloat? {
        get {
            return (section == .header) ? headerCache[i] : footerCache[i]
        }
        set {
            if section == .header { headerCache[i] = newValue } else { footerCache[i] = newValue }
        }
    }
    
    fileprivate subscript (cell: IndexPath) -> CGFloat? {
        get {
            return rowCache[cell]
        }
        set {
            rowCache[cell] = newValue
        }
    }
}

extension TableViewDataSourceShim: UITableViewDataSource {
    
    open func numberOfSections(in tableView: UITableView) -> Int {
        let numberOfSections = dataSource.numberOfSections(for: tableView)
        
        let numberOfRows = (0..<numberOfSections).map { dataSource.numberOfRows(for: tableView, in: $0) }.reduce(0) { $0 + $1 }
        emptyView(for: numberOfRows)
        
        return numberOfSections
    }
    
    open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.numberOfRows(for: tableView, in: section)
    }
    
    open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return dataSource.cell(for: tableView, at: indexPath)
    }
    
    open func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return dataSource.headerTitle(for: tableView, in: section)
    }
    
    open func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return dataSource.footerTitle(for: tableView, in: section)
    }
    
    open func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return dataSource.canEditRow(for: tableView, at: indexPath)
    }
    
    open func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        return dataSource.editActions(for: tableView, at: indexPath)
    }
    
    open func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        return dataSource.trailingSwipeActions(for: tableView, at: indexPath)
    }
    
    open func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        return dataSource.leadingSwipeActions(for: tableView, at: indexPath)
    }
}

extension TableViewDataSourceShim: UITableViewDelegate {
    
    open func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return dataSource.headerView(for: tableView, in: section)
    }
    
    open func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return dataSource.footerView(for: tableView, in: section)
    }
    
    open func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dataSource.didSelectRow(in: tableView, at: indexPath)
    }
    
    open func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        dataSource.didHighlightRow(in: tableView, at: indexPath)
    }
    
    open func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        dataSource.didUnhighlightRow(in: tableView, at: indexPath)
    }
    
    open func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        dataSource.willDisplay(row: cell, in: tableView, at: indexPath)
    }
    
    open func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        dataSource.willDisplay(header: view, for: tableView, in: section)
    }
    
    open func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self[indexPath] ?? dataSource.cellHeight(for: tableView, at: indexPath)
    }
    
    open func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return self[section, .header] ?? dataSource.headerHeight(for: tableView, in: section)
    }
    
    open func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return self[section, .footer] ?? dataSource.footerHeight(for: tableView, in: section)
    }
    
    open func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        self[indexPath] = cell.bounds.height
    }
    
    open func tableView(_ tableView: UITableView, didEndDisplayingHeaderView view: UIView, forSection section: Int) {
        if view.bounds.height >= 1 {
             self[section, .header] = view.bounds.height
        }
    }
    
    open func tableView(_ tableView: UITableView, didEndDisplayingFooterView view: UIView, forSection section: Int) {
        if view.bounds.height >= 1 {
            self[section, .footer] = view.bounds.height
        }
    }
}
