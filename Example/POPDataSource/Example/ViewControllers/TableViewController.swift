import UIKit
import POPDataSource

class TableViewController: UITableViewController {
    
    var shim: TableViewDataSourceShim! {
        didSet {
            shim.tableView = tableView
            tableView.dataSource = shim
            tableView.delegate = shim
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(CustomeSection.self)
    }
}

