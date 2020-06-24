import UIKit

extension TableViewDataSourceShim: UITableViewDelegate {
    
    open func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return dataSource.headerView(for: tableView, in: section)
    }
    
    open func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return dataSource.footerView(for: tableView, in: section)
    }
    
    open func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dataSource.didSelectRow(in: tableView, at: indexPath)
    }
    
    open func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        dataSource.didHighlightRow(in: tableView, at: indexPath)
    }
    
    open func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        dataSource.didUnhighlightRow(in: tableView, at: indexPath)
    }
    
    open func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        dataSource.willDisplay(row: cell, in: tableView, at: indexPath)
    }
    
    open func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        dataSource.willDisplay(header: view, for: tableView, in: section)
    }
    
    open func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self[indexPath] ?? dataSource.cellHeight(for: tableView, at: indexPath)
    }
    
    open func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return self[section, .header] ?? dataSource.headerHeight(for: tableView, in: section)
    }
    
    open func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return self[section, .footer] ?? dataSource.footerHeight(for: tableView, in: section)
    }
    
    open func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        self[indexPath] = cell.bounds.height
    }
    
    open func tableView(_ tableView: UITableView, didEndDisplayingHeaderView view: UIView, forSection section: Int) {
        if view.bounds.height >= 1 {
             self[section, .header] = view.bounds.height
        }
    }
    
    open func tableView(_ tableView: UITableView, didEndDisplayingFooterView view: UIView, forSection section: Int) {
        if view.bounds.height >= 1 {
            self[section, .footer] = view.bounds.height
        }
    }
    
    open func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if let tableView = scrollView as? UITableView, scrollView.isDecelerating {
            dataSource.didStartScrolling(for: tableView)
        }
    }
    
    open func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if let tableView = scrollView as? UITableView, !decelerate {
            dataSource.didEndScrolling(for: tableView)
        }
    }
    
    open func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if let tableView = scrollView as? UITableView {
            dataSource.didEndScrolling(for: tableView)
        }
    }
}
