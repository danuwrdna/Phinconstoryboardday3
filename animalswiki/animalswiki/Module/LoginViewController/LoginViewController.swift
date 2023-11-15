import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var fieldView: UITextField!
    @IBAction func loginButton(_ sender: Any) {
        let bt = HomeViewController()
        self.navigationController?.pushViewController(bt, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupField()
    }
    func setupField(){
        
    }
}
