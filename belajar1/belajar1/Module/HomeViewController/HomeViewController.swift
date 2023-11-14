import UIKit

struct Learn {
    let id: Int
    let nama: String
    let description: String
    let imageName: String
    let detailViewControllerType: UIViewController.Type
}
class HomeViewController: UIViewController {
    let viewModel = HomeViewModel()

    @IBOutlet weak var listTableView: UITableView!
    @IBOutlet weak var popup: UIView!
    @IBOutlet weak var image3: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var filterView: UISegmentedControl!

    @IBAction func keluarButton(_ sender: Any) {
        // Handle keluar button action
    }
    @IBAction func searchButton(_ sender: Any) {
        let bt = SearchViewController()
        bt.modalTransitionStyle = .crossDissolve
        bt.modalPresentationStyle = .overFullScreen
        self.navigationController?.present(bt, animated: true)
    }
    @IBAction func profileButton(_ sender: Any) {
        let bt = ProfileViewController()
        bt.modalTransitionStyle = .crossDissolve
        bt.modalPresentationStyle = .overFullScreen
        self.navigationController?.present(bt, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.configure()
        setup()
        search()
    }
    func setup() {
        listTableView.dataSource = self
        listTableView.delegate = self
        listTableView.register(UINib(nibName: "CellTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
    }
    func search() {
        filterView.addTarget(self, action: #selector(filterValueChanged), for: .valueChanged)
        filterView.selectedSegmentIndex = UISegmentedControl.noSegment
        updateViewBasedOnFilter()
    }
    @objc func filterValueChanged() {
        updateViewBasedOnFilter()
    }

    func updateViewBasedOnFilter() {
        viewModel.filterData(by: filterView.selectedSegmentIndex)
        listTableView.reloadData()
    }
}
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.learn.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CellTableViewCell
        let data = viewModel.learn[indexPath.row]
        cell.judul?.text = data.nama
        cell.subjudul?.text = data.description
        cell.photoView?.image = UIImage(named: data.imageName)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedLearn = viewModel.originalLearn[indexPath.row]
        let detailViewController = selectedLearn.detailViewControllerType.init()
        navigationController?.present(detailViewController, animated: true)
    }
}
