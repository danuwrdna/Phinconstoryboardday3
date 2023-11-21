import UIKit
import Lottie
import Firebase
import FirebaseAuth
class LoginViewController: UIViewController {
    @IBOutlet weak var fieldView: UITextField!
    @IBAction func loginButton(_ sender: Any) {
        setupField()
    }
    @IBAction func signButton(_ sender: Any) {
        let bt = SignViewController()
        self.navigationController?.pushViewController(bt, animated: true)
    }
    @IBOutlet weak var emailLogin: UITextField!
    @IBOutlet weak var animateView: AnimasiViewController!
    @IBOutlet weak var passwordLogin: UITextField!
    @IBOutlet weak var wrongText: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupField()
        setup()
    }
    func setup() {
            navigationController?.isNavigationBarHidden = true
            navigationItem.hidesBackButton = true
            wrongText.isHidden = true
            animateView.isHidden = true
        }
    func setupField(){
        guard let email = emailLogin.text, let password = passwordLogin.text else {
            return
        }
        animateView.isHidden = false
        animateView.startAnimating()
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            self?.animateView.isHidden = true
            self?.animateView.stopAnimating()

            if error != nil {
                self?.wrongText.isHidden = false
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    self?.wrongText.isHidden = true
                    
                }
                
            } else{
                let bt = MainTabBarViewController()
                self?.navigationController?.pushViewController(bt, animated: true)
            }
        }
    }
    
}
