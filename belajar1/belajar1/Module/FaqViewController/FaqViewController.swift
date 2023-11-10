import UIKit
import RxSwift
import RxCocoa
class FaqViewController: UIViewController {
    @IBOutlet weak var viewCheck: UIView!
    @IBOutlet weak var viewLabel1: UILabel!
    @IBOutlet weak var viewLabel2: UILabel!
    @IBOutlet weak var boxButton: UIButton!
    private let disposeBag = DisposeBag()
    let login = PublishRelay<Void>()
    
    var isChecked = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tapGesture()
        updateCheckBox()
        navigate()
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
    func navigate(){
        boxButton.rx.tap
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
        self.navigationController?.pushViewController(masukViewController, animated: true)
    }
    
    func tapGesture(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(checkBoxTapped))
        viewCheck.addGestureRecognizer(tapGesture)
    }
    @objc func checkBoxTapped() {
        isChecked.toggle()
        updateCheckBox()
    }
    func updateCheckBox() {
        if isChecked {
            viewCheck.backgroundColor = UIColor.green
            viewCheck.layer.cornerRadius = 8.0
        } else {
            viewCheck.backgroundColor = UIColor.red
            viewCheck.layer.cornerRadius = 1.0
        }
        checkAndToggleButtonVisibility()
    }
    func checkAndToggleButtonVisibility() {
        boxButton.isHidden = viewCheck.backgroundColor == UIColor.red
        viewLabel1.isHidden = viewCheck.backgroundColor == UIColor.green
        viewLabel2.isHidden = viewCheck.backgroundColor == UIColor.green
    }
}
