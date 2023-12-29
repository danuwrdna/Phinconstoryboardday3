import UIKit
import AVFoundation
import Kingfisher
import CoreData
import SkeletonView
import Lottie

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

    @IBOutlet weak var activityLoading: UIActivityIndicatorView!
    @IBAction func fiterMusicBT(_ sender: Any) {
        musicViewModel.filterData()
    }
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
    viewHome.applyShadowWithCornerRadius(cornerRadius: 10, shadowColor: UIColor.black, shadowOpacity: 0.5, shadowOffset: CGSize(width: 0, height: 2), shadowRadius: 4.0)
    viewHome.isHidden = true
    viewHome.clipsToBounds = false
        
    }
    func borderImageAb(){
        imgAB.applyShadowWithCornerRadius(cornerRadius: 16, shadowColor: UIColor.black, shadowOpacity: 0.5, shadowOffset: CGSize(width: 0, height: 2), shadowRadius: 4.0)
        imgAB.clipsToBounds = false
    }
}
extension MusicViewController: UITextFieldDelegate {
    func setupTextField(){
        musicViewModel.setupTextField()
        musicViewModel.viewModel(searchTerm: "")
        musicViewModel.fetchDataFromCoreData()
        musicViewModel.performSearch(with: "")
        searchField?.text = subTitle + artist
    }
    
}
extension MusicViewController{
    func viewSrch(){
        viewSearch.applyShadowWithCornerRadius(cornerRadius: 16, shadowColor: UIColor.black, shadowOpacity: 0.5, shadowOffset: CGSize(width: 0, height: 2), shadowRadius: 4.0)
        viewSearch.clipsToBounds = false

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
        searchField?.text = subTitle
                musicViewModel?.performSearch(with: subTitle)
    }
    func setImageSectionFirst(artist: String) {
        self.artist = artist
        searchField?.text = artist
                musicViewModel?.performSearch(with: artist)
    }
}
extension MusicViewController{
    func setupFetchPassingData(){
        musicViewModel = LogicMusicViewModel(viewController: self)
        musicViewModel.performSearch(with: subTitle + artist)
    }
}
