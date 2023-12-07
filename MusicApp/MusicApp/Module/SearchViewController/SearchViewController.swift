import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var tablePageSrchView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        delegateTable()
    }
}
extension SearchViewController: UITableViewDelegate, UITableViewDataSource{
    func delegateTable(){
        tablePageSrchView.delegate = self
        tablePageSrchView.dataSource = self
        tablePageSrchView.registerCellWithNib(TopGenresTableCell.self)
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let first = tableView.dequeueReusableCell(forIndexPath: indexPath) as TopGenresTableCell
            return first
        default:
            return UITableViewCell()
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 148
        default:
            return 100
        }
    }
    
}
