import UIKit
import AVFoundation

class SoundAnVC: UIViewController {
    var soundModel : [SoundAnVcModel] = []
    var currentPlayingSound: SoundAnVcModel?
    var playerLayer = AVPlayerLayer()
    public var player: AVAudioPlayer!
    @IBOutlet weak var tableSound: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        soundModel = SoundAnVcModel.sampleData
        delegateTable()
        avVideo()
    }
    func playSound(soundName: String) {
        if let url = Bundle.main.url(forResource: soundName, withExtension: "mp3") {
            do {
                player = try AVAudioPlayer(contentsOf: url)
                player?.play()
            } catch {
                print("Error playing audio: \(error.localizedDescription)")
            }
        } else {
            print("Sound file not found.")
        }
    }
    func avVideo() {
            guard let videoURL = URL(string: "https://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4") else {
                // URL video tidak valid, tampilkan pesan kesalahan atau lakukan tindakan lainnya
                print("URL video tidak valid")
                return
            }

            let player = AVPlayer(url: videoURL)
            playerLayer = AVPlayerLayer(player: player)
            playerLayer.frame = self.view.bounds
            playerLayer.videoGravity = .resizeAspect
            self.view.layer.addSublayer(playerLayer)

            // Tambahkan observer untuk mendeteksi saat video selesai diputar
            NotificationCenter.default.addObserver(self, selector: #selector(videoDidFinish), name: .AVPlayerItemDidPlayToEndTime, object: player.currentItem)

            player.play()
        }

        @objc func videoDidFinish(notification: Notification) {
            // Video selesai diputar, lakukan tindakan sesuai kebutuhan
            print("Video selesai diputar")
        }

        deinit {
            // Hapus observer saat objek dihapus
            NotificationCenter.default.removeObserver(self)
        }
    }

extension SoundAnVC: UITableViewDelegate, UITableViewDataSource, AVAudioPlayerDelegate{
    func delegateTable(){
        tableSound.delegate = self
        tableSound.dataSource = self
        tableSound.registerCellWithNib(SoundTableViewCell.self)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return soundModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableSound.dequeueReusableCell(withIdentifier: "SoundTableViewCell", for: indexPath) as! SoundTableViewCell
        let currentSound = soundModel[indexPath.row]
        
        cell.labelSoundVC?.text = currentSound.name
        cell.imageSound?.image = UIImage(named: soundModel[indexPath.row].imageName)
        cell.playButton.tag = indexPath.row
        cell.playButton.addTarget(self, action: #selector(playButtonTapped(_:)), for: .touchUpInside)
        cell.downloadButton.tag = indexPath.row
        cell.downloadButton.addTarget(self, action: #selector(downloadButtonTapped(_:)), for: .touchUpInside)
        
        return cell
    }
    @objc func playButtonTapped(_ sender: UIButton) {
        let selectedSound = soundModel[sender.tag]
        if sender.isSelected {
            // Saat tombol diubah menjadi stop
            sender.setImage(UIImage(systemName: "play.fill"), for: .normal)
            sender.tintColor = UIColor.systemGreen
            sender.isSelected = false
            stopSound()
        } else {
            // Saat tombol diubah menjadi play
            sender.setImage(UIImage(systemName: "stop.fill"), for: .normal)
            sender.tintColor = UIColor.red
            sender.isSelected = true
            playSound(soundName: selectedSound.sound)
        }
        
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
    func stopSound(){
        if let player = player, player.isPlaying{
            player.stop()
            player.delegate = self
            
        }
    }
}

