import UIKit
import Lottie
import FirebaseAuth
import Firebase

class LoginViewController: UIViewController {
    let musicAnimationView = LottieAnimationView(name: "musicAnimate")
    let loadLogin = LottieAnimationView(name: "loginLoad")
    var resetEmailTextField: UITextField?
    @IBOutlet weak var emailLogin: UITextField!
    @IBOutlet weak var passwordLogin: UITextField!
    @IBOutlet weak var eyeButton: UIButton!
    
    @IBOutlet weak var googleImg: UIImageView!
    @IBAction func forgetBT(_ sender: Any) {
        showForgetPasswordBottomSheet()
    }
    @IBAction func signNB(_ sender: Any) {
        NG()
    }
    @IBAction func loginBT(_ sender: Any) {
        setupLogin()
    }
    var isPasswordVisible = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        animate()
        setupEyeButton()
        setupLogin()
    }
}
extension LoginViewController{
    func setup() {
        navigationController?.isNavigationBarHidden = true
        navigationItem.hidesBackButton = true
    }
    func animate() {
        musicAnimationView.frame = CGRect(x: 0, y: 0, width: 352, height: 330)
        musicAnimationView.center = CGPoint(x: view.frame.width / 2, y: view.frame.height / 4)
        musicAnimationView.contentMode = .scaleAspectFit
        musicAnimationView.loopMode = .loop
        view.addSubview(musicAnimationView)
        musicAnimationView.play()
    }
    
}
extension LoginViewController{
    func setupEyeButton() {
        let eyeImage = UIImage(systemName: "eye.fill")
        let eyeSlashImage = UIImage(systemName: "eye.slash.fill")
        eyeButton?.setImage(eyeImage, for: .normal)
        eyeButton?.tintColor = .darkGray
        eyeButton?.addTarget(self, action: #selector(eyeButtonTapped), for: .touchUpInside)
    }
    
    @objc func eyeButtonTapped() {
        isPasswordVisible.toggle()
        
        let eyeImage = isPasswordVisible ? UIImage(systemName: "eye.fill") : UIImage(systemName: "eye.slash.fill")
        eyeButton.setImage(eyeImage, for: .normal)
        
        passwordLogin.isSecureTextEntry = !isPasswordVisible
    }
    
    func setupLogin() {
        guard let email = emailLogin.text, let password = passwordLogin.text else {
            return
        }
        loadLogin.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        loadLogin.center = view.center
        loadLogin.contentMode = .scaleAspectFit
        view.addSubview(loadLogin)
        self.loadLogin.isHidden = false
        loadLogin.play()
        
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            self?.loadLogin.stop()
            self?.loadLogin.isHidden = true
            if error != nil {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                }
            } else {
                
                let bt = MainTabBarViewController()
                self?.navigationController?.pushViewController(bt, animated: true)
            }
            
        }
    }
    func NG(){
        let bt = SignUPViewController()
        self.navigationController?.pushViewController(bt, animated: true)
    }
    
}
extension LoginViewController{
    func showForgetPasswordBottomSheet() {
        let bottomSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let resetPasswordAction = UIAlertAction(title: "Reset Password", style: .default) { [weak self] _ in
            self?.resetPassword()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        bottomSheet.addAction(resetPasswordAction)
        bottomSheet.addAction(cancelAction)
        present(bottomSheet, animated: true, completion: nil)
    }
    func resetPassword() {
        let alertController = UIAlertController(title: "Reset Password", message: "Enter your email address to reset your password", preferredStyle: .alert)
        
        alertController.addTextField { textField in
            textField.placeholder = "Email"
            self.resetEmailTextField = textField
        }
        
        let resetAction = UIAlertAction(title: "Reset", style: .default) { _ in
            self.handleResetPassword()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(resetAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    func handleResetPassword() {
        guard let email = resetEmailTextField?.text, !email.isEmpty else {
            return
        }
        
        Auth.auth().sendPasswordReset(withEmail: email) { [weak self] error in
            if let error = error {
                print("Error resetting password: \(error.localizedDescription)")
                let errorAlert = UIAlertController(title: "Error", message: "Failed to reset password: \(error.localizedDescription)", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                errorAlert.addAction(okAction)
                self?.present(errorAlert, animated: true, completion: nil)
            } else {
                let successAlert = UIAlertController(title: "Success", message: "Password reset email sent successfully. Check your email for instructions.", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                successAlert.addAction(okAction)
                self?.present(successAlert, animated: true, completion: nil)
            }
        }
    }
    
}
