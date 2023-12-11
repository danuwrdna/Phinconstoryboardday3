import UIKit
import Lottie

class SplashViewController: UIViewController {

    let musicAnimationView = LottieAnimationView(name: "musicAnimate")

    override func viewDidLoad() {
        super.viewDidLoad()
        animate()
        
        NotificationCenter.default.addObserver(self, selector: #selector(animationDidFinish), name: .init("AnimationDidFinish"), object: nil)
    }

    @objc func animationDidFinish() {
        // Animasi selesai, pindah ke LoginViewController
        let loginViewController = LoginViewController() // Gantilah dengan inisialisasi LoginViewController Anda
        navigationController?.pushViewController(loginViewController, animated: true)
    }
}

extension SplashViewController {

    func animate() {
        musicAnimationView.frame = CGRect(x: 0, y: 0, width: 352, height: 892)
        musicAnimationView.center = CGPoint(x: view.frame.width / 2, y: view.frame.height / 2)
        musicAnimationView.contentMode = .scaleAspectFit
        musicAnimationView.loopMode = .playOnce // Ganti dari .loop ke .playOnce
        view.addSubview(musicAnimationView)
        musicAnimationView.play(completion: { _ in
            // Animasi selesai, kirim notifikasi
            NotificationCenter.default.post(name: .init("AnimationDidFinish"), object: nil)
        })
    }
}
