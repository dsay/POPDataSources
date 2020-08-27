import POPDataSource

class SegmentTableViewController: UITableViewController {
    
    @IBOutlet weak var segment: UISegmentedControl?
    
    var segmentShim: SegmentDataSourceShim! {
        didSet {
            segmentShim.tableView = tableView
            tableView.dataSource = segmentShim
            tableView.delegate = segmentShim
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(CustomeSection.self)
        tableView.register(cell: TableViewCell.self)

        let artists = ComposedDataSource(LedZeppelin.artists)
        let genres = GenresDataSource()
        segmentShim = SegmentDataSourceShim([artists, genres])
       
        segment?.addTarget(self, action: #selector(SegmentTableViewController.select(segment:)), for: .valueChanged)
    }
    
    @objc func select(segment: UISegmentedControl) {
        segmentShim.selectIndex = segment.selectedSegmentIndex
    }
}
class CellectionSegmentTableViewController: UICollectionViewController {
}
