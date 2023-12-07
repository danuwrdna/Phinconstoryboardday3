import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var homeTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        delegateTable()
    }
}
extension HomeViewController: UITableViewDelegate, UITableViewDataSource{
    func delegateTable(){
        homeTableView.delegate = self
        homeTableView.dataSource = self
        homeTableView.registerCellWithNib(SectionFirstViewCell.self)
        homeTableView.registerCellWithNib(SectionSecondViewCell.self)
        homeTableView.registerCellWithNib(SectionThirdViewCell.self)
        homeTableView.registerCellWithNib(SectionFourViewCell.self)
        
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
            let first = tableView.dequeueReusableCell(forIndexPath: indexPath) as SectionFirstViewCell
            return first
        case 1:
            let second = tableView.dequeueReusableCell(forIndexPath: indexPath) as SectionSecondViewCell
            return second
        case 2:
            let third = tableView.dequeueReusableCell(forIndexPath: indexPath) as SectionThirdViewCell
            return third
        case 3:
            let four = tableView.dequeueReusableCell(forIndexPath: indexPath) as SectionFourViewCell
            return four
        default:
            return UITableViewCell()
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 270
        case 1:
            return 230
        case 2:
            return 250
        case 3:
            return 240
        default:
            return 100
        }
    }
    
}
