//
//  SecondPcCollection.swift
//  animalswiki
//
//  Created by Phincon on 20/11/23.
//

import UIKit
import Lightbox
class SecondPcCollection: UICollectionViewCell {
   
    @IBOutlet weak var imageSecond: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        imageSecond.layer.cornerRadius = 30.0
        setupTapGestureRecognizer()
    }
    func setupTapGestureRecognizer() {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleImageTap(_:)))
            imageSecond.isUserInteractionEnabled = true
        imageSecond.addGestureRecognizer(tapGesture)
        }

        @objc func handleImageTap(_ sender: UITapGestureRecognizer) {
            
            // Menyiapkan sumber gambar untuk Lightbox
            let images = [LightboxImage(image: imageSecond.image!)]

            // Membuat instance LightboxController dengan sumber gambar
            let lightboxController = LightboxController(images: images)

            // Menentukan indeks gambar yang akan ditampilkan terlebih dahulu
            lightboxController.pageDelegate = self
            lightboxController.dismissalDelegate = self
            
            if let parentVC = findViewController() {
                   parentVC.present(lightboxController, animated: true, completion: nil)
               }
            

            // Menampilkan Lightbox
            
        }
    }

    // Implementasi delegate jika diperlukan
extension SecondPcCollection: LightboxControllerPageDelegate, LightboxControllerDismissalDelegate {
    func findViewController() -> UIViewController? {
            var responder: UIResponder? = self
            while let currentResponder = responder {
                if let viewController = currentResponder as? UIViewController {
                    return viewController
                }
                responder = currentResponder.next
            }
            return nil
        }
    func lightboxController(_ controller: Lightbox.LightboxController, didMoveToPage page: Int) {
      
    }
    
    func lightboxControllerWillDismiss(_ controller: Lightbox.LightboxController) {
        
    }
    

}

