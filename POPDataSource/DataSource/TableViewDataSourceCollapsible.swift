import UIKit

public protocol Collapsible:
    class,
    DataContainable,
    CellContainable
{
    var open: Bool { get set }
}

public extension TableViewDataSource where
    Self.Item == Self.Configurator.Item,
    Self: Collapsible
{
    public func numberOfRows<T: CollectableView>(for collectionView: T, in section: Int) -> Int {
        if self.open {
            return self.numberOfItems()
        } else {
            return 0
        }
    }
}
