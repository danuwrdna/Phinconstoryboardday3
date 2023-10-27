

import UIKit

class HalamanBaruController: UIViewController {
    
    @IBOutlet weak var TextView1: UITextView!
    
    @IBOutlet weak var imagehalamanbaru: UIImageView!
    @IBOutlet weak var Container1: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagehalamanbaru.layer.cornerRadius = imagehalamanbaru.frame.size.width / 10
        imagehalamanbaru.clipsToBounds = true
        
        if let imageUrl = URL(string: "https://t1.gstatic.com/licensed-image?q=tbn:ANd9GcRJpevBOQMgZ-Gaeb54y2Tin-o5vsoOtYW2nYtCpzkYqtj6ENWsHD4d1Bv-AUymOggA") {
            // Buat URLSession
            let session = URLSession.shared
            
            // Buat URL Task untuk mengunduh gambar
            let task = session.dataTask(with: imageUrl) { (data, response, error) in
                if error == nil, let imageData = data {
                    // Perbarui UI di dalam blok utas utama
                    DispatchQueue.main.async {
                        if let image = UIImage(data: imageData) {
                            self.imagehalamanbaru.image = image
                        }
                    }
                }
            }
            
            // Mulai unduhan
            task.resume()
        }
        
        let welcomeMessage = NSLocalizedString("Singa adalah salah satu spesies karnivora besar yang terkenal karena kekuatan fisiknya, serta memiliki ciri khas berupa janggut dan bulu tebal di sekitar leher pada jantan. Singa (Panthera leo) adalah hewan mamalia yang termasuk dalam keluarga Felidae (keluarga kucing besar). Mereka merupakan hewan yang mendiami sebagian besar wilayah Afrika subsahara dan beberapa bagian dari India.", comment: "okeoke")
        TextView1.text = welcomeMessage
        
        Container1.layer.cornerRadius = Container1.frame.size.width / 15
        Container1.clipsToBounds = true
        
        
    }
    
    
    
}



