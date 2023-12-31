import UIKit
import CoreData
class HomeViewController: UIViewController {
    var homeViewModel: HomeViewModel!
    @IBOutlet weak var homeTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        delegateTable()
       
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchDataFromCoreDataAndAPI()
        navigationController?.isNavigationBarHidden = true
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource{
    func delegateTable(){
        homeTableView.delegate = self
        homeTableView.dataSource = self
        homeTableView.registerCellWithNib(ListenYourWayViewCell.self)
        homeTableView.registerCellWithNib(RecentlyPlayedCell.self)
        homeTableView.registerCellWithNib(EnjoyYourMusicViewCell.self)
        homeTableView.registerCellWithNib(NewReleaseViewCell.self)
        
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
            let first = tableView.dequeueReusableCell(forIndexPath: indexPath) as ListenYourWayViewCell
            first.passData(data: homeViewModel.data)
            first.passApiData(dataApi: homeViewModel.apiData)
            first.delegate = self
            return first
        case 1:
            let second = tableView.dequeueReusableCell(forIndexPath: indexPath) as RecentlyPlayedCell
            second.passData(data: homeViewModel.data)
            second.delegate = self
            return second
        case 2:
            let third = tableView.dequeueReusableCell(forIndexPath: indexPath) as EnjoyYourMusicViewCell
            third.apiData = homeViewModel.dataPlaylist
            third.delegate = self
            return third
        case 3:
            let four = tableView.dequeueReusableCell(forIndexPath: indexPath) as NewReleaseViewCell
            four.passData(data: homeViewModel.data)
            four.passApiData(dataApi: homeViewModel.apiData)
            four.delegate = self
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
            return 200
        case 2:
            return 235
        case 3:
            return 240
        default:
            return 100
        }
    }
    
    
}
extension HomeViewController{
    func fetchDataFromCoreDataAndAPI(){
        homeViewModel = HomeViewModel(viewController: self)
        homeViewModel.fetchDataFromCoreData()
        homeViewModel.fetchDataApiArtist()
        homeViewModel.fetchDataPlaylistHappyMusic()
    }
}

extension HomeViewController: EnjoyYourMusicViewCellDelegate,NewReleaseViewCellDelegate {
    func didSelectItemAt(subTitle: String) {
        let vc = MusicViewController()
        vc.setImage(subTitle: subTitle )
        vc.hidesBottomBarWhenPushed = true
        navigationController?.navigationBar.isHidden = true
        navigationController?.pushViewController(vc, animated: true)
    }
}
extension HomeViewController: RecentlyPlayedViewCellDelegate {
    func didSelectItemAtSectionSecond(subTitle: String) {
//        let vc = PlayedViewController()
//        vc.query = subTitle
//        vc.hidesBottomBarWhenPushed = true
//        navigationController?.navigationBar.isHidden = true
//        navigationController?.present(vc, animated: true)
    }
}

extension HomeViewController: ListenYourWayViewCellDelegate{
    func didSelectItemAt(artist: String) {
        let vc = MusicViewController()
        vc.setImageSectionFirst(artist: artist)
        vc.hidesBottomBarWhenPushed = true
        navigationController?.navigationBar.isHidden = true
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
