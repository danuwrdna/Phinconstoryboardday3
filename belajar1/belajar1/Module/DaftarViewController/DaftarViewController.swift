import UIKit
import RxSwift
import RxCocoa

class DaftarViewController: UIViewController {
    @IBOutlet weak var containerDaftar: UIView!
    @IBOutlet weak var buttonLogin: UIButton!
    @IBOutlet weak var emailDaftar: UITextField!
    @IBOutlet weak var passwordDaftar: UITextField!
    @IBOutlet weak var erorText: UILabel!
    
    private let disposeBag = DisposeBag()
    let login = PublishRelay<Void>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupValidation()
        tombolLogin()
        radius()
    }
    func radius(){
        self.containerDaftar.roundedCorner(1, containerDaftar.frame.size.height/8)
               
    }
    func tombolLogin(){
        buttonLogin.rx.tap
            .bind(to: login)
            .disposed(by: disposeBag)
        login
            .subscribe(onNext: { [weak self] in
                self?.navigasiLogin()
            })
            .disposed(by: disposeBag)
    }
    func navigasiLogin() {
        let masukViewController =  MasukViewController()
        self.navigationController?.pushViewController(masukViewController, animated: false)
    }
    
    func setupValidation() {
        // Buat Observable untuk email text field
        let emailObservable = emailDaftar.rx.text.orEmpty.asObservable()
        let passwordObservable = emailDaftar.rx.text.orEmpty.asObservable()
        // Validasi email menggunakan predicate
        let isValidEmail = emailObservable
            .map { email in
                return email.contains("@")
            }
            .distinctUntilChanged()
            .share()
        // Bind label eror dan password field
        isValidEmail
            .map { isValid in
                return isValid
            }
            .bind(to: erorText.rx.isHidden, passwordDaftar.rx.isUserInteractionEnabled)
            .disposed(by: disposeBag)
    }
}
