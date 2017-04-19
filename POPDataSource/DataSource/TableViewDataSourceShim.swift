import UIKit

open class TableViewDataSourceShim: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    public weak var tableView: UITableView?
    public var emptyView: UIView?
    
    public var dataSource: TableViewDataSource {
        didSet {
            tableView?.reloadData()
        }
    }
    
    public init(dataSource: TableViewDataSource) {
        self.dataSource = dataSource
    }
    
    open func numberOfSections(in tableView: UITableView) -> Int {
        let section = dataSource.numberOfSections(for: tableView)
        if let view = emptyView, section == 0 {
            tableView.show(view)
        } else {
            tableView.hideEmptyView()
        }
        
        return section
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
        dataSource.willDisplayRow(in: tableView, at: indexPath)
    }
    
    open func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        dataSource.willDisplayHeader(for: tableView, in: section)
    }
    
    open func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return dataSource.canEditRow(for: tableView, at: indexPath)
    }
    
    open func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        return dataSource.editActions(for: tableView, at: indexPath)
    }
}

open class SegmentDataSourceShim: TableViewDataSourceShim {
    
    public var selectedIndex: Int {
        get {
            return _selectedIndex
        }
        
        set {
            selectIndex(newValue)
        }
    }
    
    private var emptyViews: [UIView]? {
        didSet {
            emptyView = emptyViews?.first
        }
    }
    
    private var dataSources: [TableViewDataSource]
    private var _selectedIndex = 0
    
    public init(_ dataSources: [TableViewDataSource], emptyViews: [UIView]? = nil) {
        self.dataSources = dataSources
        self.emptyViews = emptyViews
        super.init(dataSource: dataSources[0])
    }
    
    public func selectIndex(_ index: Int) {
        _selectedIndex = index
        if index >= 0 && index < dataSources.count {
            dataSource = dataSources[index]
            emptyView = emptyViews?[index]
            
            tableView?.reloadData()
        }
    }
}
