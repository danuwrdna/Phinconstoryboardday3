import UIKit
import Alamofire
import Kingfisher

class TestApiViewController: UIViewController {
    
    @IBOutlet weak var viewTable: UITableView!
    
    var model: PokemontModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        fetchData()
    }
    
    func setup() {
        viewTable.dataSource = self
        viewTable.delegate = self
        viewTable.register(UINib(nibName: "PokemonTableViewCell", bundle: nil), forCellReuseIdentifier: "PokemonTableViewCell")
    }
    
    func fetchData(){
        let apiURL = "https://pokeapi.co/api/v2/pokemon?offset=0&limit=1000"
        NetworkManager.shared.makeAPICall(urlString: apiURL, method: .get, completion: { (response: Result<PokemontModel, Error>) in
            switch response {
            case .success(let trades):
                self.model = trades
                self.viewTable.reloadData()
            case .failure(let error):
                print("API Request Error: \(error.localizedDescription)")
            }
        })
    }
    
   
}
extension TestApiViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model?.results.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let data = model {
            let cell = viewTable.dequeueReusableCell(withIdentifier: "PokemonTableViewCell", for: indexPath) as! PokemonTableViewCell
            let modelItem = data.results[indexPath.row]
            cell.textView.text = modelItem.name
            let imagePoke = "https://img.pokemondb.net/artwork/\(modelItem.name).jpg"
//            cell.viewImage.image = UIImage(named: modelItem.url)
            cell.viewImage.kf.setImage(with: URL(string: imagePoke))
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
