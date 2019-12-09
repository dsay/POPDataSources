import UIKit

public protocol ReuseIdentifier {
    static var identifier: String { get }
}

public extension ReuseIdentifier where Self: UIView {
    
    static var identifier: String {
        let type = String(describing: self)
        return type
    }
}

public extension UITableView {
    
    func register<T: ReuseIdentifier>(_ headerFooterView: T.Type)  {
        let identifier = headerFooterView.identifier
        self.register(UINib(nibName: identifier , bundle: nil), forHeaderFooterViewReuseIdentifier: identifier)
    }
    
    func register<T: ReuseIdentifier>(cell: T.Type)  {
        let identifier = cell.identifier
        self.register(UINib(nibName: identifier , bundle: nil), forCellReuseIdentifier: identifier)
    }
}

public class EmptyView : UIView, ReuseIdentifier {
    
}

public class ActionHandleButton : UIButton {
    
    private var action: (() -> Void)?
    
    @objc internal func triggerActionHandleBlock() {
        self.action?()
    }
    
    public func actionHandle(_ control :UIControl.Event, ForAction action:@escaping () -> Void) {
        self.action = action
        self.addTarget(self, action: #selector(ActionHandleButton.triggerActionHandleBlock), for: control)
    }
}

public extension UITableView {
    
    func collapse<T: Collapsible>(_ dataSource: T, at section: Int = 0) {
        let indexPaths = (0..<dataSource.numberOfItems()).map {
            IndexPath(row: $0, section: section)
        }
        
        dataSource.open = false
        
        self.deleteRows(at: indexPaths, with: .fade)
    }
    
    func expand<T: Collapsible>(_ dataSource: T, at section: Int = 0) {
        let indexPaths = (0..<dataSource.numberOfItems()).map {
            IndexPath(row: $0, section: section)
        }
        
        dataSource.open = true
        
        self.insertRows(at: indexPaths, with: .fade)
    }
}

public extension UITableView {
    
    func show(_ emptyView: UIView?) {
        if let view = emptyView, self.backgroundView != view {
            self.backgroundView = view
        }
    }
    
    func hideEmptyView() {
        self.backgroundView = nil
    }
}

public extension UITableView {
    
    func filter<T: DataFilterable>(_ dataSource: T, at section: Int = 0, action: () -> Void ) {
        let origin = dataSource.filtered()
        
        action()

        let diff = origin.changes(to: dataSource.filtered())
        let deleted = diff.removed.map({ IndexPath(row: $0, section: section)})
        let inserted = diff.inserted.map({ IndexPath(row: $0, section: section)})
        beginUpdates()
        if !deleted.isEmpty { deleteRows(at: deleted, with: .automatic) }
        if !inserted.isEmpty { insertRows(at: inserted, with: .automatic) }
        endUpdates()
    }
}

private extension Array where Element: Equatable {
    
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
