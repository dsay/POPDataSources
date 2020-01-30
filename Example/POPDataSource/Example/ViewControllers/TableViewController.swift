import UIKit
import POPDataSource

class TableViewController: UITableViewController {
    
    var shim: TableViewDataSourceShim! {
        didSet {
            let emptyView = UIView()
            emptyView.backgroundColor = .red
            shim.emptyView = emptyView
            shim.tableView = tableView
            tableView.dataSource = shim
            tableView.delegate = shim
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(CustomeSection.self)
        tableView.register(cell: TableViewCell.self)
        tableView.register(cell: CustomeCell.self)

    }
}

