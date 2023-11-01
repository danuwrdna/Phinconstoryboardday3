import UIKit

class PengaturanViewController: UIViewController {
    @IBAction func scanButton(_ sender: Any) {
        let scanbutton = ScanViewController()
        self.navigationController?.pushViewController(scanbutton, animated: true)
    }
    @IBAction func galleryButton(_ sender: Any) {
        let gallerybutton = GalleryViewController()
        self.navigationController?.pushViewController(gallerybutton, animated: true)
    }
    @IBAction func mapButton(_ sender: Any) {
        let mapbutton = LokasiViewController()
        self.navigationController?.pushViewController(mapbutton, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
