import UIKit

/**
 *  Section configurator
 */
public protocol SectionConfigurator {
    associatedtype SectionView: UIView
    
    func configure(_ section: SectionView, for tableView: UITableView, at index: Int)
}
