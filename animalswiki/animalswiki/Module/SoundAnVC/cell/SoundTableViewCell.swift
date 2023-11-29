
import UIKit

class SoundTableViewCell: UITableViewCell {
    @IBOutlet weak var imageSound: UIImageView!
    @IBOutlet weak var playButton: UIButton!
    
    @IBOutlet weak var downloadButton: UIButton!
    @IBOutlet weak var labelSoundVC: UILabel!
//    var sound: String?
    override func awakeFromNib() {
        super.awakeFromNib()
      
    }
    
}
