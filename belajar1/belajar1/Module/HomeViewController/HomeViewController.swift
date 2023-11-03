import UIKit
import Alamofire
import Kingfisher

class HomeViewController: UIViewController {
    
    
    @IBOutlet weak var listTableView: UITableView!
    @IBOutlet weak var popup: UIView!
    @IBOutlet weak var image3: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var image1: UIImageView!
    @IBAction func serigalabutton(_ sender: Any) {
        let serigalabutton = SerigalaViewController()
        self.navigationController?.pushViewController(serigalabutton, animated: true)
    }
    @IBAction func macanbutton(_ sender: Any) {
        let macanbutton = MacanViewController()
        self.navigationController?.pushViewController(macanbutton, animated: true)
    }
    @IBAction func singabutton(_ sender: Any) {
        let singabutton = SingaViewController()
        self.navigationController?.pushViewController(singabutton, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
            }
    func setup(){
        listTableView.dataSource = self
        listTableView.delegate = self
        listTableView.register(UINib(nibName: "CellTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
    }
    
    }
    
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CellTableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200 // Set the height as needed
    }
}
