
import UIKit
import FirebaseStorage
import FirebaseDatabase
import FirebaseAuth
class EditViewController: UIViewController {
    
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var textFieldPassword: UITextField!
    @IBOutlet weak var textFieldemail: UITextField!
    @IBAction func btEditProfile(_ sender: Any) {
        setupBtEditProfile()
    }
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
            profileImg.image = pickedImage
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
extension EditViewController{
    func setupBtEditProfile(){
        let storageRef = Storage.storage().reference()
        let imageName = NSUUID().uuidString
        let imageRef = storageRef.child("profile_images").child("\(imageName).jpg")
        
        if let image = profileImg.image, let imageData = image.jpegData(compressionQuality: 0.1) {
            imageRef.putData(imageData, metadata: nil) { (metadata, error) in
                guard let metadata = metadata else {
                    print("Error uploading image: \(error?.localizedDescription ?? "Unknown error")")
                    return
                }
                imageRef.downloadURL { (url, error) in
                    guard let downloadURL = url else {
                        
                        print("Error getting download URL: \(error?.localizedDescription ?? "Unknown error")")
                        return
                    }
                    self.uploadDataToDatabase(imageURL: downloadURL.absoluteString)
                }
            }
        }
    }
    func uploadDataToDatabase(imageURL: String) {
        let databaseRef = Database.database().reference()
        guard let userID = Auth.auth().currentUser?.uid else {
            print("User not logged in.")
            return
        }
        let userRef = databaseRef.child("users").child(userID)
        userRef.child("profileImageUrl").setValue(imageURL) { (error, _) in
            if let error = error {
                print("Error uploading data to database: \(error.localizedDescription)")
                self.showAlert(message: "Try Again")
            } else {
                print("Data uploaded to database successfully.")
                self.showAlert(message: "Ok", withCompletion: {
                    if let profileVC = self.storyboard?.instantiateViewController(withIdentifier: "ProfileViewController") {
                        self.navigationController?.pushViewController(profileVC, animated: true)
                    }
                })
            }
        }
    }

    func showAlert(message: String, withCompletion completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            completion?()
        }))
        present(alert, animated: true, completion: nil)
    }
}
extension EditViewController{
    func setupTextFieldEmail(){
        
    }
    func setupTextFieldPassword(){
        
    }
}
