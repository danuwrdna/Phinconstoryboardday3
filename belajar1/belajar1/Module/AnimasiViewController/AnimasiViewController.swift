import UIKit

class AnimasiViewController: UIViewController {
    @IBAction func mulaiButton(_ sender: Any) {
        animate()
    }
    @IBOutlet weak var myView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    func animate()   {
        UIView.animate(withDuration: 2, animations: {
            self.myView.frame = CGRect(x: 0, y: 0, width: 400, height: 400)
            self.myView.center = self.myView.center
            self.myView.layer.cornerRadius = 50
            self.myView.backgroundColor = UIColor.red
        }, completion: {done in
            if done{
                UIView.animate(withDuration: 5, animations: {
            self.myView.frame = CGRect(x: -40, y: 0, width: 200, height: 200)
            self.myView.center = self.myView.center
            self.myView.layer.cornerRadius = 0
            self.myView.backgroundColor = UIColor.blue
                })
            }
        })
    }
}
