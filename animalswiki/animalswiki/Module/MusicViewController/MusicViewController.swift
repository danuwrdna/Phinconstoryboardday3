import UIKit
import AVFoundation
class MusicViewController: UIViewController {
    var musicModel : [MusicViewModel] = []
    var player: AVPlayer?
    var playerItem: AVPlayerItem?
    var timer: Timer?
    var isPlaying = false
    var playbackTime: Double = 0.0
    @IBOutlet weak var startLabel: UILabel!
    @IBOutlet weak var finishLabel: UILabel!
    @IBOutlet weak var playPauseButton: UIButton!
    @IBOutlet weak var subHeadLabel: UILabel!
    @IBOutlet weak var headLabel: UILabel!
    @IBOutlet weak var imgAB: UIImageView!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var tableMusic: UITableView!
    
    @IBAction func nextButton(_ sender: UIButton) {
        nextBT()
    }
    
    @IBAction func previousButton(_ sender: UIButton) {
        previousBT()
    }
    
    @IBAction func categoryBT1(_ sender: UIButton) {
        
    }
    @IBOutlet weak var viewHome: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        delegateTable()
        musicModel = MusicViewModel.sampleData
        progress()
        playPause()
        border()
    }
}
extension MusicViewController{
    func progress(){
        let gestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture(_:)))
        progressBar.progress = 0.0
        progressBar.addGestureRecognizer(tapGestureRecognizer)
        progressBar.addGestureRecognizer(gestureRecognizer)
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
        let location = sender.location(in: progressBar)
        let progressBarWidth = progressBar.bounds.width
        let percentage = Float(location.x / progressBarWidth)
        let duration = player.currentItem?.asset.duration.seconds ?? 1.0
        let newTime = max(0, min(Double(percentage) * duration, duration))
        player.seek(to: CMTime(seconds: newTime, preferredTimescale: 1000))
        progressBar.progress = Float(newTime / duration)
        startLabel.text = formattedTime(time: newTime)
    }
    
    func handlePanChanged(_ sender: UIPanGestureRecognizer, player: AVPlayer) {
        let translation = sender.translation(in: progressBar)
        let progressBarWidth = progressBar.bounds.width
        let percentage = Float(translation.x / progressBarWidth)
        let currentTime = player.currentTime().seconds
        let duration = player.currentItem?.asset.duration.seconds ?? 1.0
        let newTime = max(0, min(currentTime + Double(percentage) * duration, duration))
        player.seek(to: CMTime(seconds: newTime, preferredTimescale: 1000))
        progressBar.progress = Float(newTime / duration)
        startLabel.text = formattedTime(time: newTime)
    }
    
}
extension MusicViewController: UITableViewDelegate, UITableViewDataSource{
    func delegateTable(){
        tableMusic.delegate = self
        tableMusic.dataSource = self
        tableMusic.registerCellWithNib(MusicTableViewCell.self)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return musicModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableMusic.dequeueReusableCell(withIdentifier: "MusicTableViewCell", for: indexPath) as! MusicTableViewCell
        configureCell(cell, at: indexPath)
        return cell
    }
    
    func configureCell(_ cell: MusicTableViewCell, at indexPath: IndexPath) {
        let msModel = musicModel[indexPath.row]
        cell.titleLabel?.text = msModel.title
        cell.subTitleLabel?.text = msModel.subTitle
        cell.imgView?.image = UIImage(named: msModel.imageName)
    }
    func updateCell(at indexPath: IndexPath) {
        if let cell = tableMusic.cellForRow(at: indexPath) as? MusicTableViewCell {
            configureCell(cell, at: indexPath)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        playy()
    }
}

extension MusicViewController {
    func playPause(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        playPauseButton.addGestureRecognizer(tapGesture)
        playPauseButton.isUserInteractionEnabled = true
        
        let defaultImage = UIImage(systemName: isPlaying ? "pause.fill" : "play.fill")
        playPauseButton.setImage(defaultImage, for: .normal)
    }
    @objc func imageTapped() {
        playy()
    }
    func playy() {
        print("play sudah terpanggil")
        guard let selectedIndexPath = tableMusic.indexPathForSelectedRow else {
            return
        }
        
        let selectedSound = musicModel[selectedIndexPath.row]
        headLabel.text = selectedSound.title
        subHeadLabel.text = selectedSound.subTitle
        imgAB.image = UIImage(named: selectedSound.imageName)
        
        
        if let player = player {
            if player.rate > 0 {
                print("lgi di pause musiknya")
                pauseMusic()
                
            } else {
                print("lgi di putar musiknya")
                resumeMusic()
                playSnd(soundName: selectedSound.sound, startTime: playbackTime)
                
            }
        } else {
            print("nil")
            
            resumeMusic()
            playSnd(soundName: selectedSound.sound, startTime: playbackTime)
            
        }
        isPlaying = player?.rate ?? 0 > 0
        stateReset()
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
        playPauseButton.setImage(image, for: .normal)
    }
    
