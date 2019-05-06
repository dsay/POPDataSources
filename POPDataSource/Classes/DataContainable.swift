import UIKit

/**
 *  Base protocol
 */
public protocol DataContainable {
    associatedtype Item

    var data: [Item] { get }
    
    func numberOfItems() -> Int
    
    func item(at index: Int) -> Item
}

public extension DataContainable {
    
    func numberOfItems() -> Int {
        return data.count
    }
    
    func item(at index: Int) -> Item {
        guard index >= 0 && index < numberOfItems() else {
            fatalError("Index out of bounds")
        }
        
        return data[index]
    }
}

/**
 *  Extension for simple table view
 */
public extension TableViewDataSource where
    Self: DataContainable,
    Self: CellContainable,
    Self.Item == Self.Configurator.Item
{
    typealias Cell = Self.Configurator.Cell
    
    func numberOfSections(for tableView: UITableView) -> Int {
        return 1
    }
    
    func numberOfRows(for tableView: UITableView, in section: Int) -> Int {
        return self.numberOfItems()
    }
    
    func cellHeight(for tableView: UITableView, at indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func cell(for tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
        let item = self.item(at: indexPath.row)
        guard let configurator = self.cellConfigurator,
            let cell = tableView.dequeueReusableCell(withIdentifier: configurator.reuseIdentifier()) as? Cell else
        {
            fatalError("Cell didn't register!!! \n" + Cell.description())
        }
        configurator.configurateCell(cell, item: item, at: indexPath)
        return cell
    }
}

public extension TableViewDataSource where
    Self: CellContainable,
    Self: CellConfigurator
{
    var cellConfigurator: Self? {
        return self
    }
}

/**
 *  Extension setup selector
 */
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
    
    private func attributes(in tableView: UITableView, at indexPath: IndexPath) -> (cell: Cell, item: Item) {
        let item = self.item(at: indexPath.row)
        guard let cell = tableView.cellForRow(at: indexPath) as? Cell else {
            fatalError("Cell no found")
        }
        return (cell, item)
    }
}
