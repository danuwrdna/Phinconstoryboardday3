import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var tablePageSrchView: UITableView!
    @IBAction func btSearch(_ sender: Any) {
        navigate()
    }
    @IBOutlet weak var imgSearch: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        delegateTable()
        border()
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
            return topGenre
        case 1:
            let popularArtist = tableView.dequeueReusableCell(forIndexPath: indexPath) as PopularArtistCell
            return popularArtist
        case 2:
            let browse = tableView.dequeueReusableCell(forIndexPath: indexPath) as BrowseCell
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
extension SearchViewController{
    func border(){
        imgSearch.layer.cornerRadius = 16
    }
}
extension SearchViewController{
    func navigate(){
        let bt = MusicViewController()
        navigationController?.pushViewController(bt, animated: true)
    }
}
