import UIKit

class ProgressViewController: UIViewController {
    var imageView = UIImageView()
    var size : CGFloat = 150
    
    @IBAction func slider(_ sender: UISlider) {
        let value = sender.value
        imageView.frame = CGRect(x: 120, y: 300, width: size * CGFloat(value), height: size * CGFloat(value))
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.backgroundColor = .blue
        imageView.frame = CGRect(x: 200, y: 200, width: size, height: size)
        imageView.center = view.center
        self.view.addSubview(imageView)
        
    }
    
    
    }


