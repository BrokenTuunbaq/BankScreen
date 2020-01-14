import UIKit

class BankCell: UITableViewCell {

    @IBOutlet weak var bankName: UILabel!
    @IBOutlet weak var bankImage: UIImageView!
    @IBOutlet weak var bankSymbol: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
