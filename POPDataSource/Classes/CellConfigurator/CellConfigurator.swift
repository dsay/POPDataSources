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
    associatedtype Cell: UITableViewCell

    func reuseIdentifier() -> String
    
    func configurateCell(_ cell: Cell, for tableView: UITableView, at indexPath: IndexPath, item: Item)
}

public extension CellConfigurator where Cell: ReuseIdentifier {
    
    func reuseIdentifier() -> String {
        return Cell.identifier
    }
}
