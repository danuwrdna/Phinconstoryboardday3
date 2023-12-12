import UIKit
import CoreData
class CollectionMusicVC: UIViewController {
   
    @IBOutlet weak var tableCmView: UITableView!
    var coreDataArray: [Music] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        delegateTable()
        fetchDataFromCoreData()

    }
}
extension CollectionMusicVC: UITableViewDelegate, UITableViewDataSource{
    func delegateTable(){
        tableCmView.delegate = self
        tableCmView.dataSource = self
        tableCmView.registerCellWithNib(CmTableViewCell.self)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coreDataArray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableCmView.dequeueReusableCell(withIdentifier: "CmTableViewCell", for: indexPath) as! CmTableViewCell// Replace YourCollectionViewCell with the actual name of your cell class
        let datum = coreDataArray[indexPath.item]
        cell.labelCollection?.text = datum.title
        cell.subLabelCollection?.text = datum.subtitle
        if let imageUrlString = datum.image,
               let imageUrl = URL(string: imageUrlString) {
                cell.imageView?.kf.setImage(with: imageUrl)
            } else {
                // Jika properti gambar tidak ada atau tidak valid, atur gambar placeholder
                cell.imageView?.image = UIImage(named: "placeholderImage")
            }
        return cell
        }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 117
//    }
    }
    
extension CollectionMusicVC{
    func fetchDataFromCoreData() {
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Music")
            
            do {
                let result = try context.fetch(fetchRequest)
                coreDataArray = result as! [Music] // Update YourCoreDataType with your actual data type
                tableCmView.reloadData()
            } catch {
                fatalError("Gagal mengambil data dari Core Data: \(error)")
            }
        }
}
