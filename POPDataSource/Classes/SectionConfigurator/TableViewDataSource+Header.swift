import UIKit

/**
* Header
*/
public protocol HeaderContainable {
    associatedtype Header: SectionConfigurator
    
    var header: Header? { get }
}

/**
* Header + TableViewDataSource
*/
public extension TableViewDataSource where
    Self: HeaderContainable,
    Self: SectionConfigurator
{
    var header: Self? {
        return self
    }
}

public extension TableViewDataSource where
    Self: HeaderContainable,
    Self.Header.SectionView: ReuseIdentifier
{
    typealias HeaderView = Self.Header.SectionView

    func headerHeight(for tableView: UITableView, in section: Int) -> CGFloat {
        if let view = headerView(for: tableView, in: section) {
            return height(view, in: section)
        }
        
        return UITableView.automaticDimension
    }
    
    func headerView(for tableView: UITableView, in section: Int) -> UIView? {
        guard let configurator = self.header, let view: HeaderView = tableView.headerFooterView() else {
            return nil
        }
        configurator.configure(view, for: tableView, at: section)
        return view
    }
}

/**
* Header + SectionSelectable
*/
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
    
    func didDisplay(header: UIView, for tableView: UITableView, in section: Int) {
        if let headerView = header as? HeaderView,
            let selector = self.header?.selectors[.didDisplayHeader] {
            selector(headerView, section)
        }
    }
}
