import UIKit

public protocol SingleObject {
    associatedtype Item
    
    var item: Item { get set}
}

public extension TableViewDataSource where Self: SingleObject & DataContainable {
    
    var data: [Item] { return [item] }
}
