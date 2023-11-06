import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var viewTable: UITableView!
    var songs = [Song]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSongs()
        viewTable.delegate = self
        viewTable.dataSource = self
        viewTable.register(UINib(nibName: "HomeTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
    }
    func configureSongs(){
        songs.append(Song(name: "Yellow",
                          albumName: "123 Something",
                          artistName: "Coldplay",
                          imageName: "350x350",
                          trackName: "Coldplay%20-%20Yellow%20%28Official%20Video%29_yKNxeF4KMsY"))
        songs.append(Song(name: "Fix You",
                          albumName: "123 Something",
                          artistName: "Coldplay",
                          imageName: "c734b124310ef95e2f8fcd3a17f1d1ed.1000x1000x1",
                          trackName: "Track123"))
        songs.append(Song(name: "The Scientist",
                          albumName: "123 Something",
                          artistName: "Coldplay",
                          imageName: "R-731019-1686050660-1456",
                          trackName: "Track123"))
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = viewTable.dequeueReusableCell(withIdentifier: "cell", for: indexPath)as! HomeTableViewCell
        let song = songs[indexPath.row]
        cell.labelView?.text = song.name
        cell.detailText?.text = song.albumName
        cell.accessoryType = .disclosureIndicator
        cell.imageTable?.image = UIImage(named: song.imageName)
        cell.labelView?.font = UIFont(name: "Helvetica-Bold", size: 18)
        cell.detailText?.font = UIFont(name: "Helvetica", size: 17)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewTable.deselectRow(at: indexPath, animated: true)
        let position = indexPath.row
        let vc = PlayerViewController()
        self.navigationController?.present(vc, animated: true)
        vc.songs = songs
        vc.position = position
        }
    
    }

struct Song{
    let name: String
    let albumName: String
    let artistName: String
    let imageName: String
    let trackName: String
    
}
