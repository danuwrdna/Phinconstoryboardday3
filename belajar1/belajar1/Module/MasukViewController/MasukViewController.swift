import UIKit

class MasukViewController: UIViewController {
    @IBOutlet weak var masukImage: UIImageView!
    @IBOutlet weak var containerMasuk: UIView!
    @IBOutlet weak var containerButton: UIView!
    @IBOutlet weak var containerLogin: UIView!
    @IBAction func buttonLogin(_ sender: Any) {
        let loginbutton = MainTabBarViewController()
        self.navigationController?.pushViewController(loginbutton, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.containerMasuk.layer.borderWidth = 1
        self.containerMasuk.layer.masksToBounds = false
        self.containerMasuk.layer.cornerRadius = containerMasuk.frame.size.height/15
        self.containerMasuk.clipsToBounds = true
        
        self.masukImage.layer.borderWidth = 1
        self.masukImage.layer.masksToBounds = false
        self.masukImage.layer.cornerRadius = masukImage.frame.size.height/2
        self.masukImage.clipsToBounds = true
        
        self.containerButton.layer.borderWidth = 1
        self.containerButton.layer.masksToBounds = false
        self.containerButton.layer.cornerRadius = containerButton.frame.size.height/5
        self.containerButton.clipsToBounds = true
        
        self.containerLogin.layer.borderWidth = 1
        self.containerLogin.layer.masksToBounds = false
        self.containerLogin.layer.cornerRadius = containerLogin.frame.size.height/5
        self.containerLogin.clipsToBounds = true
        
        
    }
}
