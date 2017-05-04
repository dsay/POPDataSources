import UIKit

open class TableViewDataSourceShim: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    public weak var tableView: UITableView?
    
    public var dataSource: TableViewDataSource {
        didSet {
           tableView?.reloadData()
        }
    }
    
    public init(_ dataSource: TableViewDataSource = EmptyDataSource(), tableView: UITableView? = nil) {
        self.dataSource = dataSource
        self.tableView = tableView
    }
    
    internal func emptyView(for numberOfSections: Int) {
        if numberOfSections == 0 {
            tableView?.show(dataSource.emptyView())
        } else {
            tableView?.hideEmptyView()
        }
    }
    
    open func numberOfSections(in tableView: UITableView) -> Int {
        let numberOfSections = dataSource.numberOfSections(for: tableView)
        emptyView(for: numberOfSections)
        return numberOfSections
    }
    
    open func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return dataSource.cellHeight(for: tableView, at: indexPath)
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
    
    open func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return dataSource.headerHeight(for: tableView, in: section)
    }
    
    open func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return dataSource.footerHeight(for: tableView, in: section)
    }
    
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
    
    open func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return dataSource.canEditRow(for: tableView, at: indexPath)
    }
    
    open func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        return dataSource.editActions(for: tableView, at: indexPath)
    }
}

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
    
    public init(_ dataSources: [TableViewDataSource] = [], tableView: UITableView? = nil) {
        self.dataSources = dataSources
        super.init()
        self.tableView = tableView
        selectIndex(0)
    }
    
    private var _selectedIndex = 0
    
    private func selectIndex(_ index: Int) {
        _selectedIndex = index
        if index >= 0 && index < dataSources.count {
            dataSource = dataSources[index]
            tableView?.reloadData()
        }
    }
}

fileprivate struct EmptyDataSource: TableViewDataSource {
    
    func numberOfRows(for tableView: UITableView, in section: Int) -> Int {
        return 0
    }
    
    func cell(for tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
