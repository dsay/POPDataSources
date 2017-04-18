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
    
    var action :(() -> Void)?
    
    func triggerActionHandleBlock() {
        self.action?()
    }
    
    func actionHandle(_ control :UIControlEvents, ForAction action:@escaping () -> Void) {
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
    
    func animationReload() {
        self.reloadData()
    }
    
    func animationCell() {
        self.reloadData()
        
        let cells = self.visibleCells
        let tableHeight: CGFloat = self.bounds.size.height
        
        for i in cells {
            let cell: UITableViewCell = i as UITableViewCell
            cell.transform = CGAffineTransform(translationX: 0, y:tableHeight)
        }
        
        var index = 0
        
        for a in cells {
            let cell: UITableViewCell = a as UITableViewCell
            
            UIView.animate(withDuration: 1.5, delay: 0.05 * Double(index), usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: [], animations: {
                cell.transform = CGAffineTransform(translationX: 0, y:0)
                
            }, completion: { animation in
                
            })
            index += 1
        }
    }
    
    func show(_ emptyView: UIView) {
        if self.backgroundView != emptyView {
            self.backgroundView = emptyView
        }
    }
    
    func hideEmptyView() {
        self.backgroundView = nil
    }
}

