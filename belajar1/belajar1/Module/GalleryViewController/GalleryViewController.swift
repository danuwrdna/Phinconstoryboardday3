import UIKit

class GalleryViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        self.imageView.roundedCorner(1,imageView.frame.height/2 )
        tapgesture()
    }
    
    func tapgesture()  {
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

extension GalleryViewController: UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.originalImage] as? UIImage
        dismiss(animated: true,completion: nil)
    }
}

