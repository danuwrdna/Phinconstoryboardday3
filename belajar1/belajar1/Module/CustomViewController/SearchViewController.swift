import Foundation
import UIKit

class SearchViewController: UIViewController{
    @IBOutlet weak var popView: UITextField!
    override func viewDidLoad() {
        setup()
        closepop()
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
