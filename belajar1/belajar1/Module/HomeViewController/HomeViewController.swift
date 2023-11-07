import UIKit
struct Learn{
    let nama: String
    let description: String
    let imageName: String
}
class HomeViewController: UIViewController {
    
    var learn = [Learn]()
    @IBOutlet weak var listTableView: UITableView!
    @IBOutlet weak var popup: UIView!
    @IBOutlet weak var image3: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var image1: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        setup()
    }
    func setup(){
        listTableView.dataSource = self
        listTableView.delegate = self
        listTableView.register(UINib(nibName: "CellTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
    }
    func configure(){
        learn.append(Learn(nama: "It",
                           description: "aasaasasasasasasa",
                          imageName: "Harimau-sumatera-768x512"
                          ))
        learn.append(Learn(
            nama: "It",
            description: "aasaasasasasasasa",
                          imageName: "kesaktian-kumis-macan-jimat-yang-dipercaya-sebagai-pemancar-kewibawaan-mqsOUsAFjK"
                          ))
        learn.append(Learn(nama: "It",
                           description: "aasaasasasasasasa",
                          imageName: "Lion_waiting_in_Namibia"
                          ))
        learn.append(Learn(nama: "It",
                           description: "aasaasasasasasasa",
                          imageName: "Harimau-sumatera-768x512"
                          ))
        learn.append(Learn(
            nama: "It",
            description: "aasaasasasasasasa",
                          imageName: "kesaktian-kumis-macan-jimat-yang-dipercaya-sebagai-pemancar-kewibawaan-mqsOUsAFjK"
                          ))
        learn.append(Learn(nama: "It",
                           description: "aasaasasasasasasa",
                          imageName: "Lion_waiting_in_Namibia"
                          ))
    }
}
    
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return learn.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CellTableViewCell
        let data = learn[indexPath.row]
       
        cell.photoView?.image = UIImage(named: data.imageName )
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200// Set the height as needed
    }
}
