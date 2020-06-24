import UIKit

public extension TableViewDataSource where
    Self: CellContainable,
    Self: DataContainable,
    Self.Item == Self.Configurator.Item,
    Self.Configurator: CellSelectable
{
    func didSelectRow(in tableView: UITableView, at indexPath: IndexPath) {
        let attributes = self.attributes(in: tableView, at: indexPath)
        if let selector = self.cellConfigurator?.selectors[.select] {
            selector(attributes.cell, indexPath, attributes.item)
        }
    }
    
    func didHighlightRow(in tableView: UITableView, at indexPath: IndexPath) {
        let attributes = self.attributes(in: tableView, at: indexPath)
        if let selector = self.cellConfigurator?.selectors[.highlight] {
            selector(attributes.cell, indexPath, attributes.item)
        }
    }
    
    func didUnhighlightRow(in tableView: UITableView, at indexPath: IndexPath) {
        let attributes = self.attributes(in: tableView, at: indexPath)
        if let selector = self.cellConfigurator?.selectors[.unhighlight] {
            selector(attributes.cell, indexPath, attributes.item)
        }
    }
    
    func willDisplay(row: UITableViewCell, in tableView: UITableView, at indexPath: IndexPath) {
        let item = self.item(at: indexPath.row)
        if let cell = row as? Cell,
            let selector = self.cellConfigurator?.selectors[.willDisplay]
        {
            selector(cell, indexPath, item)
        }
    }
}
