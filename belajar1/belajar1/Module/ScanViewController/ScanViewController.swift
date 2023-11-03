import UIKit

class ScanViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBAction func takeButton(_ sender: Any) {
        let take = UIImagePickerController()
        take.sourceType = .camera
        take.delegate = self
        present(take, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
extension ScanViewController:UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true,completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as?
                UIImage else{
            return
        }
        imageView.image = image
    }
}

