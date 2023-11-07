import UIKit

class SplashViewController: UIViewController {

    @IBAction func login(_ sender: Any) {
        let masuk = MasukViewController()
        self.navigationController?.pushViewController(masuk, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
