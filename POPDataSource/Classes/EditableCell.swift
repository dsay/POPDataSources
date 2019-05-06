import UIKit

public struct EditAction {
    let action: DataSource.Action
    let title: String
    let color: UIColor
    let image: UIImage?

    public init(action: DataSource.Action, title: String, color: UIColor, image: UIImage?) {
        self.action = action
        self.title = title
        self.color = color
        self.image = image
    }
}

public protocol EditableCellDataSource {
    func trailingActions() -> [EditAction]
    func leadingActions() -> [EditAction]
}

public extension TableViewDataSource where
    Self: EditableCellDataSource & DataContainable & CellContainable,
    Self.Configurator: CellSelectable,
    Self.Configurator.Item == Self.Item
{
    
    func canEditRow(for tableView: UITableView, at  indexPath: IndexPath) -> Bool {
        return true
    }

    func trailingSwipeActions(for tableView: UITableView, at indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        return UISwipeActionsConfiguration(actions: trailingActions().map { retrive($0, tableView, indexPath) })
    }
    
    func leadingSwipeActions(for tableView: UITableView, at indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        return UISwipeActionsConfiguration(actions: leadingActions().map { retrive($0, tableView, indexPath) })
    }
    
    private func retrive(_ editAction: EditAction, _ tableView: UITableView, _ indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .normal, title: editAction.title, handler: { action, cell, actionPerformed in
            let attributes = self.attributes(in: tableView, at: indexPath)
            if let selector = self.cellConfigurator?.selectors[editAction.action] {
                selector(attributes.cell, indexPath, attributes.item)
            }
        })
        action.image = editAction.image
        action.backgroundColor = editAction.color
        
        return action
    }
    
    private func attributes(in tableView: UITableView, at indexPath: IndexPath) -> (cell: Cell, item: Item) {
        let item = self.item(at: indexPath.row)
        
        guard let cell = tableView.cellForRow(at: indexPath) as? Cell else {
            fatalError("cell no found")
        }
        return (cell, item)
    }
}
