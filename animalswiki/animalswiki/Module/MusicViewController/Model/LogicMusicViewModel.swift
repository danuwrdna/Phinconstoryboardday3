import Foundation
import AVFoundation
import CoreData
import UIKit
class LogicMusicViewModel: NSObject{
    private var viewController = MusicViewController()
    private var model = ApiSearchModel()
    private var modelDatum: [Datum] = []
    private var modelPlaylist: [Music] = []
    private var player: AVPlayer?
    private var playerItem: AVPlayerItem?
    private var timer: Timer?
    private var isPlaying = false
    private var playbackTime: Double = 0.0
    var sectionIndexTitles: [String] {
      
        return ["Listen Your Way"]
    }
    
    init(viewController: MusicViewController) {
        self.viewController = viewController
        
    }
}
extension LogicMusicViewModel: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Listen Your Way"
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return modelDatum.count
    }
    func numberOfRows(in section: Int) -> Int {
        return modelDatum.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = viewController.tableMusic.dequeueReusableCell(withIdentifier: "MusicTableViewCell", for: indexPath) as! MusicTableViewCell
        configureCell(cell, at: indexPath)
        return cell
    }
    func configureCell(_ cell: MusicTableViewCell, at indexPath: IndexPath) {
        let deezerTrack = modelDatum[indexPath.row]
        cell.titleLabel?.text = deezerTrack.artist?.name?.stringValue
        cell.subTitleLabel?.text = deezerTrack.title
        if let imageUrl = deezerTrack.album?.cover {
            let url = URL(string: imageUrl)
            cell.imgView?.kf.setImage(with: url)
        } else {
            cell.imgView?.image = UIImage(named: "placeholderImage")
        }
    }
    func updateCell(at indexPath: IndexPath) {
        if let cell = viewController.tableMusic.cellForRow(at: indexPath) as? MusicTableViewCell {
            configureCell(cell, at: indexPath)
        }
    }
}
extension LogicMusicViewModel{
    func progress(){
        let gestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture(_:)))
        viewController.progressBar.progress = 0.0
        viewController.progressBar.addGestureRecognizer(tapGestureRecognizer)
        viewController.progressBar.addGestureRecognizer(gestureRecognizer)
    }
    @objc func handlePanGesture(_ sender: UIPanGestureRecognizer) {
        guard let player = player else { return }
        switch sender.state {
        case .began:
            break
        case .changed:
            handlePanChanged(sender, player: player)
        case .ended:
            break
        default:
            break
        }
    }
    @objc func handleTapGesture(_ sender: UITapGestureRecognizer) {
        guard let player = player else { return }
        let location = sender.location(in: viewController.progressBar)
        let progressBarWidth = viewController.progressBar.bounds.width
        let percentage = Float(location.x / progressBarWidth)
        let duration = player.currentItem?.asset.duration.seconds ?? 1.0
        let newTime = max(0, min(Double(percentage) * duration, duration))
        player.seek(to: CMTime(seconds: newTime, preferredTimescale: 1000))
        viewController.progressBar.progress = Float(newTime / duration)
        viewController.startLabel.text = formattedTime(time: newTime)
    }
    
    func handlePanChanged(_ sender: UIPanGestureRecognizer, player: AVPlayer) {
        let translation = sender.translation(in: viewController.progressBar)
        let progressBarWidth = viewController.progressBar.bounds.width
        let percentage = Float(translation.x / progressBarWidth)
        let currentTime = player.currentTime().seconds
        let duration = player.currentItem?.asset.duration.seconds ?? 1.0
        let newTime = max(0, min(currentTime + Double(percentage) * duration, duration))
        player.seek(to: CMTime(seconds: newTime, preferredTimescale: 1000))
        viewController.progressBar.progress = Float(newTime / duration)
        viewController.startLabel.text = formattedTime(time: newTime)
    }
    
}

extension LogicMusicViewModel{
    func playPause() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        viewController.playPauseButton.addGestureRecognizer(tapGesture)
        viewController.playPauseButton.isUserInteractionEnabled = true
        
