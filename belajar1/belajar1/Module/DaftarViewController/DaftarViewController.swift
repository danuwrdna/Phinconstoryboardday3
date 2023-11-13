import UIKit
import RxSwift
import RxCocoa
import FirebaseAuth
import Firebase
class DaftarViewController: UIViewController {
    @IBOutlet weak var containerDaftar: UIView!
    @IBOutlet weak var buttonLogin: UIButton!
    @IBOutlet weak var emailDaftar: UITextField!
    @IBOutlet weak var passwordDaftar: UITextField!
    @IBOutlet weak var erorText: UILabel!
    @IBAction func konfirmButton(_ sender: Any) {
        tombolLogin()
    }
    private let disposeBag = DisposeBag()
    let login = PublishRelay<Void>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tombolLogin()
        radius()
        validasi()
    }
    func radius(){
        self.containerDaftar.roundedCorner(1, containerDaftar.frame.size.height/8)
    }
    func validasi() {
        let emailObservable = emailDaftar.rx.text.orEmpty.asObservable()
        let passwordObservable = emailDaftar.rx.text.orEmpty.asObservable()
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
            .bind(to: erorText.rx.isHidden, passwordDaftar.rx.isUserInteractionEnabled)
            .disposed(by: disposeBag)
    }
    func tombolLogin(){
        buttonLogin.rx.tap
            .bind(to: login)
            .disposed(by: disposeBag)
        login
            .subscribe(onNext: { [weak self] in
                self?.daftarAkun()
            })
            .disposed(by: disposeBag)
    }
    func daftarAkun(){
        guard let email = emailDaftar.text, let password = passwordDaftar.text else {
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
            let masukViewController =  MasukViewController()
            self.navigationController?.pushViewController(masukViewController, animated: false)
        }
    }
}
