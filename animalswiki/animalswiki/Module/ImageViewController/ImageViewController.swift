import UIKit

class ImageViewController: UIViewController {
   
    @IBOutlet weak var tableImView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        delegateTable()
    }
}
extension ImageViewController: UITableViewDelegate, UITableViewDataSource{
    func delegateTable(){
        tableImView.delegate = self
        tableImView.dataSource = self
        tableImView.registerCellWithNib(FirstCellImageVC.self)
        tableImView.registerCellWithNib(SecondCellImageVC.self)
        tableImView.registerCellWithNib(ThirdCellImageVC.self)
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
            let first = tableView.dequeueReusableCell(forIndexPath: indexPath) as FirstCellImageVC
            return first
        case 1:
            let second = tableView.dequeueReusableCell(forIndexPath: indexPath) as SecondCellImageVC
            return second
        case 2:
            let third = tableView.dequeueReusableCell(forIndexPath: indexPath) as ThirdCellImageVC
            return third
        default:
            return UITableViewCell()
        }
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section{
        case 0:
            return 120
        case 1:
            return 319
        case 2:
            return 230
        default:
            return 100
        }
    }
}
