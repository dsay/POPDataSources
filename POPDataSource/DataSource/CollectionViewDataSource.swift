import UIKit

public protocol CollectionViewDataSource: CollectionDataSource {
    
    func canMoveItem(in collectionView: UICollectionView, for indexPath: IndexPath) -> Bool
    
    func moveItem(in collectionView: UICollectionView, from sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath)
    
}

/**
 *  Optional methods
 */

public extension CollectionViewDataSource {
    
    func canMoveItem(in collectionView: UICollectionView, for indexPath: IndexPath) -> Bool {
        return false
    }
    
    func moveItem(in collectionView: UICollectionView, from sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
    }

}
