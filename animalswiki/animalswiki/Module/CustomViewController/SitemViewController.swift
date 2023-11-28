import UIKit

class SitemViewController: UIViewController {
    weak var searchDelegate: SearchDelegate?
    @IBOutlet weak var popView: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        closepop()
        popView.delegate = self
    }
    func setup(){
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
    }
    func closepop(){
        let tapOutsidePopup = UITapGestureRecognizer(target: self, action: #selector(tapOutsidePopup(_:)))
        tapOutsidePopup.cancelsTouchesInView = false
        view.addGestureRecognizer(tapOutsidePopup)
    }
    @objc func tapOutsidePopup(_ sender: UITapGestureRecognizer) {
        let location = sender.location(in: view)
        if !popView.frame.contains(location) {
            dismiss(animated: true, completion: nil)
        }
    }
}
extension SitemViewController: UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            // Panggil metode pencarian dari delegate
            let currentText = (textField.text ?? "") as NSString
            let newText = currentText.replacingCharacters(in: range, with: string)
            searchDelegate?.search(query: newText)
            return true
        }
}
