import UIKit

public extension Array where Element: Equatable {
    
    func changes(to other: [Element]) ->  (removed: [Int], inserted: [Int])  {
        let otherEnumerated = other.enumerated()
        let selfEnumerated = enumerated()
        let leftCombinations = selfEnumerated.compactMap({ item in
            return (item, otherEnumerated.first(where: { $0.element == item.element }))
        })
        let removedIndexes = leftCombinations.filter { combination -> Bool in
            combination.1 == nil
        }.compactMap { combination in
            combination.0.offset
        }
        let rightCombinations = other.enumerated().compactMap({ item in
            (selfEnumerated.first(where: { $0.element == item.element }), item)
        })
        let insertedIndexes = rightCombinations.filter { combination -> Bool in
            combination.0 == nil
        }.compactMap { combination in
            combination.1.offset
        }
        return (removedIndexes, insertedIndexes)
    }
}
