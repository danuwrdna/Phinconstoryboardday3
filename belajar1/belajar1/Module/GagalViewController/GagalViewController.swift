import UIKit

class GagalViewController: UIViewController {

    @IBAction func masukButton(_ sender: Any) {
        let masukbutton = MasukViewController()
        self.navigationController?.pushViewController(masukbutton, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
