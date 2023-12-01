import UIKit
import Lottie

class AnimasiViewController: UIView{
    private let loadingView: LottieAnimationView = {
        let animationView = LottieAnimationView(name: "1QaSIWomgo")
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
        addSubview(loadingView)

        NSLayoutConstraint.activate([
            loadingView.centerXAnchor.constraint(equalTo: centerXAnchor),
            loadingView.centerYAnchor.constraint(equalTo: centerYAnchor),
            loadingView.widthAnchor.constraint(equalToConstant: 300),
            loadingView.heightAnchor.constraint(equalToConstant: 300)
        ])
            loadingView.layer.shadowColor = UIColor.black.cgColor
            loadingView.layer.shadowOpacity = 5
            loadingView.layer.shadowOffset = CGSize(width: 0, height: 2)
            loadingView.layer.shadowRadius = 5
    }

    func startAnimating() {
        loadingView.isHidden = false
        loadingView.play()
    }

    func stopAnimating() {
        loadingView.isHidden = true
        loadingView.stop()
    }
}




