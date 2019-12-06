import UIKit

public protocol DataFilterable:
    class,
    DataContainable,
    CellContainable where Item: Hashable
{
    var hiddenItems: [Item: IndexPath] { get set }
    
    func filtered() -> [Item]
}

public extension TableViewDataSource where
    Self.Item == Self.Configurator.Item,
    Self: DataFilterable
{
    func filtered() -> [Item] {
        return data.filter { hiddenItems[$0] == nil }
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

//public extension DataFilterable where Self: DataContainable  {
//
//    func numberOfItems() -> Int {
//        let items = data.compactMap { }
//        return filteredData.count
//    }
    
//    func item(at index: Int) -> Item {
//        guard index >= 0 && index < numberOfItems() else {
//            fatalError("Index out of bounds")
//        }
//        return filteredData[index]
//    }
//
//    func filter() {
//        guard let action = self.filterAction else {
//            filteredData = data
//            return
//        }
//        filteredData = data.compactMap({ item -> Item? in
//            return action(item)
//        })
//    }
    
//}
