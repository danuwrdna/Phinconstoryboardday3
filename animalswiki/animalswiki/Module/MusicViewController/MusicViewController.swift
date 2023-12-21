import UIKit
import AVFoundation
import Kingfisher
import CoreData
import SkeletonView

class MusicViewController: UIViewController {
    private var subTitle = ""
    private var artist = ""
    var musicViewModel: LogicMusicViewModel!
    @IBOutlet weak var viewSearch: UIView!
    @IBOutlet weak var startLabel: UILabel!
    @IBOutlet weak var finishLabel: UILabel!
    @IBOutlet weak var playPauseButton: UIButton!
    @IBOutlet weak var subHeadLabel: UILabel!
    @IBOutlet weak var headLabel: UILabel!
    @IBOutlet weak var imgAB: UIImageView!
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var tableMusic: UITableView!
    @IBOutlet weak var viewHome: UIView!
    @IBAction func btCamera(_ sender: Any) {
        forBtCamera()
    }
    @IBAction func nextButton(_ sender: UIButton) {
        nextBT()
    }
    
    @IBAction func previousButton(_ sender: UIButton) {
        previousBT()
    }
    
    @IBAction func categoryBT1(_ sender: UIButton) {
        
    }
    @IBAction func backBT(_ sender: Any) {
        btBack()
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        searchField.delegate = self
       setupFetchPassingData()
        delegateTable()
        viewSrch()
        progress()
        playPause()
        borderViewHome()
        borderImageAb()
        setupTextField()
       
    }
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
        searchField.becomeFirstResponder()
    }
}
extension MusicViewController: UITableViewDelegate, UITableViewDataSource{
    
    func delegateTable(){
        tableMusic.delegate = self
        tableMusic.dataSource = self
        tableMusic.register(UINib(nibName: "MusicTableViewCell", bundle: nil), forCellReuseIdentifier: "MusicTableViewCell")
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return musicViewModel.sectionIndexTitles[section]
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return musicViewModel.numberOfRows(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableMusic.dequeueReusableCell(withIdentifier: "MusicTableViewCell", for: indexPath) as! MusicTableViewCell
        musicViewModel.configureCell(cell, at: indexPath)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        playPause()
    }
    
}
extension MusicViewController: SkeletonTableViewDelegate{
    func numSections(in collectionSkeletonView: UITableView) -> Int {
        return 1
    }
    
    func collectionSkeletonView(_ skeletonView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return "MusicTableViewCell"
    }
}
extension MusicViewController{
    func progress(){
        musicViewModel.progress()
    }
}
extension MusicViewController {
    func playPause(){
        musicViewModel.playPause()
        musicViewModel.playy()
    }
    func nextBT(){
        musicViewModel.nextBT()
    }
    func previousBT(){
        musicViewModel.previousBT()
    }
}
extension MusicViewController{
    func borderViewHome(){
        viewHome.layer.cornerRadius = 10
        viewHome.layer.masksToBounds = false
        viewHome.layer.shadowColor = UIColor.black.cgColor
        viewHome.layer.shadowOpacity = 0.5
        viewHome.layer.shadowOffset = CGSize(width: 0, height: 2)
        viewHome.layer.shadowRadius = 4.0
        viewHome.layer.shouldRasterize = true
        viewHome.layer.rasterizationScale = UIScreen.main.scale
        viewHome.isHidden = true
        
    }
    func borderImageAb(){
        imgAB.layer.cornerRadius = 16
        imgAB.layer.shadowColor = UIColor.black.cgColor
        imgAB.layer.shadowOpacity = 0.5
        imgAB.layer.shadowOffset = CGSize(width: 0, height: 2)
        imgAB.layer.shadowRadius = 4.0
        imgAB.layer.cornerRadius = 16
        imgAB.layer.masksToBounds = false
        imgAB.clipsToBounds = true
    }
}
extension MusicViewController: UITextFieldDelegate {
    func setupTextField(){
        musicViewModel.setupTextField()
        musicViewModel.viewModel(searchTerm: "")
        musicViewModel.fetchDataFromCoreData()
        musicViewModel.performSearch(with: "")
        searchField?.text = subTitle + artist
        //searchField?.text = artist
    }
    
}
extension MusicViewController{
    func viewSrch(){
        viewSearch.layer.cornerRadius = 16
        viewSearch.layer.masksToBounds = false
        viewSearch.layer.shadowColor = UIColor.black.cgColor
        viewSearch.layer.shadowOpacity = 0.5
        viewSearch.layer.shadowOffset = CGSize(width: 0, height: 2)
        viewSearch.layer.shadowRadius = 4.0
        viewSearch.layer.shouldRasterize = true
        viewSearch.layer.rasterizationScale = UIScreen.main.scale
    }
}
extension MusicViewController{
    func btBack(){
        navigationController?.popViewController(animated: true)
    }
}
extension MusicViewController{
    func forBtCamera(){
        musicViewModel.forBtCamera()
    }
}
extension MusicViewController{
    func setImage(subTitle: String) {
        self.subTitle = subTitle
        searchField?.text = subTitle // Set the text of the searchField
                musicViewModel?.performSearch(with: subTitle)
    }
    func setImageSectionFirst(artist: String) {
        self.artist = artist
        searchField?.text = artist // Set the text of the searchField
                musicViewModel?.performSearch(with: artist)
    }
}
extension MusicViewController{
    func setupFetchPassingData(){
        musicViewModel = LogicMusicViewModel(viewController: self)
        musicViewModel.performSearch(with: subTitle + artist)
    }
}
