import UIKit

/**
 *  Base protocol
 */
public protocol DataContainable {
    associatedtype Item

    var data: [Item] { get }
    
    func numberOfItems() -> Int
    
    func item(at index: Int) -> Item
}

public extension DataContainable {
    
    func numberOfItems() -> Int {
        return data.count
    }
    
    func item(at index: Int) -> Item {
        guard index >= 0 && index < numberOfItems() else {
            fatalError("Index out of bounds")
        }
        
        return data[index]
    }
}

/**
 *  Extension for simple table and collection view
 */
public extension CollectionDataSource where
    Self: DataContainable,
    Self: CellContainable,
    Self.Item == Self.Configurator.Item
{
    typealias Cell = Self.Configurator.CollectionCell
    
    func numberOfSections<T: CollectableView>(for collectionView: T) -> Int {
        return 1
    }
    
    func numberOfRows<T: CollectableView>(for collectionView: T, in section: Int) -> Int {
        return self.numberOfItems()
    }
    
    func cellHeight(for tableView: UITableView, at indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func cell<T: CollectableView>(for collectionView: T, at indexPath: IndexPath) -> T.CollectionCell {
        let item = self.item(at: indexPath.row)
        guard let configurator = self.cellConfigurator,
            let cell = collectionView.dequeueReusableCollectionCell(withIdentifier: configurator.reuseIdentifier(), for: indexPath) as? Cell else
        {
            fatalError("Cell didn't register!!! \n")
        }
        configurator.configurateCell(cell, item: item, at: indexPath)
        return cell as! T.CollectionCell
    }
}

public extension CollectionDataSource where
    Self: CellContainable,
    Self: CellConfigurator
{
    var cellConfigurator: Self? {
        return self
    }
}

/**
 *  Extension for setup header style
 */
public extension TableViewDataSource where
    Self: HeaderContainable,
    Self.Header.SectionView: ReuseIdentifier
{
    typealias HeaderView = Self.Header.SectionView
    
    func headerTitle(for tableView: UITableView, in section: Int) -> String? {
        if let sectionValue = self.header,
            case .title(let text) = sectionValue.section()
        {
            return text
        }
        
        return nil
    }
    
    func headerHeight(for tableView: UITableView, in section: Int) -> CGFloat {
        if let view = headerView(for: tableView, in: section) {
            return height(view, in: section)
        }
        
        return UITableViewAutomaticDimension
    }
    
    func headerView(for tableView: UITableView, in section: Int) -> UIView? {
        guard let sectionValue = self.header,
            case .view(let configurator) = sectionValue.section(),
            let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: HeaderView.identifier) as? HeaderView else
        {
            return nil
        }
        
        configurator(view, section)
        return view
    }
    
    private func height(_ view: UIView,in section: Int) -> CGFloat {
        view.layoutIfNeeded()
        return view.systemLayoutSizeFitting(UILayoutFittingCompressedSize).height
    }
}

public extension TableViewDataSource where
    Self: HeaderContainable,
    Self.Header: SectionSelectable,
    Self.Header.SectionView: ReuseIdentifier
 {
    func willDisplay(header: UIView, for tableView: UITableView, in section: Int) {
        if let headerView = header as? HeaderView,
            let selector = self.header?.selectors[.willDisplayHeader] {
            selector(headerView, section)
        }
    }
}

public extension TableViewDataSource where
    Self: HeaderContainable,
    Self: SectionConfigurator
{
    var header: Self? {
        return self
    }
}

/**
 *  Extension for setup footer style
 */
public extension TableViewDataSource where
    Self: FooterContainable,
    Self.Footer.SectionView: ReuseIdentifier
{
    typealias FooterView = Self.Footer.SectionView
    
    func footerTitle(for tableView: UITableView, in section: Int) -> String? {
        if let sectionValue = self.footer,
            case .title(let text) = sectionValue.section()
        {
            return text
        }
        
        return nil
    }
    
    func footerHeight(for tableView: UITableView, in section: Int) -> CGFloat {
        if let view = footerView(for: tableView, in: section) {
            return height(view, in: section)
        }
        
        return CGFloat.leastNonzeroMagnitude
    }
    
    func footerView(for tableView: UITableView, in section: Int) -> UIView? {
        guard let sectionValue = self.footer,
            case .view(let configurator) = sectionValue.section(),
            let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: FooterView.identifier) as? FooterView else
        {
            return nil
        }
        
        configurator(view, section)
        return view
    }
    
    private func height(_ view: UIView,in section: Int) -> CGFloat {
        view.layoutIfNeeded()
        return view.systemLayoutSizeFitting(UILayoutFittingCompressedSize).height
    }
}

public extension TableViewDataSource where
    Self: FooterContainable,
    Self: SectionConfigurator
{
    var footer: Self? {
        return self
    }
}
/**
 *  Extension setup selector
 */
public extension CollectionDataSource where
    Self: CellContainable,
    Self: DataContainable,
    Self.Item == Self.Configurator.Item,
    Self.Configurator: CellSelectable
    
    
{
    func didSelectRow<T: CollectableView>(in collectionView: T, at indexPath: IndexPath) {
        
        let attributes = self.attributes(in: collectionView, at: indexPath)
        if let selector = self.cellConfigurator?.selectors[.select] {
            selector(attributes.cell, indexPath, attributes.item)
        }
    }
    
    func didHighlightRow<T: CollectableView>(in collectionView: T, at indexPath: IndexPath) {
        let attributes = self.attributes(in: collectionView, at: indexPath)
        if let selector = self.cellConfigurator?.selectors[.highlight] {
            selector(attributes.cell, indexPath, attributes.item)
        }
    }

    func didUnhighlightRow<T: CollectableView>(in collectionView: T, at indexPath: IndexPath) {
        let attributes = self.attributes(in: collectionView, at: indexPath)
        if let selector = self.cellConfigurator?.selectors[.unhighlight] {
            selector(attributes.cell, indexPath, attributes.item)
        }
    }

    func willDisplay<T: CollectableView>(row: T.CollectionCell, in collectionView: T, at indexPath: IndexPath) {
        let item = self.item(at: indexPath.row)
        if let cell = row as? Cell,
            let selector = self.cellConfigurator?.selectors[.willDisplay]
        {
            selector(cell, indexPath, item)
        }
    }
    
    private func attributes<T: CollectableView>(in collectionView: T, at indexPath: IndexPath) -> (cell: Cell, item: Item) {
        let item = self.item(at: indexPath.row)
        guard let cell = collectionView.collectionCellForRow(at: indexPath) as? Cell else {
            fatalError("Cell no found")
        }
        return (cell, item)
    }
}
