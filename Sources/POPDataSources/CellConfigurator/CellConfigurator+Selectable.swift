import UIKit

/**
 * Selectable Cell
 */
public protocol CellSelectable: CellConfigurator {
    
    typealias Handler = (CellView, IndexPath, Item) -> ()
    
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
