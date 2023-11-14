import UIKit

class Tiket1ViewController:
    UIViewController {
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var viewDeskripsi: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        shadow()
       
        self.navigationItem.setHidesBackButton(true, animated: true)
        tabBarController?.tabBar.isHidden = true
        
    }
    func shadow(){
        viewDeskripsi.layer.shadowColor = UIColor.black.cgColor
        viewDeskripsi.layer.shadowOpacity = 0.5
        viewDeskripsi.layer.shadowOffset = CGSize(width: 0, height: 2)
        viewDeskripsi.layer.shadowRadius = 4
        viewDeskripsi.layer.masksToBounds = false
        viewDeskripsi.roundedCorner(0,15)
    }

}
