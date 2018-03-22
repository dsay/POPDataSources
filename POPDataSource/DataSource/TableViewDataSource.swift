import UIKit

public protocol CollectableCell {
    associatedtype CollectionCell
}

public protocol CollectableView: CollectableCell {
    
    func dequeueReusableCollectionCell(withIdentifier identifier: String, for indexPath: IndexPath) -> CollectionCell?
    
}

extension UITableView: CollectableView {
    public typealias CollectionCell = UITableViewCell
    
    public func dequeueReusableCollectionCell(withIdentifier identifier: String) -> UITableViewCell? {
        return self.dequeueReusableCell(withIdentifier: identifier)
    }
    
    public func dequeueReusableCollectionCell(withIdentifier identifier: String, for indexPath: IndexPath) -> UITableViewCell? {
        return self.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
    }
}

extension UICollectionView: CollectableView {
    public typealias CollectionCell = UICollectionViewCell
    
    public func dequeueReusableCollectionCell(withIdentifier identifier: String, for indexPath: IndexPath) -> UICollectionViewCell? {
        return self.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
    }
}

public protocol CollectionDataSource {
    
    func numberOfSections<T: CollectableView>(for collectionView: T) -> Int
    
    func numberOfRows<T: CollectableView>(for collectionView: T, in section: Int) -> Int
    
    func cell<T: CollectableView>(for collectionView: T, at indexPath: IndexPath) -> T.CollectionCell
    
    func didSelectRow<T: CollectableView>(in collectionView: T, at indexPath: IndexPath)
    
    func didHighlightRow<T: CollectableView>(in collectionView: T, at indexPath: IndexPath)
    
    func didUnhighlightRow<T: CollectableView>(in collectionView: T, at indexPath: IndexPath)
    
    func willDisplay<T: CollectableView>(row: T.CollectionCell, in collectionView: T, at indexPath: IndexPath)
}

public protocol TableViewDataSource: CollectionDataSource {
    func emptyView() -> UIView
    
    /**
     *  Base methods
     */
    
    func cellHeight(for tableView: UITableView, at indexPath: IndexPath) -> CGFloat

//    func cell(for tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell
    
    /**pod
     *  Section configurator methods
     */
    func headerTitle(for tableView: UITableView, in section: Int) -> String?
    
    func footerTitle(for tableView: UITableView, in section: Int) -> String?
    
    func headerHeight(for tableView: UITableView, in section: Int) -> CGFloat
    
    func footerHeight(for tableView: UITableView, in section: Int) -> CGFloat
    
    func headerView(for tableView: UITableView, in section: Int) -> UIView?
    
    func footerView(for tableView: UITableView, in section: Int) -> UIView?
    
    /**
     *  Selectors
     */

//    func willDisplay(row: UITableViewCell, in tableView: UITableView, at indexPath: IndexPath)
    
    func willDisplay(header: UIView, for tableView: UITableView, in section: Int)
    
    func canEditRow(for tableView: UITableView, at  indexPath: IndexPath) -> Bool
    
    func editActions(for tableView: UITableView, at indexPath: IndexPath) -> [UITableViewRowAction]?
}

/**
 *  Optional methods
 */
public extension TableViewDataSource {
    func emptyView() -> UIView {
        return UIView()
    }
    
    func numberOfSections<T: CollectableView>(for collectionView: T) -> Int {
        return 0
    }
    
//    func numberOfSections(for tableView: UITableView) -> Int {
//        return 0
//    }
    
    func cellHeight(for tableView: UITableView, at indexPath: IndexPath) -> CGFloat {
        return 0
    }
    
    func headerTitle(for tableView: UITableView, in section: Int) -> String? {
        return nil
    }
    
    func footerTitle(for tableView: UITableView, in section: Int) -> String? {
        return nil
    }
    
    func headerHeight(for tableView: UITableView, in section: Int) -> CGFloat {
        return CGFloat.leastNonzeroMagnitude
    }
    
    func footerHeight(for tableView: UITableView, in section: Int) -> CGFloat {
        return CGFloat.leastNonzeroMagnitude
    }
    
    func headerView(for tableView: UITableView, in section: Int) -> UIView? {
        return nil
    }
    
    func footerView(for tableView: UITableView, in section: Int) -> UIView? {
        return nil
    }
    
    func didSelectRow<T: CollectableView>(in collectionView: T, at indexPath: IndexPath) {
        
    }
    
    func didHighlightRow<T: CollectableView>(in collectionView: T, at indexPath: IndexPath) {
    }
    
    func didUnhighlightRow<T: CollectableView>(in collectionView: T, at indexPath: IndexPath) {
    }
    
    func willDisplay<T: CollectableView>(row: T.CollectionCell, in collectionView: T, at indexPath: IndexPath) {
    }
    
    func willDisplay(header: UIView, for tableView: UITableView, in section: Int){
    }
    
    func canEditRow(for tableView: UITableView, at  indexPath: IndexPath) -> Bool {
        return false
    }
    
    func editActions(for tableView: UITableView, at indexPath: IndexPath) -> [UITableViewRowAction]? {
        return nil
    }
}
