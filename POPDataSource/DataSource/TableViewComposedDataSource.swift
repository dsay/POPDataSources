import UIKit

/**
 *  Composed Data Source
 */
open class ComposedDataSource:
    TableViewDataSource,
    DataSourcesContainable
{ 
    public var dataSources: [TableViewDataSource] = []
    
    public subscript(i: Int) -> TableViewDataSource {
        get {
            return dataSources[i]
        }
        set {
            dataSources[i] = newValue
        }
    }
    
    public init(_ dataSources: [TableViewDataSource] = []) {
        self.dataSources = dataSources
    }
}

/**
 *  Base protocol
 */
public protocol DataSourcesContainable {
    
    typealias DataSource = TableViewDataSource
    
    var dataSources: [TableViewDataSource] { get }
    
    func numberOfSections() -> Int
    
    func dataSource(at index: Int) -> DataSource
}

public extension DataSourcesContainable {
    
    func numberOfSections() -> Int {
        return dataSources.count
    }
    
    func dataSource(at index: Int) -> DataSource {
        guard index >= 0 && index < numberOfSections() else {
            fatalError("Index out of bounds")
        }
        
        return self.dataSources[index]
    }
}

/**
 *  Composed Data Source
 */
public extension TableViewDataSource where Self: DataSourcesContainable {
    
    func numberOfSections<T: CollectableView>(for collectionView: T) -> Int {
        return self.numberOfSections()
    }
    
    func numberOfRows<T: CollectableView>(for collectionView: T, in section: Int) -> Int {
        let dataSource = self.dataSource(at: section)
        return dataSource.numberOfRows(for: collectionView, in: section)
    }
    
    func cellHeight(for tableView: UITableView, at indexPath: IndexPath) -> CGFloat {
        let dataSource = self.dataSource(at: indexPath.section)
        return dataSource.cellHeight(for: tableView, at: indexPath)
    }
    
    func cell<T: CollectableView>(for collectionView: T, at indexPath: IndexPath) -> T.CollectionCell {
        let dataSource = self.dataSource(at: indexPath.section)
        return dataSource.cell(for: collectionView, at: indexPath)
    }
    
    func headerTitle(for tableView: UITableView, in section: Int) -> String? {
        let dataSource = self.dataSource(at: section)
        return dataSource.headerTitle(for: tableView, in: section)
    }
    
    func footerTitle(for tableView: UITableView, in section: Int) -> String? {
        let dataSource = self.dataSource(at: section)
        return dataSource.footerTitle(for: tableView, in: section)
    }
    
    func headerHeight(for tableView: UITableView, in section: Int) -> CGFloat {
        let dataSource = self.dataSource(at: section)
        return dataSource.headerHeight(for: tableView, in: section)
    }
    
    func footerHeight(for tableView: UITableView, in section: Int) -> CGFloat {
        let dataSource = self.dataSource(at: section)
        return dataSource.footerHeight(for: tableView, in: section)
    }
    
    func headerView(for tableView: UITableView, in section: Int) -> UIView? {
        let dataSource = self.dataSource(at: section)
        return dataSource.headerView(for: tableView, in: section)
    }
    
    func footerView(for tableView: UITableView, in section: Int) -> UIView? {
        let dataSource = self.dataSource(at: section)
        return dataSource.footerView(for: tableView, in: section)
    }
    
    func didSelectRow<T: CollectableView>(in collectionView: T, at indexPath: IndexPath) {
        let dataSource = self.dataSource(at: indexPath.section)
        dataSource.didSelectRow(in: collectionView, at: indexPath)
    }
    
    func didHighlightRow<T: CollectableView>(in collectionView: T, at indexPath: IndexPath) {
        let dataSource = self.dataSource(at: indexPath.section)
        dataSource.didHighlightRow(in: collectionView, at: indexPath)
    }
    
    func didUnhighlightRow<T: CollectableView>(in collectionView: T, at indexPath: IndexPath) {
        let dataSource = self.dataSource(at: indexPath.section)
        dataSource.didUnhighlightRow(in: collectionView, at: indexPath)
    }
    
    func willDisplay<T: CollectableView>(row: T.CollectionCell, in collectionView: T, at indexPath: IndexPath) {
        let dataSource = self.dataSource(at: indexPath.section)
        dataSource.willDisplay(row: row, in: collectionView, at: indexPath)
    }
    
    func willDisplay(header: UIView, for tableView: UITableView, in section: Int) {
        let dataSource = self.dataSource(at: section)
        return dataSource.willDisplay(header: header, for: tableView, in: section)
    }
    
    func canEditRow(for tableView: UITableView, at  indexPath: IndexPath) -> Bool {
        let dataSource = self.dataSource(at: indexPath.section)
        return dataSource.canEditRow(for: tableView, at: indexPath)
    }
    
    func editActions(for tableView: UITableView, at indexPath: IndexPath) -> [UITableViewRowAction]? {
        let dataSource = self.dataSource(at: indexPath.section)
        return dataSource.editActions(for: tableView, at: indexPath)
    }
}
