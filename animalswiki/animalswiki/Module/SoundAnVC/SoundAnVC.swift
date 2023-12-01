import UIKit
import AVFoundation

class SoundAnVC: UIViewController {
    var soundModel : [SoundAnVcModel] = []
    var currentPlayingSound: SoundAnVcModel?
    var playerLayer = AVPlayerLayer()
    var filteredData: [SoundAnVcModel] = []
    public var player: AVAudioPlayer!
    public var timer: Timer!
    @IBOutlet weak var tableSound: UITableView!
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBAction func playButtonTapped(_ sender: Any) {
        player?.play()
        startTimer()
        setupPlay()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        filteredData = soundModel
        tableSound.reloadData()
        soundModel = SoundAnVcModel.sampleData
        delegateTable()
        setupSearch()
        
    }
    func setupPlay(){
        guard let selectedIndexPath = tableSound.indexPathForSelectedRow else {
               print("No sound selected")
               return
           }

           let selectedSound = filteredData[selectedIndexPath.row]
           playSound(soundName: selectedSound.sound)
           startTimer()
    }
    func playSound(soundName: String) {
        if let url = Bundle.main.url(forResource: soundName, withExtension: "mp3") {
            do {
                player = try AVAudioPlayer(contentsOf: url)
                player?.delegate = self
                progressBar.progress = 0.0
            } catch {
                print("Error playing audio: \(error.localizedDescription)")
            }
        } else {
            print("Sound file not found.")
        }
    }
    func startTimer() {
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateProgress), userInfo: nil, repeats: true)
        }
    func resetTimer() {
            timer?.invalidate()
            timer = nil
            progressBar.progress = 0.0
        }

    @objc func updateProgress() {
           guard let player = player else { return }
           let progress = Float(player.currentTime / player.duration)
           progressBar.progress = progress

           if progress >= 1.0 {
               // Lagu selesai, mungkin pindah ke lagu berikutnya
               resetTimer()
           }
       }
    func setupSearch(){
        searchButton.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
    }
    @objc func searchButtonTapped() {
        // Memeriksa apakah textField memiliki teks
        guard let searchTerm = searchField.text, !searchTerm.isEmpty else {
            // Tampilkan pesan atau lakukan tindakan lain jika pencarian kosong
            print("Pencarian kosong")
            return
        }
        performSearch(with: searchTerm)
    }
    func performSearch(with searchTerm: String) {
        if searchTerm.isEmpty {
            // Jika pencarian kosong, tampilkan semua data
            filteredData = soundModel
        } else {
            filteredData = soundModel.filter { sound in
                return sound.name.lowercased().contains(searchTerm.lowercased()) ||
                String(sound.id).contains(searchTerm)
            }
        }
        
        tableSound.reloadData()
    }
    
}


extension SoundAnVC: UITableViewDelegate, UITableViewDataSource, AVAudioPlayerDelegate{
    func delegateTable(){
        tableSound.delegate = self
        tableSound.dataSource = self
        tableSound.registerCellWithNib(SoundTableViewCell.self)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableSound.dequeueReusableCell(withIdentifier: "SoundTableViewCell", for: indexPath) as! SoundTableViewCell
        let currentSound = filteredData[indexPath.row]
        
        cell.labelSoundVC?.text = currentSound.name
        cell.imageSound?.image = UIImage(named: filteredData[indexPath.row].imageName)
        cell.downloadButton.tag = indexPath.row
        cell.downloadButton.addTarget(self, action: #selector(downloadButtonTapped(_:)), for: .touchUpInside)
        
        return cell
    }
    
    //    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
    //        // Lagu selesai diputar, ganti ikon tombol play di dalam sel tabel
    //        if let currentPlayingSound = currentPlayingSound,
    //           let indexPaths = tableSound.indexPathsForVisibleRows {
    //            for indexPath in indexPaths {
    //                if let cell = tableSound.cellForRow(at: indexPath) as? SoundTableViewCell,
    //                   cell.sound == currentPlayingSound {
    //                    cell.playButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
    //                    cell.playButton.tintColor = UIColor.systemGreen
    //                    cell.playButton.isSelected = false
    //                    break
    //                }
    //            }
    //        }
    //        currentPlayingSound = nil
    //    }
    //
    
    
    @objc func downloadButtonTapped(_ sender: UIButton) {
        let selectedSound = soundModel[sender.tag]
        downloadSound(selectedSound)
    }
    // Menggunakan URLSession untuk mengunduh file
    func downloadSound(_ soundModel: SoundAnVcModel) {
        guard let url = URL(string: "Cheetah5") else {
            // Menampilkan pesan kesalahan dengan UIAlertController
            showAlert(title: "Eror", message: "Song URL Is Not Valid")
            return
        }
        
        let task = URLSession.shared.downloadTask(with: url) { (tempURL, response, error) in
            if let tempURL = tempURL {
                do {
                    // Menyimpan file unduhan ke direktori Documents
                    let documentsURL = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
                    let destinationURL = documentsURL.appendingPathComponent("\(soundModel.name).mp3")
                    try FileManager.default.moveItem(at: tempURL, to: destinationURL)
                    
                    // Update UI di dalam thread utama karena UI harus diperbarui di thread utama
                    DispatchQueue.main.async {
                        // Memberi tahu pengguna bahwa unduhan berhasil
                        print("Download Success: \(destinationURL.path)")
                    }
                } catch {
                    // Menangani kesalahan penyimpanan file
                    print("Eror When Saving File: \(error.localizedDescription)")
                    // Menampilkan pesan kesalahan dengan UIAlertController
                    self.showAlert(title: "Eror When Saving File", message: "Eror When Saving File: \(error.localizedDescription)")
                }
            } else {
                // Menangani kesalahan unduhan
                print("Download Eror: \(error?.localizedDescription ?? "Unknown Error")")
                // Menampilkan pesan kesalahan dengan UIAlertController
                self.showAlert(title: "Eror", message: "Download Eror: \(error?.localizedDescription ?? "Unknown Error")")
            }
        }
        
        // Memulai unduhan
        task.resume()
    }
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        // Menambahkan aksi (button) untuk menutup alert
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        
        // Menampilkan alert
        DispatchQueue.main.async {
            self.present(alertController, animated: true, completion: nil)
        }
    }
}

