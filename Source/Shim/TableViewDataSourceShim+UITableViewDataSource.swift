import UIKit

extension TableViewDataSourceShim: UITableViewDataSource {
    
    open func numberOfSections(in tableView: UITableView) -> Int {
        let numberOfSections = dataSource.numberOfSections(for: tableView)
        
        let numberOfRows = (0..<numberOfSections)
            .map { dataSource.numberOfRows(for: tableView, in: $0) }
            .reduce(0) { $0 + $1 }
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
