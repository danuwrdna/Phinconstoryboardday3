import UIKit
import CoreData
class SearchViewController: UIViewController{
    var searchViewModel: SearchViewModel!
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
       viewModelSetup()
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
            browse.genre(data: searchViewModel.genre)
            
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
        vc.hidesBottomBarWhenPushed = true
        navigationController?.navigationBar.isHidden = true
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension SearchViewController{
    func navigate(){
        let bt = MusicViewController()
        navigationItem.hidesBackButton = true
        bt.hidesBottomBarWhenPushed = true
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
    func viewModelSetup(){
        searchViewModel = SearchViewModel(viewController: self)
        searchViewModel.fetchDataForGenre()
        searchViewModel.fetchDataFromCoreData()
    }

}
