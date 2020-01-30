import UIKit

/**
 * Selectable Section
 */
public protocol SectionSelectable: SectionConfigurator {
    typealias Handler = (SectionView, Int) -> ()
    
    var selectors: [DataSource.Action: Handler] { get set }
}

public extension SectionSelectable {
    
    func invoke(_ action: DataSource.Action) -> Handler? {
        return self.selectors[action]
    }
    
    mutating func on(_ action: DataSource.Action, handler: @escaping Handler) {
        self.selectors[action] = handler
    }
}
