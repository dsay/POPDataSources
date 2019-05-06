import UIKit

public enum HeaderFooterView <Section: UIView>{
    case title(String)
    case view((Section, Int) -> ())
    case none
}

public protocol HeaderContainable {
    associatedtype Header: SectionConfigurator
    
    var header: Header? { get }
}

public protocol FooterContainable {
    associatedtype Footer: SectionConfigurator
    
    var footer: Footer? { get }
}

/**
 *  Section configurator
 */
public protocol SectionConfigurator {
    associatedtype SectionView: UIView
    
    func section() -> HeaderFooterView<SectionView>
}

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