    func playSnd(soundName: String, startTime: Double) {
        guard let url = Bundle.main.url(forResource: soundName, withExtension: "mp3") else {
            print("Sound file not found.")
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
        progressBar.progress = progress
        startLabel.text = formattedTime(time: currentTime)
        if progress >= 1.0 {
            resetTimer()
        }
    }
    
    func resetTimer() {
        timer?.invalidate()
        timer = nil
        progressBar.progress = 0.0
        
    }
    func stateReset(){
        if let selectedIndexPath = tableMusic.indexPathForSelectedRow {
            let selectedSound = musicModel[selectedIndexPath.row]
            // Periksa apakah trek yang dipilih sama dengan yang sedang diputar
            if let player = player, let playerItem = player.currentItem, let url = Bundle.main.url(forResource: selectedSound.sound, withExtension: "mp3"), let currentSoundURL = (playerItem.asset as? AVURLAsset)?.url {
                if url == currentSoundURL {
                    // Jika trek yang dipilih sama dengan yang sedang diputar, gunakan waktu saat ini
                    playbackTime = player.currentTime().seconds
                } else {
                    // Jika trek yang dipilih berbeda, atur waktu putar ulang ke 0.0
                    playbackTime = 0.0
                }
            } else {
                // Jika tidak ada trek yang diputar, atur waktu putar ulang ke 0.0
                playbackTime = 0.0
            }
        }
    }
    func formattedTime(time: Double) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
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
                finishLabel.text = formattedTime(time: duration)
            }
        }
        
    }
}
extension MusicViewController{
    func nextBT(){
        guard let selectedIndexPath = tableMusic.indexPathForSelectedRow else {
            return
        }
        var newIndexPath: IndexPath
        if selectedIndexPath.row < musicModel.count - 1 {
            newIndexPath = IndexPath(row: selectedIndexPath.row + 1, section: selectedIndexPath.section)
        } else {
            newIndexPath = IndexPath(row: 0, section: selectedIndexPath.section)
        }
        tableMusic.deselectRow(at: selectedIndexPath, animated: true)
        tableMusic.selectRow(at: newIndexPath, animated: true, scrollPosition: .none)
        tableView(tableMusic, didSelectRowAt: newIndexPath)
    }
    func previousBT(){
        guard let selectedIndexPath = tableMusic.indexPathForSelectedRow else {
            return
        }
        
        var newIndexPath: IndexPath
        if selectedIndexPath.row > 0 {
            newIndexPath = IndexPath(row: selectedIndexPath.row - 1, section: selectedIndexPath.section)
        } else {
            newIndexPath = IndexPath(row: musicModel.count - 1, section: selectedIndexPath.section)
        }
        tableMusic.deselectRow(at: selectedIndexPath, animated: true)
        tableMusic.selectRow(at: newIndexPath, animated: true, scrollPosition: .none)
        tableView(tableMusic, didSelectRowAt: newIndexPath)
    }
}

extension MusicViewController{
    func border(){
        imgAB.layer.cornerRadius = 16
        viewHome.layer.cornerRadius = 16
        viewHome.layer.masksToBounds = false
        viewHome.layer.shadowColor = UIColor.black.cgColor
        viewHome.layer.shadowOpacity = 0.5
        viewHome.layer.shadowOffset = CGSize(width: 0, height: 2)
        viewHome.layer.shadowRadius = 4.0
        viewHome.layer.shouldRasterize = true
        viewHome.layer.rasterizationScale = UIScreen.main.scale
        
    }
}
