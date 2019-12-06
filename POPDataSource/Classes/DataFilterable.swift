//
//  DataFilterable.swift
//  Pods-POPDataSource_Example
//
//  Created by User on 06.12.2019.
//

import Foundation

public protocol DataFilterable: class {
    associatedtype Item: Equatable
    var filteredData: [Item] { get set }
    var filterAction: ((Item) -> Item?)? { get }
    func filter()
}

public extension DataFilterable where Self: DataContainable  {
    
    func numberOfItems() -> Int {
        return filteredData.count
    }
    
    func item(at index: Int) -> Item {
        guard index >= 0 && index < numberOfItems() else {
            fatalError("Index out of bounds")
        }
        return filteredData[index]
    }
    
    func filter() {
        guard let action = self.filterAction else {
            filteredData = data
            return
        }
        filteredData = data.compactMap({ item -> Item? in
            return action(item)
        })
    }
    
}
