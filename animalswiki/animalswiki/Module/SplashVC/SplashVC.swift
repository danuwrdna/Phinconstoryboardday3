import UIKit

class SplashVC: UIViewController {

    @IBOutlet weak var imageSplash: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigate()
        tabBarController?.tabBar.isHidden = true
    }
    func navigate(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        imageSplash.isUserInteractionEnabled = true
        imageSplash.addGestureRecognizer(tapGesture)
    }
    @objc func imageTapped() {
        let detailVC = HomeViewController()
        tabBarController?.tabBar.isHidden = false
    // Gantilah dengan logika Anda untuk mendapatkan nama gambar yang dipilih

        // Melakukan navigasi ke detailVC
        navigationController?.pushViewController(detailVC, animated: true)
    }

}
