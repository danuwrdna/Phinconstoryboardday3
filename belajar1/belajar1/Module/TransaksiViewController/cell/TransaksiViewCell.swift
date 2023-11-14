
import UIKit

class TransaksiViewCell: UITableViewCell {
    @IBOutlet weak var judulLabel: UILabel!
    @IBOutlet weak var subLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
