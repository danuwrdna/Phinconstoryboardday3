import UIKit

struct Learn {
    let nama: String
    let description: String
    let imageName: String
}
class HomeViewController: UIViewController {
    var originalLearn = [Learn]()
    var learn = [Learn]()
    @IBOutlet weak var listTableView: UITableView!
    @IBOutlet weak var popup: UIView!
    @IBOutlet weak var image3: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var filterView: UISegmentedControl!
    @IBAction func logoutButton(_ sender: Any) {
            alert()
        }
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
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
        switch filterView.selectedSegmentIndex {
        case 0:
            learn.sort(by: { (learn1, learn2) in
                let harga1 = extractHarga(from: learn1.description)
                let harga2 = extractHarga(from: learn2.description)
                return harga1 > harga2
            })
        case 1:
            learn.sort(by: { (learn1, learn2) in
                let harga1 = extractHarga(from: learn1.description)
                let harga2 = extractHarga(from: learn2.description)
                return harga1 < harga2
            })
        default:
            learn = originalLearn
        }
        listTableView.reloadData()
    }
}
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return learn.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CellTableViewCell
        let data = learn[indexPath.row]
        cell.judul?.text = data.nama
        cell.subjudul?.text = data.description
        cell.photoView?.image = UIImage(named: data.imageName )
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    func configure() {
        originalLearn = [
            Learn(nama: "Duo sejoli",
                  description: "Rp. 200.000",
                  imageName: "two-cats-lying-white-background-pet-animals_73107-1"
            ),
            Learn(nama: "jomblo sejati",
                  description: "Rp. 150.000",
                  imageName: "afe76dd0358105b5b9c84be3ce8b2143"
            ),
            Learn(nama: "Peduli teman",
                  description: "Rp. 400.000",
                  imageName: "360_F_101249007_L4x7p3dSC13zCOnQn7GZUoxRz5Opoobz"
            ),
            Learn(nama: "Peduli keluarga",
                  description: "Rp. 350.000",
                  imageName: "four-different-kittens-white-background-huddle-together_485703-44"
            ),
            Learn(nama: "It",
                  description: "aasaasasasasasasa",
                  imageName: ""
            ),
            Learn(nama: "It",
                  description: "aasaasasasasasasa",
                  imageName: "Lion_waiting_in_Namibia"
            )
        ]
        learn = originalLearn
    }
    func extractHarga(from description: String) -> Double {
        let components = description.components(separatedBy: " ")
        if let hargaString = components.last, let harga = Double(hargaString) {
            return harga
        }
        return 0.0
    }
    func alert(){
        let alertController = UIAlertController(title: "Are you sure", message: "Do you want logout", preferredStyle: .actionSheet)
        let okButton = UIAlertAction(title: "Ok", style: .default,handler: {action in
            print(action)
            print("Ok");
        })
    }
}
