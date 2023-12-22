import UIKit
import CoreData
class SearchViewController: UIViewController{
    var data: [Music] = []
    @IBOutlet weak var tablePageSrchView: UITableView!
    @IBAction func btSearch(_ sender: Any) {
        navigate()
    }
    
    @IBAction func btCamera(_ sender: Any) {
        forBtCamera()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        delegateTable()
       
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchDataFromCoreData()
    }
}
extension SearchViewController: UITableViewDelegate, UITableViewDataSource{
    func delegateTable(){
        tablePageSrchView.delegate = self
        tablePageSrchView.dataSource = self
        tablePageSrchView.registerCellWithNib(TopGenresTableCell.self)
        tablePageSrchView.registerCellWithNib(PopularArtistCell.self)
        tablePageSrchView.registerCellWithNib(BrowseCell.self)
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
            let topGenre = tableView.dequeueReusableCell(forIndexPath: indexPath) as TopGenresTableCell
            topGenre.delegate = self
            topGenre.passData(data: data)
            return topGenre
        case 1:
            let popularArtist = tableView.dequeueReusableCell(forIndexPath: indexPath) as PopularArtistCell
            popularArtist.delegate = self
            popularArtist.passData(data: data)
            return popularArtist
        case 2:
            let browse = tableView.dequeueReusableCell(forIndexPath: indexPath) as BrowseCell
            browse.delegate = self
            browse.passData(data: data)
            return browse
        default:
            return UITableViewCell()
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 148
        case 1:
            return 148
        case 2:
            return 300
        default:
            return 100
        }
    }
    
    
}
extension SearchViewController: TopTableCell,PopularArtistDelegateCell,BrowseDelegateCell {
    func didSelectItemAt(subTitle: String) {
        let vc = MusicViewController()
        vc.setImage(subTitle: subTitle )
        navigationController?.navigationBar.isHidden = true
        navigationController?.pushViewController(vc, animated: true)
    }
}


extension SearchViewController{
    func navigate(){
        let bt = MusicViewController()
        navigationItem.hidesBackButton = true
        navigationController?.pushViewController(bt, animated: true)
    }
}
extension SearchViewController: UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    func forBtCamera(){
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .camera
            imagePicker.allowsEditing = true
            present(imagePicker, animated: true, completion: nil)
        } else {
            print("Camera not available")
        }
    }
}
extension SearchViewController{
    func fetchDataFromCoreData() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Music")
        
        do {
            let result = try context.fetch(fetchRequest)
            data = result as! [Music]
            tablePageSrchView.reloadData()
        } catch {
            fatalError("Gagal mengambil data dari Core Data: \(error)")
        }
        
    }
}
