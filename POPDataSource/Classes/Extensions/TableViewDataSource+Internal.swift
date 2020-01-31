import UIKit

public extension TableViewDataSource where
    Self: DataContainable & CellContainable,
    Self.Configurator.Item == Self.Item
{
    internal func attributes(in tableView: UITableView, at indexPath: IndexPath) -> (cell: Cell, item: Item) {
        let item = self.item(at: indexPath.row)
        
        guard let cell: Cell = tableView.cellView() else {
            fatalError("cell no found")
        }
        return (cell, item)
    }
}


public extension TableViewDataSource {
    
    internal func height(_ view: UIView, in section: Int) -> CGFloat {
        view.layoutIfNeeded()
        return view.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
    }
}
