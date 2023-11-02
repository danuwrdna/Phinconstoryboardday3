import UIKit

class MasukViewController: UIViewController {
    @IBOutlet weak var myView: UIView!
    @IBOutlet weak var textSalah: UIView!
    @IBOutlet weak var masukImage: UIImageView!
    @IBOutlet weak var containerMasuk: UIView!
    @IBOutlet weak var containerButton: UIView!
    @IBOutlet weak var containerLogin: UIView!
    @IBAction func daftarButton(_ sender: Any) {
        let serigalabutton = DaftarViewController()
        self.navigationController?.pushViewController(serigalabutton, animated: true)
    }
    @IBAction func buttonLogin(_ sender: Any) {
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
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.placeholder = "Isi Dengan Benar"
        passwordTextField.placeholder = "Isi Dengan Benar"
        passwordTextField.isSecureTextEntry = true
        textSalah.isHidden = true
        self.containerMasuk.layer.borderWidth = 1
        self.containerMasuk.layer.masksToBounds = false
        self.containerMasuk.layer.cornerRadius = containerMasuk.frame.size.height/15
        self.containerMasuk.clipsToBounds = true
        
        self.masukImage.layer.borderWidth = 1
        self.masukImage.layer.masksToBounds = false
        self.masukImage.layer.cornerRadius = masukImage.frame.size.height/2
        self.masukImage.clipsToBounds = true
        
        self.containerButton.layer.borderWidth = 1
        self.containerButton.layer.masksToBounds = false
        self.containerButton.layer.cornerRadius = containerButton.frame.size.height/5
        self.containerButton.clipsToBounds = true
        
        self.containerLogin.layer.borderWidth = 1
        self.containerLogin.layer.masksToBounds = false
        self.containerLogin.layer.cornerRadius = containerLogin.frame.size.height/5
        self.containerLogin.clipsToBounds = true
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animate()
        animate2()
    }
    func animate()   {
        UIView.animate(withDuration: 2, animations: {
            self.myView.frame = CGRect(x: 0, y: 0, width: 400, height: 400)
            self.myView.center = self.view.center
            self.myView.layer.cornerRadius = 50
            self.myView.backgroundColor = UIColor.blue
        }, completion: { done in
            if done {
                UIView.animate(withDuration: 2, animations: {
                    self.myView.frame = CGRect(x: -40, y: 0, width: 200, height: 200)
                    self.myView.center = self.view.center
                    self.myView.layer.cornerRadius = 0
                    self.myView.backgroundColor = UIColor.green
                },  completion: { done in
                    if done {
                        self.animate()
                    };
                })
            }
        })
    }
    func animate2(){
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
