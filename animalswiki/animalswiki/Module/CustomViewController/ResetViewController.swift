
import UIKit
import FirebaseAuth
class ResetViewController: UIViewController {
    @IBOutlet weak var resetView: UIView!
    @IBOutlet weak var userEmailTextField: UITextField!
    @IBAction func resetButton(_ sender: Any) {
        resetAcc()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        closepop()
    }
    func setup(){
        resetView.layer.cornerRadius = 10.0
        resetView.layer.borderWidth = 1.0
        resetView.layer.borderColor = UIColor.black.cgColor
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
    }
    func closepop(){
        let tapOutsidePopup = UITapGestureRecognizer(target: self, action: #selector(tapOutsidePopup(_:)))
        tapOutsidePopup.cancelsTouchesInView = false
        view.addGestureRecognizer(tapOutsidePopup)
    }
    @objc func tapOutsidePopup(_ sender: UITapGestureRecognizer) {
        let location = sender.location(in: view)
        if !resetView.frame.contains(location) {
            dismiss(animated: true, completion: nil)
        }
    }
    func resetAcc() {
            guard let userEmail = userEmailTextField.text else {
                showAlert(message: "Email tidak valid")
                return
            }
            Auth.auth().sendPasswordReset(withEmail: userEmail) { [weak self] error in
                if let error = error {
                    self?.showAlert(message: "Error: \(error.localizedDescription)")
                } else {
                    self?.showAlert(message: "Tautan reset password telah dikirim ke email Anda.")
                }
            }
        }

        func showAlert(message: String) {
            let alert = UIAlertController(title: "Info", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }

}
