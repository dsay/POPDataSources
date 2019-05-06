import UIKit

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
        
        return UITableView.automaticDimension
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
        return view.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
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
