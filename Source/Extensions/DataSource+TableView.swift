import UIKit

public extension UITableView {
    
    func cellView<T: ReuseIdentifier>() -> T? {
        return dequeueReusableCell(withIdentifier: T.identifier) as? T
    }
    
    func headerFooterView<T: ReuseIdentifier>() -> T? {
        return dequeueReusableHeaderFooterView(withIdentifier: T.identifier) as? T
    }
    
    func register<T: ReuseIdentifier>(class: T.Type)  {
        let identifier = T.identifier
        self.register(T.self, forCellReuseIdentifier: identifier)
    }
    
    func register<T: ReuseIdentifier>(headerFooterViewClass: T.Type)  {
        let identifier = T.identifier
        self.register(T.self, forHeaderFooterViewReuseIdentifier: identifier)
    }
    
    func register<T: ReuseIdentifier>(_ headerFooterView: T.Type)  {
        let identifier = headerFooterView.identifier
        self.register(UINib(nibName: identifier , bundle: nil), forHeaderFooterViewReuseIdentifier: identifier)
    }
    
    func register<T: ReuseIdentifier>(cell: T.Type)  {
        let identifier = cell.identifier
        self.register(UINib(nibName: identifier , bundle: nil), forCellReuseIdentifier: identifier)
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
