
import UIKit

class ProfileViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var model = [ProfileModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        ProfileModel.configure()
        model = miningModel
        tableDelegate()
        tableView.layer.cornerRadius = 10.0
    }
}
extension ProfileViewController: UITableViewDelegate, UITableViewDataSource{
    func tableDelegate(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        let data = model[indexPath.row]
        cell.titleLabel?.text = data.title
        cell.subtitleLabel?.text = data.subTitle
        cell.profileImage?.image = UIImage(named: data.imageProfile)
        return cell
    }
    
   
}
