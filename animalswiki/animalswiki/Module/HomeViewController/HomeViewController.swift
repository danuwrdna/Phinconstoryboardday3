import UIKit
class HomeViewController:
    UIViewController {
    var viewModel = HomeViewModel()
    @IBOutlet weak var homeTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: true)
        delegateTable()
        fetchData()
    }
    func fetchData(){
        
    }
}
extension HomeViewController: UITableViewDelegate, UITableViewDataSource{
    func delegateTable(){
       homeTableView.delegate = self
       homeTableView.dataSource = self
       homeTableView.registerCellWithNib(FirstPictureVC.self)
        homeTableView.registerCellWithNib(SecondPictureCell.self)
        homeTableView.registerCellWithNib(ThirdPictureCell.self)
        homeTableView.registerCellWithNib(FourPictureCell.self)
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            let first = tableView.dequeueReusableCell(forIndexPath: indexPath) as FirstPictureVC
            return first
        case 1:
            let second = tableView.dequeueReusableCell(forIndexPath: indexPath) as SecondPictureCell
            return second
        case 2:
            let third = tableView.dequeueReusableCell(forIndexPath: indexPath) as ThirdPictureCell
            return third
        case 3:
            let four = tableView.dequeueReusableCell(forIndexPath: indexPath) as FourPictureCell
        return four
        default:
            return UITableViewCell()
        }
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            // Setel tinggi untuk case 0
            return 100
        case 1:
            // Setel tinggi untuk case 1
            return 150
        // ... tambahkan case lain jika diperlukan
        case 2:
            return 200
        case 3:
            return 300
        default:
            return 100
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section{
        case 0:
            return
        case 1:
            return
        case 2:
            if let cell = tableView.cellForRow(at: indexPath) as? ThirdPictureCell{
                let labelValue = cell.adamLabel.text
                    let newViewController = ListContentVC()
                    self.navigationController?.pushViewController(newViewController, animated: true)
                
                }
            return
        case 3:
            return
            
        default:
            break
        }
    }
}
