//
//  ViewController.swift
//  tutorial
//
//  Created by Phincon on 25/10/23.
//

import UIKit


class ViewController: UIViewController {
    
    @IBOutlet weak var headline: UILabel!
    
    @IBOutlet weak var foto: UIImageView!
    
    
    @IBOutlet weak var Container: UIView!
    @IBOutlet weak var telepon: UILabel!
    @IBOutlet weak var Hobi: UILabel!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var nama: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        foto.layer.cornerRadius = foto.frame.size.width / 2
        foto.clipsToBounds = true
        if let imageUrl = URL(string: "https://img.freepik.com/free-vector/group-people-illustration-set_52683-33806.jpg") {
            // Buat URLSession
            let session = URLSession.shared
            
            // Buat URL Task untuk mengunduh gambar
            let task = session.dataTask(with: imageUrl) { (data, response, error) in
                if error == nil, let imageData = data {
                    // Perbarui UI di dalam blok utas utama
                    DispatchQueue.main.async {
                        if let image = UIImage(data: imageData) {
                            self.foto.image = image
                        }
                    }
                }
            }
            
            // Mulai unduhan
            task.resume()
        }
        Container.layer.cornerRadius = Container.frame.size.width / 15
        Container.clipsToBounds = true
        button.layer.cornerRadius = button.frame.size.width / 5
        button.clipsToBounds = true
    }
    
}
