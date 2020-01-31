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

public extension TableViewDataSource where
    Self: CellContainable,
    Self: CellConfigurator
{
    var cellConfigurator: Self? {
        return self
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
            let cell: Cell = tableView.cellView() else
        {
            fatalError("Cell didn't register!!! \n" + Cell.description())
        }
        configurator.configurateCell(cell, for: tableView, at: indexPath, item: item)
        return cell
    }
}
