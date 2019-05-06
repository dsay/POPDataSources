import UIKit

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
        return view.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
    }
}
