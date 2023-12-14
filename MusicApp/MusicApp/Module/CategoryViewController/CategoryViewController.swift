
import UIKit

class CategoryViewController: UIViewController {
    var selectedText: String?
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var tableCategoryView: UITableView!
    @IBAction func backBT(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        delegateTable()

    }
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
}
extension CategoryViewController: UITableViewDataSource, UITableViewDelegate{
    func delegateTable(){
        tableCategoryView.delegate = self
        tableCategoryView.dataSource = self
        tableCategoryView.registerCellWithNib(TopViewCell.self)
        tableCategoryView.registerCellWithNib(BodyViewCell.self)
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let topCell = tableView.dequeueReusableCell(forIndexPath: indexPath) as TopViewCell
            return topCell
        case 1:
            let bodyViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath) as BodyViewCell
            return bodyViewCell
        default:
            return UITableViewCell()
        }
    }
    
    
}

