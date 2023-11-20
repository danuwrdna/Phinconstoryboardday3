import UIKit
//dashboardTableView.registerCellWithNib(DashboardSearch.self)
//dashboardTableView.registerCellWithNib(DashboardCategory.self)
//dashboardTableView.registerCellWithNib(TodayAnime.self)
//dashboardTableView.registerCellWithNib(CurrentSeasonAnime.self)
class HomeViewController:
    UIViewController {
    @IBOutlet weak var homeTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: true)
        delegateTable()
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
    
    
}
