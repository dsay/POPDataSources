import UIKit

public struct EditAction {
    let action: Action
    let title: String
    let color: UIColor
    let image: UIImage?

    public init(action: Action, title: String, color: UIColor, image: UIImage?) {
        self.action = action
        self.title = title
        self.color = color
        self.image = image
    }
}

public protocol EditableCellDataSource {

    var trailingActionFullSwipe: Bool { get }
    var trailingActions: [EditAction] { get }
    
    var leadingActionFullSwipe: Bool { get }
    var leadingActions: [EditAction] { get }
}

public extension EditableCellDataSource {
    
    var trailingActionFullSwipe: Bool { true }
    var trailingActions: [EditAction] { [] }

    var leadingActionFullSwipe: Bool { true }
    var leadingActions: [EditAction] { [] }
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
        let configuration = UISwipeActionsConfiguration(actions: trailingActions.map { retrive($0, tableView, indexPath) }
        )
        configuration.performsFirstActionWithFullSwipe = trailingActionFullSwipe
        return configuration
    }

    func leadingSwipeActions(for tableView: UITableView, at indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let configuration =  UISwipeActionsConfiguration(actions: leadingActions.map { retrive($0, tableView, indexPath) })
        configuration.performsFirstActionWithFullSwipe = leadingActionFullSwipe
        return configuration
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
}
