import UIKit
import RxSwift
import RxCocoa
import Firebase
import FirebaseAuth
class MasukViewController: UIViewController {
    @IBOutlet weak var myView: UIView!
    @IBOutlet weak var textSalah: UIView!
    @IBOutlet weak var masukImage: UIImageView!
    @IBOutlet weak var containerMasuk: UIView!
    @IBOutlet weak var containerButton: UIView!
    @IBOutlet weak var containerLogin: UIView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBAction func daftarButton(_ sender: Any) {
        let bt = DaftarViewController()
        self.navigationController?.pushViewController(bt, animated: true)
    }
    @IBAction func buttonLogin(_ sender: Any) {
                auth()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        border()
    }
    func auth (){
        guard let email = emailTextField.text, let password = passwordTextField.text else {
            return
        }
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            if error != nil {
                self?.textSalah.isHidden = false
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    self?.textSalah.isHidden = true
                }
                
            } else{
                let serigalabutton = MainTabBarViewController()
                self?.navigationController?.pushViewController(serigalabutton, animated: true)
            }
        }
    }
    func setup() {
        navigationController?.isNavigationBarHidden = true
        textSalah.isHidden = true
           }
    func border(){
        self.containerMasuk.roundedCorner(1, containerMasuk.frame.size.height/8)
        passwordTextField.isSecureTextEntry = true
    }
}

