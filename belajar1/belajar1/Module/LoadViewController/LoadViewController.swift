import UIKit

class LoadViewController: UIViewController {

    @IBOutlet weak var animasiView: SplashScreenVC!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigateToPhotoViewController()
        setupAnimasi()
        navigateToPhotoViewControllerAfterDelay()
    }
    func setupAnimasi(){
        animasiView.startAnimating()
    }
    private func navigateToPhotoViewControllerAfterDelay() {
           // Mengatur waktu jeda 2 detik
           DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) { [weak self] in
               self?.navigateToPhotoViewController()
           }
       }
    private func navigateToPhotoViewController() {
        // Buat instance dari PhotoViewController
        let photoViewController = FotoViewController()

        // Dapatkan referensi ke UINavigationController saat ini
        if let navigationController = self.navigationController {
            // Dorong (push) PhotoViewController ke dalam tumpukan navigasi
            navigationController.pushViewController(photoViewController, animated: true)
        }
    }
}
