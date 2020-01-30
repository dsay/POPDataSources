import POPDataSource
//import ReactiveCocoa
//import ReactiveSwift

class TextFieldDataSource:
    TableViewDataSource,
    DataContainable,
    CellContainable,
    CellConfigurator,
    CellSelectable
{
    struct Actions {
        static let changed = "changed"
        static let begin = "begin"
        static let end = "end"
        static let exit = "exit"
    }
    
  //  private weak var cell: TextFieldTableViewCell?
    
    var data: [String] {
        return [""]
    }
    
    var selectors: [DataSource
        .Action: (TextFieldTableViewCell, IndexPath, String) -> ()] = [:]
    
    func configurateCell(_ cell: TextFieldTableViewCell, for tableView: UITableView, at indexPath: IndexPath, item: String) {
        
        cell.textField?.text = item
        cell.textField?.autocorrectionType = .no
        cell.textField?.autocapitalizationType = .words
        cell.textField?.isSecureTextEntry = false
        cell.textField?.returnKeyType = .next
        cell.textField?.keyboardType = .default
        cell.show?.isHidden = true
        
//        _ = cell.textField?.reactive.controlEvents(.editingChanged).observeValues
//            { [unowned cell, weak self] (_) in
//                cell.editing()
//                self?.invoke(.custom(Actions.changed))? (cell, indexPath, item)
//        }
//
//        _ = cell.textField?.reactive.controlEvents(.editingDidBegin).observeValues
//            { [unowned cell, weak self] (_) in
//                cell.editing()
//                self?.invoke(.custom(Actions.begin))? (cell, indexPath, item)
//        }
//
//        _ = cell.textField?.reactive.controlEvents(.editingDidEnd).observeValues
//            { [unowned cell, weak self] (_) in
//                cell.normal()
//                self?.invoke(.custom(Actions.end))? (cell, indexPath, item)
//        }
//
//        _ = cell.textField?.reactive.controlEvents(.editingDidEndOnExit).observeValues
//            { [unowned cell, weak self] (_) in
//                self?.invoke(.custom(Actions.end))? (cell, indexPath, item)
//                self?.invoke(.custom(Actions.exit))? (cell, indexPath, item)
//        }
    }
}

class NameDataSource: TextFieldDataSource {
    override func configurateCell(_ cell: TextFieldTableViewCell, for tableView: UITableView, at indexPath: IndexPath, item: String) {
        super.configurateCell(cell, for: tableView, at: indexPath, item: item)
        cell.textField?.placeholder = "Name"
    }
}

class SurnameDataSource: TextFieldDataSource {
    override func configurateCell(_ cell: TextFieldTableViewCell, for tableView: UITableView, at indexPath: IndexPath, item: String) {
        super.configurateCell(cell, for: tableView, at: indexPath, item: item)
        cell.textField?.placeholder = "Surname"
    }
}

class EmailDataSource: TextFieldDataSource {
    override func configurateCell(_ cell: TextFieldTableViewCell, for tableView: UITableView, at indexPath: IndexPath, item: String) {
        super.configurateCell(cell, for: tableView, at: indexPath, item: item)
        cell.textField?.placeholder = "Email"
        cell.textField?.keyboardType = .emailAddress
        cell.textField?.autocapitalizationType = .none
    }
}

class PasswordDataSource: TextFieldDataSource {
    override func configurateCell(_ cell: TextFieldTableViewCell, for tableView: UITableView, at indexPath: IndexPath, item: String) {
        super.configurateCell(cell, for: tableView, at: indexPath, item: item)
        cell.textField?.placeholder = "Password"
        cell.textField?.autocapitalizationType = .none
        cell.textField?.returnKeyType = .done
        cell.textField?.isSecureTextEntry = true
        cell.show?.isHidden = false
    }
}
