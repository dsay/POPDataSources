import UIKit

/**
 *  Cell
 */
public protocol CellContainable {
    associatedtype Configurator: CellConfigurator
    
    var cellConfigurator: Configurator? { get }
}

/**
 *  Cell configurator
 */
public protocol CellConfigurator {
    associatedtype Item
    associatedtype Cell: (UITableViewCell & ReuseIdentifier)

    func reuseIdentifier() -> String
    
    func configurateCell(_ cell: Cell, for tableView: UITableView, at indexPath: IndexPath, item: Item)
}

public extension CellConfigurator {
    
    func reuseIdentifier() -> String {
        return Cell.identifier
    }
}
