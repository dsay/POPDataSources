import POPDataSource

class TextFieldTableViewCell: UITableViewCell, ReuseIdentifier {

    @IBOutlet weak var textField: UITextField?
    @IBOutlet weak private var divider: UIImageView?
    @IBOutlet weak private var subTitle: UILabel?
    @IBOutlet weak private var icon: UIImageView?
    @IBOutlet weak var show: UIButton?

    override func awakeFromNib() {
        super.awakeFromNib()
        self.normal()
    }
    
    func normal() {
        self.subTitle?.text = ""
        self.icon?.isHidden = true
        self.divider?.backgroundColor = .lightGray
    }
    
    func editing() {
        self.subTitle?.text = ""
        self.icon?.isHidden = true
        self.divider?.backgroundColor = .blue
    }
    
    func error(_ error: String) {
        self.subTitle?.text = error
        self.subTitle?.textColor = .red
        self.icon?.isHidden = false
        self.divider?.backgroundColor = .red
    }
    
    @IBAction private func show(_ sender: UIButton) {
        if let textField = textField {
            textField.isSecureTextEntry = !(textField.isSecureTextEntry)
        }
    }
}
