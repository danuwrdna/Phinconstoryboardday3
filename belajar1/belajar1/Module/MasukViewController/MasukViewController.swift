import UIKit
import RxSwift
import RxCocoa
import Firebase
import FirebaseAuth
import Lottie
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
    
    @IBOutlet weak var animasiView: CustomLoadingView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        border()
        setupAnimasi()
        shadow()
    }
    func auth (){
        guard let email = emailTextField.text, let password = passwordTextField.text else {
            return
        }
        animasiView.isHidden = false
           animasiView.startAnimating()
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            self?.animasiView.isHidden = true
                    self?.animasiView.stopAnimating()

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
    func shadow(){
        containerMasuk.layer.shadowColor = UIColor.black.cgColor
        containerMasuk.layer.shadowOpacity = 0.5
        containerMasuk.layer.shadowOffset = CGSize(width: 0, height: 2)
        containerMasuk.layer.shadowRadius = 4 
        containerMasuk.layer.masksToBounds = false
        containerMasuk.roundedCorner(0,15)
    }
    func setupAnimasi(){
        animasiView.isHidden = true
    }
}

