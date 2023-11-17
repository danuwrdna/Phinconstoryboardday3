import UIKit
import Firebase
import FirebaseAuth
import RxSwift
import RxCocoa
class SignViewController: UIViewController {
    @IBOutlet weak var emailSign: UITextField!
    @IBOutlet weak var passwordSign: UITextField!
    @IBOutlet weak var erorText: UILabel!
    @IBOutlet weak var signButton: UIButton!
    private let disposeBag = DisposeBag()
    let login = PublishRelay<Void>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        validasi()
        setupSign()
    }
    func validasi() {
        let emailObservable = emailSign.rx.text.orEmpty.asObservable()
        let passwordObservable = emailSign.rx.text.orEmpty.asObservable()
        let isValidEmail = emailObservable
            .map { email in
                return email.contains("@")
            }
            .distinctUntilChanged()
            .share()
        isValidEmail
            .map { isValid in
                return isValid
            }
            .bind(to: erorText.rx.isHidden, passwordSign.rx.isUserInteractionEnabled)
            .disposed(by: disposeBag)
    }
    func setupSign(){
        navigationItem.hidesBackButton = true
        signButton.rx.tap
            .bind(to: login)
            .disposed(by: disposeBag)
        login
            .subscribe(onNext: { [weak self] in
                self?.signUp()
            })
            .disposed(by: disposeBag)
    }
    func signUp(){
        guard let email = emailSign.text, let password = passwordSign.text else {
            return
        }
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] authResult, error in
            if let error = error {
                print("Error pendaftaran: \(error.localizedDescription)")
                let alertController = UIAlertController(title: "Error", message: "Pendaftaran gagal: \(error.localizedDescription)", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alertController.addAction(okAction)
                self?.present(alertController, animated: true, completion: nil)
            } else {
                print("Pendaftaran berhasil")
                let alertController = UIAlertController(title: "Sukses", message: "Pendaftaran berhasil", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: { _ in
                    navigasiLogin()
                })
                alertController.addAction(okAction)
                self?.present(alertController, animated: true, completion: nil)
            }
        }
        func navigasiLogin() {
            let bt =  LoginViewController()
            self.navigationController?.pushViewController(bt, animated: false)
        }
    }
}
