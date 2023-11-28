import UIKit

class SoundAnVC: UIViewController {
    var dogViewModel = DogViewModel()
    
    @IBOutlet weak var tableSound: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        delegateTable()
        callApi()
    }
    func callApi(){
        dogViewModel.onDataUpdate = { [weak self] in
            self?.tableSound.reloadData()
        }
        
        dogViewModel.fetchData()
        
    }
}
extension SoundAnVC: UITableViewDelegate, UITableViewDataSource{
    func delegateTable(){
        tableSound.delegate = self
        tableSound.dataSource = self
        tableSound.registerCellWithNib(SoundTableViewCell.self)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dogViewModel.numberOfItems
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableSound.dequeueReusableCell(withIdentifier: "SoundTableViewCell", for: indexPath) as! SoundTableViewCell
       
        let dogIndex = indexPath.row
        if let dog = dogViewModel.getDogItem(at: dogIndex) {
            let url = URL(string: dog)
            cell.imageSound.kf.setImage(with: url)
        }
        return cell
    }
    
    
}
