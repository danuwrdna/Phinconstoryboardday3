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
    @IBOutlet weak var searchButton: UIButton!
    @IBAction func logoutButton(_ sender: Any) {
        alert()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        setup()
        pencarian()
    }
    func setup(){
        listTableView.dataSource = self
        listTableView.delegate = self
        listTableView.register(UINib(nibName: "CellTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
    }
    func alert(){
        let alertController = UIAlertController(title: "Are you sure", message: "Do you want logout", preferredStyle: .actionSheet)
        let okButton = UIAlertAction(title: "Ok", style: .default,handler: {action in
            print(action)
            print("Ok");
        })
        let noButton = UIAlertAction(title: "No", style: .default,handler: {action in
            print(action)
            print("No");
        })
        let cancelButton = UIAlertAction(title: "Cancel", style: .default,handler: {action in
            print(action)
            print("Cancel")
        })
        alertController.addAction(noButton)
        alertController.addAction(okButton)
        
        self.present(alertController, animated: true,completion: {
            print("alert")
        })
    }
    func pencarian(){
        
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
