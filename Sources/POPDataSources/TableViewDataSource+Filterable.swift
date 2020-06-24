import UIKit

public protocol DataFilterable:
    class,
    DataContainable,
    CellContainable where Item: Hashable
{
    var hiddenItems: [Item] { get set }
    
    func filtered() -> [Item]
}

public extension TableViewDataSource where
    Self.Item == Self.Configurator.Item,
    Self: DataFilterable
{
    func filtered() -> [Item] {
        return data.filter { hiddenItems.contains($0) == false }
    }
    
    func numberOfItems() -> Int {
        return filtered().count
    }
    
    func item(at index: Int) -> Item {
        guard index >= 0 && index < numberOfItems() else {
            fatalError("Index out of bounds")
        }
        
        return filtered()[index]
    }
}