        let defaultImage = UIImage(systemName: isPlaying ? "pause.fill" : "play.fill")
        viewController.playPauseButton.setImage(defaultImage, for: .normal)
    }
    @objc func imageTapped() {
        playy()
    }
    func playy() {
        viewController.viewHome.isHidden = false
        print("play sudah terpanggil")
        
        guard let selectedIndexPath = viewController.tableMusic.indexPathForSelectedRow else {
            return
            
        }
        let selectedSound = modelDatum[selectedIndexPath.row]
        viewController.headLabel.text = selectedSound.artist?.name?.stringValue
        viewController.subHeadLabel.text = selectedSound.title
        if let coverURLString = selectedSound.album?.cover,
           let coverURL = URL(string: coverURLString) {
            viewController.imgAB.kf.setImage(with: coverURL)
        } else {
            viewController.imgAB.image = UIImage(named: "placeholderImage")
        }
        if let player = player {
            if player.rate > 0 {
                saveMusicToCoreData(title: selectedSound.artist?.name?.stringValue, subtitle: selectedSound.title, image: selectedSound.album?.cover)
                print("Lagu sedang diputar, di-pause")
                pauseMusic()
                
            } else {
                print("Lagu di-pause, dilanjutkan pemutaran")
                resumeMusic()
                if let selectedIndexPath = viewController.tableMusic.indexPathForSelectedRow {
                    let selectedSound = modelDatum[selectedIndexPath.row]
                    if let selectedPreview = selectedSound.preview, !selectedPreview.isEmpty {
                        print("Memutar lagu baru")
                        playSnd(soundName: selectedPreview, startTime: playbackTime)
                        
                    } else {
                        print("URL preview tidak tersedia")
                    }
                } else {
                    print("Tidak ada lagu yang dipilih")
                }
            }
        } else {
            print("Player nil, inisialisasi dan putar lagu yang sedang dipilih")
            resumeMusic()
            if let selectedIndexPath = viewController.tableMusic.indexPathForSelectedRow {
                let selectedSound = modelDatum[selectedIndexPath.row]
                if let selectedPreview = selectedSound.preview, !selectedPreview.isEmpty {
                    print("Memutar lagu baru")
                    playSnd(soundName: selectedPreview, startTime: playbackTime)
                } else {
                    print("URL preview tidak tersedia")
                }
            } else {
                print("Tidak ada lagu yang dipilih")
            }
        }
        isPlaying = player?.rate ?? 0 > 0
        stateReset()
    }
    
    func saveMusicToCoreData(title: String?, subtitle: String?, image: String?) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Music", in: context)
        let music = NSManagedObject(entity: entity!, insertInto: context)
        
        music.setValue(title, forKey: "title")
        music.setValue(subtitle, forKey: "subtitle")
        music.setValue(image, forKey: "image")
        
        do {
            try context.save()
            print("Data berhasil disimpan di Core Data.")
        } catch {
            fatalError("Gagal menyimpan data ke Core Data: \(error)")
        }
    }
    
    func playMusic() {
        player?.play()
        setPlayPauseImage(isPlaying: true)
        startTimer()
    }
    
    func pauseMusic() {
        player?.pause()
        setPlayPauseImage(isPlaying: false)
        resetTimer()
        savePlaybackTime()
    }
    
    func resumeMusic() {
        isPlaying = true
        setPlayPauseImage(isPlaying: true)
    }
    
    func savePlaybackTime() {
        if let player = player {
            playbackTime = player.currentTime().seconds
        }
    }
    
    func setPlayPauseImage(isPlaying: Bool) {
        print("pause sudah di panggil")
        let imageName = isPlaying ? "pause.fill" : "play.fill"
        let image = UIImage(systemName: imageName)
        viewController.playPauseButton.setImage(image, for: .normal)
    }
    
    func playSnd(soundName: String, startTime: Double) {
        guard let url = URL(string: soundName) else {
            print("Invalid URL.")
            return
        }
        playerItem = AVPlayerItem(url: url)
        player = AVPlayer(playerItem: playerItem)
        player?.seek(to: CMTime(seconds: startTime, preferredTimescale: 1000))
        playerItem?.addObserver(self, forKeyPath: #keyPath(AVPlayerItem.status), options: [.new], context: nil)
        player?.play()
        startTimer()
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateProgress), userInfo: nil, repeats: true)
    }
    
    @objc func updateProgress() {
        guard let player = player else { return }
        let currentTime = player.currentTime().seconds
        let duration = player.currentItem?.asset.duration.seconds ?? 1.0
        let progress = Float(currentTime / duration)
        viewController.progressBar.progress = progress
        viewController.startLabel.text = formattedTime(time: currentTime)
        if progress >= 1.0 {
            resetTimer()
        }
    }
    
    func resetTimer() {
        timer?.invalidate()
        timer = nil
        viewController.progressBar.progress = 0.0
    }
    
    func stateReset() {
        guard let selectedIndexPath = viewController.tableMusic.indexPathForSelectedRow else {
            playbackTime = 0.0
            return
        }
        
        let selectedSound = modelDatum[selectedIndexPath.row]
        if let player = player, let playerItem = player.currentItem {
            if let currentSoundURL = (playerItem.asset as? AVURLAsset)?.url {
                let selectedPreviewURLString = selectedSound.preview ?? ""
                
                if let selectedPreviewURL = URL(string: selectedPreviewURLString) {
                    if selectedPreviewURL == currentSoundURL {
                        playbackTime = player.currentTime().seconds
                    } else {
                        playbackTime = 0.0
                    }
                }
            } else {
                playbackTime = 0.0
            }
        }
    }
    
    func formattedTime(time: Double) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    @objc override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == #keyPath(AVPlayerItem.status) {
            if let statusNumber = change?[.newKey] as? NSNumber {
                let status = AVPlayerItem.Status(rawValue: statusNumber.intValue)
                switch status {
                case .readyToPlay:
                    print("AVPlayerItem ready to play")
                case .failed:
                    print("AVPlayerItem failed to load")
                case .unknown:
                    print("AVPlayerItem status unknown")
                @unknown default:
                    print("Unknown AVPlayerItem status")
                }
            }
        }
        else if keyPath == #keyPath(AVPlayerItem.duration) {
            if let duration = playerItem?.asset.duration.seconds, duration.isFinite {
                viewController.finishLabel.text = formattedTime(time: duration)
            }
        }
        
    }
}
extension LogicMusicViewModel{
    func nextBT() {
        guard let selectedIndexPath = viewController.tableMusic.indexPathForSelectedRow else {
            return
        }
        
        var newIndexPath: IndexPath
        if selectedIndexPath.row < modelDatum.count - 1 {
            newIndexPath = IndexPath(row: selectedIndexPath.row + 1, section: selectedIndexPath.section)
        } else {
            newIndexPath = IndexPath(row: 0, section: selectedIndexPath.section)
        }
        
        viewController.tableMusic.selectRow(at: newIndexPath, animated: true, scrollPosition: .none)
        viewController.tableView(viewController.tableMusic, didSelectRowAt: newIndexPath)
    }
    
