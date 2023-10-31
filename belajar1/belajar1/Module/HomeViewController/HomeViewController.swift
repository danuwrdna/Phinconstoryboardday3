import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var image3: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var image1: UIImageView!
    
    @IBAction func serigalabutton(_ sender: Any) {
        let serigalabutton = SerigalaViewController()
        self.navigationController?.pushViewController(serigalabutton, animated: true)
    }
    @IBAction func macanbutton(_ sender: Any) {
        let macanbutton = MacanViewController()
        self.navigationController?.pushViewController(macanbutton, animated: true)
    }
    @IBAction func singabutton(_ sender: Any) {
        let singabutton = SingaViewController()
        self.navigationController?.pushViewController(singabutton, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
}
    
    




