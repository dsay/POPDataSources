//
//  CollectionViewDataSourceShim.swift
//  Pods-DataSources
//
//  Created by Anton Kryzhanovskiy on 3/26/18.
//

import UIKit

open class CollectionViewDataSourceShim: NSObject {
    
    public weak var collectionView: UICollectionView?
    
    public var dataSource: CollectionViewDataSource {
        didSet {
            collectionView?.reloadData()
        }
    }
    
    public init(_ dataSource: CollectionViewDataSource, collectionView: UICollectionView? = nil) {
        self.dataSource = dataSource
        self.collectionView = collectionView
    }

}

open class SegmentCollectionViewDataSourceShim: CollectionViewDataSourceShim {
    
    public var dataSources: [CollectionViewDataSource] {
        didSet {
            collectionView?.reloadData()
        }
    }
    
    public init(_ dataSources: [CollectionViewDataSource], collectionView: UICollectionView? = nil) {
        guard let dataSource = dataSources.last else {
            fatalError("DataSeources can't be empty please use EmptyDataSource!")
        }
        self.dataSources = dataSources
        super.init(dataSource)
        self.collectionView = collectionView
    }
    
}

//MARK: - UICollectionViewDataSource

extension CollectionViewDataSourceShim: UICollectionViewDataSource {
    
    open func numberOfSections(in collectionView: UICollectionView) -> Int {
        return dataSource.numberOfSections(for: collectionView)
    }
    
    open func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.numberOfRows(for: collectionView, in: section)
    }
    
    open func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return dataSource.cell(for: collectionView, at: indexPath)
    }
    
    open func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return dataSource.canMoveItem(in: collectionView, for: indexPath)
    }
    
    open func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        return dataSource.moveItem(in: collectionView, from: sourceIndexPath, to: destinationIndexPath)
    }
    
}

//MARK: - UICollectionViewDelegate

extension CollectionViewDataSourceShim: UICollectionViewDelegate {
    
    open func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        dataSource.didHighlightRow(in: collectionView, at: indexPath)
    }
    
    open func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        dataSource.didUnhighlightRow(in: collectionView, at: indexPath)
    }
    
    open func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        dataSource.didSelectRow(in: collectionView, at: indexPath)
    }
    
    open func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        dataSource.willDisplay(row: cell, in: collectionView, at: indexPath)
    }
}