    func previousBT() {
        guard let selectedIndexPath = viewController.tableMusic.indexPathForSelectedRow else {
            return
        }
        
        var newIndexPath: IndexPath
        if selectedIndexPath.row > 0 {
            newIndexPath = IndexPath(row: selectedIndexPath.row - 1, section: selectedIndexPath.section)
        } else {
            newIndexPath = IndexPath(row: modelDatum.count - 1, section: selectedIndexPath.section)
        }
        
        viewController.tableMusic.selectRow(at: newIndexPath, animated: true, scrollPosition: .none)
        viewController.tableView(viewController.tableMusic, didSelectRowAt: newIndexPath)
    }
}
extension LogicMusicViewModel: UITextFieldDelegate{
    func setupTextField(){
        viewController.searchField.delegate = self
    }
    func viewModel(searchTerm: String) {
        let musicViewModel = ApiSearchModel()
        musicViewModel.fetchData(for: searchTerm) { [weak self] searchResult in
            if let data = searchResult?.data {
                self?.modelDatum = data
                DispatchQueue.main.async {
                    self?.viewController.tableMusic.reloadData()
                }
            }
        }
        fetchDataFromCoreData()
    }
    func fetchDataFromCoreData() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext;     let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Music")
        
        do {
            let result = try context.fetch(fetchRequest)
            for data in result as! [NSManagedObject] {
                let title = data.value(forKey: "title") as? String ?? ""
                let subtitle = data.value(forKey: "subtitle") as? String ?? ""
                let image = data.value(forKey: "image") as? String ?? ""
                print("Title: \(title), Subtitle: \(subtitle), Image: \(image)")
            }
        } catch {
            fatalError("Gagal mengambil data dari Core Data: \(error)")
        }
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let updatedText = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) else {
            return true
        }
        if updatedText.isEmpty {
            displayAllData()
        } else {
            performSearch(with: updatedText)
            if viewController.tableMusic.numberOfRows(inSection: 0) > 0 {
                let indexPath = IndexPath(row: 0, section: 0)
                viewController.tableMusic.scrollToRow(at: indexPath, at: .top, animated: true)
            }
        }
        NotificationCenter.default.post(name: NSNotification.Name("TextFieldDidChange"), object: updatedText)
        return true
    }
    
    
    func displayAllData() {
        fetchDataFromCoreData()
        viewController.tableMusic.reloadData()
    }
    func performSearch(with searchTerm: String) {
        viewController.tableMusic.showSkeleton()
        model.fetchData(for: searchTerm) { [weak self] searchResult in
            if let data = searchResult?.data {
                self?.modelDatum = data
                DispatchQueue.main.async {
                    self?.viewController.tableMusic.hideSkeleton()
                    self?.viewController.tableMusic.reloadData()
                }
            }
        }
    }
}
extension LogicMusicViewModel: UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    func forBtCamera(){
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .camera
            imagePicker.allowsEditing = true
            viewController.present(imagePicker, animated: true, completion: nil)
        } else {
            print("Camera not available")
        }
    }
}
