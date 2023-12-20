import UIKit
import CoreData
class HomeViewController: UIViewController {
    //var section = SectionFirstViewCell()
    var data: [Music] = []
    @IBOutlet weak var homeTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        delegateTable()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchDataFromCoreData()
        
    }
    
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource{
    func delegateTable(){
        homeTableView.delegate = self
        homeTableView.dataSource = self
        homeTableView.registerCellWithNib(SectionFirstViewCell.self)
        homeTableView.registerCellWithNib(SectionSecondViewCell.self)
        homeTableView.registerCellWithNib(SectionThirdViewCell.self)
        homeTableView.registerCellWithNib(SectionFourViewCell.self)
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let first = tableView.dequeueReusableCell(forIndexPath: indexPath) as SectionFirstViewCell
            first.passData(data: data)
            return first
        case 1:
            let second = tableView.dequeueReusableCell(forIndexPath: indexPath) as SectionSecondViewCell
            second.passData(data: data)
            second.delegate = self
            return second
        case 2:
            let third = tableView.dequeueReusableCell(forIndexPath: indexPath) as SectionThirdViewCell
            third.passData(data: data)
            return third
        case 3:
            let four = tableView.dequeueReusableCell(forIndexPath: indexPath) as SectionFourViewCell
            four.passData(data: data)
            return four
        default:
            return UITableViewCell()
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 270
        case 1:
            return 230
        case 2:
            return 250
        case 3:
            return 240
        default:
            return 100
        }
    }
    
    
}
extension HomeViewController{
    func fetchDataFromCoreData() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Music")
        
        do {
            let result = try context.fetch(fetchRequest)
           data = result as! [Music]
            homeTableView.reloadData()
        } catch {
            fatalError("Gagal mengambil data dari Core Data: \(error)")
        }
        
    }
}

extension HomeViewController: SectionSecondViewCellDelegate {
    func didSelectItemAt(image: String) {
        let vc = DetailViewController()
        vc.setImage(image: image)
        navigationController?.navigationBar.isHidden = true
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
