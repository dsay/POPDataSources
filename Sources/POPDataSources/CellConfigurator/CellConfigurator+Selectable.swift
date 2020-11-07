import UIKit

/**
 * Selectable Cell
 */
public protocol CellSelectable: CellConfigurator {
    
    typealias Handler = (CellView, IndexPath, Item) -> ()
    
    var selectors: [Action: Handler] { get set }
}

public extension CellSelectable {
    
    func invoke(_ action: Action) -> Handler? {
        return self.selectors[action]
    }
    
    mutating func on(_ action: Action, handler: @escaping Handler) {
        self.selectors[action] = handler
    }
}
