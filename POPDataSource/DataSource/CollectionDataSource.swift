import UIKit

public protocol CollectionDataSource {
    
    func numberOfSections<T: CollectableView>(for collectionView: T) -> Int
    
    func numberOfRows<T: CollectableView>(for collectionView: T, in section: Int) -> Int
    
    func cell<T: CollectableView>(for collectionView: T, at indexPath: IndexPath) -> T.CollectionCell
    
    func didSelectRow<T: CollectableView>(in collectionView: T, at indexPath: IndexPath)
    
    func didHighlightRow<T: CollectableView>(in collectionView: T, at indexPath: IndexPath)
    
    func didUnhighlightRow<T: CollectableView>(in collectionView: T, at indexPath: IndexPath)
    
    func willDisplay<T: CollectableView>(row: T.CollectionCell, in collectionView: T, at indexPath: IndexPath)
}

public extension CollectionDataSource {
    
    func numberOfSections<T: CollectableView>(for collectionView: T) -> Int {
        return 0
    }
    
    func didSelectRow<T: CollectableView>(in collectionView: T, at indexPath: IndexPath) {
    }
    
    func didHighlightRow<T: CollectableView>(in collectionView: T, at indexPath: IndexPath) {
    }
    
    func didUnhighlightRow<T: CollectableView>(in collectionView: T, at indexPath: IndexPath) {
    }
    
    func willDisplay<T: CollectableView>(row: T.CollectionCell, in collectionView: T, at indexPath: IndexPath) {
    }
}

public protocol CollectableCell {
    associatedtype CollectionCell
}

public protocol CollectableView: CollectableCell {
    
    func dequeueReusableCollectionCell(withIdentifier identifier: String, for indexPath: IndexPath) -> CollectionCell?
    func collectionCellForRow(at indexPath: IndexPath) -> CollectionCell?
}

extension UITableView: CollectableView {
    public typealias CollectionCell = UITableViewCell
    
    public func dequeueReusableCollectionCell(withIdentifier identifier: String, for indexPath: IndexPath) -> UITableViewCell? {
        return self.dequeueReusableCell(withIdentifier: identifier)
    }
    
    public func collectionCellForRow(at indexPath: IndexPath) -> UITableViewCell? {
        return self.cellForRow(at:indexPath)
    }
}

extension UICollectionView: CollectableView {
    public typealias CollectionCell = UICollectionViewCell
    
    public func dequeueReusableCollectionCell(withIdentifier identifier: String, for indexPath: IndexPath) -> UICollectionViewCell? {
        return self.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
    }
    
    public func collectionCellForRow(at indexPath: IndexPath) -> UICollectionViewCell? {
        return self.cellForItem(at:indexPath)
    }
}
