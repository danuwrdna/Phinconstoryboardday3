import UIKit
import Alamofire
import Kingfisher

class TestApiViewController: UIViewController {
    @IBOutlet weak var viewTable: UITableView!
    var viewModel = PokemonListViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        fetchData()
    }
    func setup() {
        viewTable.dataSource = self
        viewTable.delegate = self
        viewTable.register(UINib(nibName: "PokemonTableViewCell", bundle: nil), forCellReuseIdentifier: "PokemonTableViewCell")
        viewModel.onDataUpdate = { [weak self] in
            self?.viewTable.reloadData()
        }
    }

    func fetchData() {
        viewModel.fetchData()
    }
}

extension TestApiViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItems
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let item = viewModel.getPokemonItem(at: indexPath.row) {
            let cell = viewTable.dequeueReusableCell(withIdentifier: "PokemonTableViewCell", for: indexPath) as! PokemonTableViewCell
            cell.textView.text = item.name
            let imagePoke = "https://img.pokemondb.net/artwork/\(item.name).jpg"
            cell.viewImage.kf.setImage(with: URL(string: imagePoke))
            return cell
        }
        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
