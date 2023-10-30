//
//  ViewController.swift
//  tutorial
//
//  Created by Phincon on 25/10/23.
//

import UIKit


class ViewController: UIViewController {
    @IBAction func hewanbutton(_ sender: Any) {
        
        let hewanbutton = UIStoryboard(name: "Main", bundle: nil)
        
        let destinasiviewcontroller = hewanbutton.instantiateViewController(withIdentifier: "TableAndCollectionViewID")
        
        self.navigationController?.pushViewController(destinasiviewcontroller, animated: true)
    }
    
    @IBOutlet weak var headline: UILabel!
    @IBAction func TableButton(_ sender: Any) {
        let tablebutton = UIStoryboard(name: "Main", bundle: nil)
        
        let destinasiviewcontroller = tablebutton.instantiateViewController(withIdentifier: "ListViewController")
        
        self.navigationController?.pushViewController(destinasiviewcontroller, animated: true)
    }
    
    @IBOutlet weak var foto: UIImageView!
    
    //Buuton halaman baru
    @IBAction func Halamanbaru(_ sender: Any) {
        
        let buttonhalamanbaru = UIStoryboard(name: "Main", bundle: nil)
        
        let destinasiviewcontroller = buttonhalamanbaru.instantiateViewController(withIdentifier: "NewHalamanStoryBoardID")
        
        self.navigationController?.pushViewController(destinasiviewcontroller, animated: true)
    }
    
    //Button Collection View
    
    
    @IBAction func koleksiview(_ sender: Any) {
        
        let collection = UIStoryboard(name: "Main", bundle: nil)
        
        let destinasikoleksi = collection.instantiateViewController(withIdentifier: "CollectionViewID")
        
        self.navigationController?.pushViewController(destinasikoleksi, animated: true)
    }
    
    
    
    
    @IBOutlet weak var delete: UIView!
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
        
    }
    
    @IBAction func buttonlist(_ sender: Any) {
        //        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        //        let vc = storyboard.instantiateViewController(withIdentifier: "DetailStoryBoardID")
        //        self.navigationController?.pushViewController(vc, animated: true)
        
        performSegue(withIdentifier: "ListViewController", sender: self)
    }
    
    @IBAction func update(_ sender: UIButton) {
        performSegue(withIdentifier: "halamanupdate", sender: self)
        
    }
    
    
    
}
