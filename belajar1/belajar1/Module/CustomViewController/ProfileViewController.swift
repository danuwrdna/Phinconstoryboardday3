import Foundation
import UIKit

class ProfileViewController: UIViewController {
    @IBOutlet weak var popView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
       setup()
        setting()
        closepop()
    }
    func setup(){
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        popView.roundedCorner(0,20)
    }
    func setting(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapGanti))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tap)
    }
    @objc func tapGanti(){
        let imagePickers = UIImagePickerController()
        imagePickers.sourceType = .photoLibrary
        imagePickers.delegate = self
        self.present(imagePickers, animated: true,completion: nil)
    }
}
extension ProfileViewController: UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.originalImage] as? UIImage
        dismiss(animated: true,completion: nil)
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
