import UIKit

import POPDataSource

class TextFieldViewController: UITableViewController {

    private var name = NameDataSource()
    private var surname = SurnameDataSource()
    private var email = EmailDataSource()
    private var password = PasswordDataSource()
    
    private var shim: TableViewDataSourceShim? = nil {
        didSet {
            tableView.dataSource = shim
            tableView.delegate = shim
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(cell: TextFieldTableViewCell.self)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 140
        
        setupDataSource()
    }
    
    private func setupDataSource() {
        name.on(.custom(TextFieldDataSource.Actions.end)) { cell, _, _ in
            print("Name end editing: " + (cell.textField?.text ?? ""))
        }
        
        surname.on(.custom(TextFieldDataSource.Actions.end)) { cell, _, _ in
            print("Surname end editing: " + (cell.textField?.text ?? ""))
        }
        
        email.on(.custom(TextFieldDataSource.Actions.end)) { cell, _, _ in
            print("Email end editing: " + (cell.textField?.text ?? ""))
        }
    
        password.on(.custom(TextFieldDataSource.Actions.end)) { cell, _, _ in
            print("Password end editing: " + (cell.textField?.text ?? ""))
        }
        
        let compossed = ComposedDataSource([name, surname, email, password])
        shim = TableViewDataSourceShim(compossed)
    }
}



