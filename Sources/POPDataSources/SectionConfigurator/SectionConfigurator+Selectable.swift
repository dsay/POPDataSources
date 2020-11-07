import UIKit

/**
 * Selectable Section
 */
public protocol SectionSelectable: SectionConfigurator {
    typealias Handler = (SectionView, Int) -> ()
    
    var selectors: [Action: Handler] { get set }
}

public extension SectionSelectable {
    
    func invoke(_ action: Action) -> Handler? {
        return self.selectors[action]
    }
    
    mutating func on(_ action: Action, handler: @escaping Handler) {
        self.selectors[action] = handler
    }
}
