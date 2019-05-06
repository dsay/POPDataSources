import UIKit

public struct DataSource {
    
    public enum Action {
        case select
        case edit
        case delete
        case highlight
        case unhighlight
        case willDisplay
        case willDisplayHeader
        case willDisplayFooter
        case custom(String)
    }
}

extension DataSource.Action: Hashable, Equatable {
    
    public func hash(into hasher: inout Hasher) {
        var hashValue: Int {
            switch self {
            case .select: return 1
            case .edit: return 2
            case .delete: return 3
            case .highlight: return 4
            case .unhighlight: return 5
            case .willDisplay: return 6
            case .willDisplayHeader: return 7
            case .willDisplayFooter: return 8
            case .custom(let x): return 9 + x.hashValue
            }
        }
        hasher.combine(hashValue)
    }
    
    public static func ==(lhs: DataSource.Action, rhs: DataSource.Action) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
}

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
    
    func configurateCell(_ cell: Cell, item: Item, at indexPath: IndexPath)
}

public extension CellConfigurator where Cell: ReuseIdentifier {
    
    func reuseIdentifier() -> String {
        return Cell.identifier
    }
}

/**
 * Selectable Cell
 */
public protocol CellSelectable: CellConfigurator {
    
    typealias Handler = (Cell, IndexPath, Item) -> ()
    
    var selectors: [DataSource.Action: Handler] { get set }
}

public extension CellSelectable {
    
    func invoke(_ action: DataSource.Action) -> Handler? {
        return self.selectors[action]
    }
    
    mutating func on(_ action: DataSource.Action, handler: @escaping Handler) {
        self.selectors[action] = handler
    }
}
