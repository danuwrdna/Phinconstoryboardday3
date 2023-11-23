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
    @IBOutlet weak var resetLabel: UILabel!
    @IBOutlet weak var eyeButton: UIButton!
    var isPasswordVisible = false
    override func viewDidLoad() {
        super.viewDidLoad()
        setupField()
        setup()
        resetPassword()
        setupEyeButton()
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
                let bt = HomeViewController()
                self?.navigationController?.pushViewController(bt, animated: true)
            }
        }
    }
    func resetPassword(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(resetLabelTapped))
                resetLabel.isUserInteractionEnabled = true
                resetLabel.addGestureRecognizer(tapGesture)
    }
    @objc func resetLabelTapped() {
        let resetViewController = ResetViewController()
        resetViewController.modalTransitionStyle = .crossDissolve
        resetViewController.modalPresentationStyle = .overFullScreen
           navigationController?.present(resetViewController, animated: true)
    }
    func setupEyeButton() {
            let eyeImage = UIImage(systemName: "eye.fill")
            let eyeSlashImage = UIImage(systemName: "eye.slash.fill")

            eyeButton.setImage(eyeImage, for: .normal)
        eyeButton.tintColor = .darkGray
            eyeButton.addTarget(self, action: #selector(eyeButtonTapped), for: .touchUpInside)

//        passwordLogin.rightView = eyeButton
//        passwordLogin.rightViewMode = .always
        }

        @objc func eyeButtonTapped() {
            isPasswordVisible.toggle()

            let eyeImage = isPasswordVisible ? UIImage(systemName: "eye.fill") : UIImage(systemName: "eye.slash.fill")
            eyeButton.setImage(eyeImage, for: .normal)

            passwordLogin.isSecureTextEntry = !isPasswordVisible
        }
}
