
import UIKit

class PokemonTableViewCell: UITableViewCell {
    
    @IBOutlet weak var textView: UILabel!
    @IBOutlet weak var viewImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
