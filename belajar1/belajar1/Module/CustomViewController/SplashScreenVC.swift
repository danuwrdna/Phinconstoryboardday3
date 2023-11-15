import UIKit
import Lottie

class SplashScreenVC: UIView{
    
    private let loadingAnimationView: LottieAnimationView = {
        let animationView = LottieAnimationView(name: "SplashScreen")
        animationView.loopMode = .loop
        animationView.translatesAutoresizingMaskIntoConstraints = false
        return animationView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }

    private func setupViews() {
        addSubview(loadingAnimationView)

        NSLayoutConstraint.activate([
            loadingAnimationView.centerXAnchor.constraint(equalTo: centerXAnchor),
            loadingAnimationView.centerYAnchor.constraint(equalTo: centerYAnchor),
            loadingAnimationView.widthAnchor.constraint(equalToConstant: 300),
            loadingAnimationView.heightAnchor.constraint(equalToConstant: 300)
        ])
    }

    func startAnimating() {
        loadingAnimationView.isHidden = false
        loadingAnimationView.play()
    }

    func stopAnimating() {
        loadingAnimationView.isHidden = true
        loadingAnimationView.stop()
    }
}
