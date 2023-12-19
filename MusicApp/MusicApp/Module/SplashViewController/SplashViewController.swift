import UIKit
import Lottie

class SplashViewController: UIViewController {
    
    let musicAnimationView = LottieAnimationView(name: "musicAnimate")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        animate()
        animateNavigate()
    }
    
}

extension SplashViewController {
    
    func animate() {
        musicAnimationView.frame = CGRect(x: 0, y: 0, width: 352, height: 892)
        musicAnimationView.center = CGPoint(x: view.frame.width / 2, y: view.frame.height / 2)
        musicAnimationView.contentMode = .scaleAspectFit
        musicAnimationView.loopMode = .playOnce
        view.addSubview(musicAnimationView)
        musicAnimationView.play(completion: { _ in
            NotificationCenter.default.post(name: .init("AnimationDidFinish"), object: nil)
        })
    }
}
extension SplashViewController{
    func animateNavigate(){
        NotificationCenter.default.addObserver(self, selector: #selector(animationDidFinish), name: .init("AnimationDidFinish"), object: nil)
    }
    @objc func animationDidFinish() {
        let ng = MainTabBarViewController()
        ng.navigationItem.hidesBackButton = true
        navigationController?.pushViewController(ng, animated: true)
    }
}
