import UIKit

/**
* Footer
*/
public protocol FooterContainable {
    associatedtype Footer: SectionConfigurator
    
    var footer: Footer? { get }
}

/**
* Footer + TableViewDataSource
*/
public extension TableViewDataSource where
    Self: FooterContainable,
    Self: SectionConfigurator
{
    var footer: Self? {
        return self
    }
}

public extension TableViewDataSource where
    Self: FooterContainable,
    Self.Footer.SectionView: ReuseIdentifier
{
    typealias FooterView = Self.Footer.SectionView
    
    func footerHeight(for tableView: UITableView, in section: Int) -> CGFloat {
        if let view = footerView(for: tableView, in: section) {
            return height(view, in: section)
        }
        
        return CGFloat.leastNonzeroMagnitude
    }
    
    func footerView(for tableView: UITableView, in section: Int) -> UIView? {
        guard let configurator = self.footer, let view: FooterView = tableView.headerFooterView() else {
            return nil
        }
        
        configurator.configure(view, for: tableView, at: section)
        return view
    }
}
