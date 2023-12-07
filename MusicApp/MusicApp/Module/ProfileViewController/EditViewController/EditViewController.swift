
import UIKit

class EditViewController: UIViewController {
    
    @IBOutlet weak var profileImg: UIImageView!
    @IBAction func pickersImg(_ sender: Any) {
        pickersIM()
    }
    @IBOutlet weak var editView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        borderView()
    }
}
extension EditViewController{
    func borderView(){
        editView.layer.cornerRadius = 16
        editView.layer.masksToBounds = false
        editView.layer.shadowColor = UIColor.black.cgColor
        editView.layer.shadowOpacity = 0.5
        editView.layer.shadowOffset = CGSize(width: 0, height: 2)
        editView.layer.shadowRadius = 4.0
        editView.layer.shouldRasterize = true
        editView.layer.rasterizationScale = UIScreen.main.scale
    }
}
extension EditViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate{
    func pickersIM(){
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
        let alertController = UIAlertController(title: "Choose Image Source", message: nil, preferredStyle: .actionSheet)
        
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { [unowned self] _ in
            self.openCamera(imagePicker)
        }
        
        let galleryAction = UIAlertAction(title: "Gallery", style: .default) { [unowned self] _ in
            self.openGallery(imagePicker)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(cameraAction)
        alertController.addAction(galleryAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    func openCamera(_ imagePicker: UIImagePickerController) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.sourceType = .camera
            present(imagePicker, animated: true, completion: nil)
        } else {
            showAlert(message: "Camera is not available.")
        }
    }
    
    func openGallery(_ imagePicker: UIImagePickerController) {
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: - UIImagePickerControllerDelegate
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            // Handle the picked image
            // You can set the image to an UIImageView, save it, or use it as needed
            profileImg.image = pickedImage
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
