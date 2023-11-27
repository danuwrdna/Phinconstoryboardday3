import UIKit

class IcLoveViewController: UIViewController {
    
    
    @IBOutlet weak var viewTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        delegateTableIcLove()
    }
}
extension IcLoveViewController: UITableViewDelegate, UITableViewDataSource{
    func delegateTableIcLove(){
        viewTable.delegate = self
        viewTable.dataSource = self
        viewTable.registerCellWithNib(FirstCellLoveVC.self)
        viewTable.registerCellWithNib(SecondCellLoveVC.self)
        viewTable.registerCellWithNib(ThirdCellLoveVC.self)
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
            let first = tableView.dequeueReusableCell(forIndexPath: indexPath) as FirstCellLoveVC
            return first
        case 1:
            let second = tableView.dequeueReusableCell(forIndexPath: indexPath) as SecondCellLoveVC
            return second
        case 2:
            let third = tableView.dequeueReusableCell(forIndexPath: indexPath) as ThirdCellLoveVC
            return third
        default:
            return UITableViewCell()
        }
    }
}
