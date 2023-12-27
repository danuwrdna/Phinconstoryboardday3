import UIKit
import CoreData
class SearchViewController: UIViewController{
    var data: [Music] = []
    var genre: [DataGenre] = []
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
        fetchDataForGenre()
       
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
            let browse = tableView.dequeueReusableCell(forIndexPath: indexPath) as BrowseCell
            browse.delegate = self
            browse.genre(data: genre)
            
            return browse
        default:
            return UITableViewCell()
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 670
        default:
            return 100
        }
    }
    
    
}
extension SearchViewController: BrowseDelegateCell {
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
    func fetchDataForGenre() {
        let genreApiModel = GenreApiModel()
        genreApiModel.fetchData { [weak self] result in
            switch result {
            case .success(let genre):
                self?.genre = genre.data ?? []
                print("Fetched Genre Data: \(self?.genre)")
                
                // Reload the table view on the main thread
                print("Before reloadData")
                DispatchQueue.main.async {
                    self?.tablePageSrchView.reloadData()
                }
                print("aft reloadData")

            case .failure(let error):
                // Handle the error
                print("Error: \(error)")
            }
        }
    }

}
