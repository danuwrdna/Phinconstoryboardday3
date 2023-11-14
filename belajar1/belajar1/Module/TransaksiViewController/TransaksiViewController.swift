import UIKit
struct History {
    let judul: String
    let subJudul: String
    let total: String
    
}

class TransaksiViewController: UIViewController {
    let viewModel = TransaksiViewModel()
    @IBOutlet weak var viewTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        registerTable()
    }
    func registerTable(){
        viewTable.delegate = self
        viewTable.dataSource = self
        viewTable.register(UINib(nibName: "TransaksiViewCell", bundle: nil), forCellReuseIdentifier: "cell")
    }
}
extension TransaksiViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.dataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TransaksiViewCell
        let data = viewModel.list[indexPath.row]
        cell.judulLabel?.text = data.judul
        cell.subLabel?.text = data.subJudul
        cell.totalLabel?.text = data.total
        return cell
    }
    
    
}
