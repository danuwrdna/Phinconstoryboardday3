import UIKit
import RxSwift
import RxCocoa
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
        let serigalabutton = DaftarViewController()
        self.navigationController?.pushViewController(serigalabutton, animated: true)
    }
    @IBAction func buttonLogin(_ sender: Any) {
                auth()
    }
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        border()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animate()
    }
    func auth (){
        let username = emailTextField.text
        let password = passwordTextField.text
        if username == "123" && password == "123" {
            let homeViewController = MainTabBarViewController(nibName: "HomeViewController", bundle: nil)
            navigationController?.pushViewController(homeViewController, animated: true)
        } else{
            textSalah.isHidden = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                self.textSalah.isHidden = true
            }
        }
    }
    func setup() {
        navigationController?.isNavigationBarHidden = true
        textSalah.isHidden = true
        emailTextField.rx.text
                   .subscribe(onNext: { [weak self] text in
                       if let text = text, !text.isEmpty {
                           // Memastikan hanya karakter angka yang diizinkan
                           if let nonDigitRange = text.rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) {
                               // Jika karakter selain angka ditemukan, hapus karakter tersebut
                               let cleanedText = String(text[text.startIndex..<nonDigitRange.lowerBound])
                               self?.emailTextField.text = cleanedText
                           }
                       }
                   })
                   .disposed(by: disposeBag)
               passwordTextField.rx.text
                   .subscribe(onNext: { [weak self] text in
                       if let text = text, !text.isEmpty {
                           if let nonDigitRange = text.rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) {
                               let cleanedText = String(text[text.startIndex..<nonDigitRange.lowerBound])
                               self?.passwordTextField.text = cleanedText
                           }
                       }
                   })
                   .disposed(by: disposeBag)
           }
    func border(){
        self.containerMasuk.roundedCorner(1, containerMasuk.frame.size.height/8)
        passwordTextField.isSecureTextEntry = true
    }
       
    func animate() {
        UIView.animate(withDuration: 2, animations: {
            self.myView.frame = CGRect(x: 0, y: 0, width: 400, height: 400)
            self.myView.center = self.view.center
            self.myView.layer.cornerRadius = 50
            self.myView.backgroundColor = UIColor.red
        }, completion: { done in
            if done {
                UIView.animate(withDuration: 2, animations: {
                    self.myView.frame = CGRect(x: -40, y: 0, width: 200, height: 200)
                    self.myView.center = self.view.center
                    self.myView.layer.cornerRadius = 0
                    self.myView.backgroundColor = UIColor.black
                },  completion: { done in
                    if done {
                        self.animate()
                    };
                })
            }
        })
    }
}

