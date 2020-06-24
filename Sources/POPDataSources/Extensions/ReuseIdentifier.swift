import UIKit

public protocol ReuseIdentifier: class {
    static var identifier: String { get }
}

public extension ReuseIdentifier where Self: UIView {
    
    static var identifier: String {
        let type = String(describing: self)
        return type
    }
}
