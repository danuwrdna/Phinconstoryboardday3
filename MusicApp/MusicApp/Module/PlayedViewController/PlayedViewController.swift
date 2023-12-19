import UIKit
import AVFoundation
class PlayedViewController: UIViewController {
    
    private var image: String = ""
    private var headPlayed: String = ""
    private var titlePlayed: String = ""
    private var subTitlePlayed: String = ""
    private var trackPreview: String = ""
    var timer: Timer?
    var isAnimating = false
    var isPlaying = false
    var playbackTime: Double = 0.0
    var audioItem: AVPlayerItem?
    var audioPlayer: AVPlayer?
    var track: String = ""
    var trackList : [Datum] = []
  
    @IBAction func btBack(_ sender: Any) {
        navigate()
    }
    @IBOutlet weak var btPlay: UIButton!
    @IBOutlet weak var progressMusicView: UIProgressView!
    
    @IBAction func backBtPlaylist(_ sender: Any) {
        previousMusic()
    }
    
    @IBAction func nextBtPlaylist(_ sender: Any) {
        nextMusic()
    }
    @IBOutlet weak var labelHeadPlayed: UILabel!
    @IBOutlet weak var labelTitlePlayed: UILabel!
    @IBOutlet weak var labelSubTitlePlayed: UILabel!
    @IBOutlet weak var imgPlayed: UIImageView!
    @IBOutlet weak var durationLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupDesign()
        setupAudio()
        
        progress()
        playPause()
        animateIng()
        border()
    }
    override func viewDidAppear(_ animated: Bool) {
        setupAudio()
        playPause()
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        stopAudio()
    }
}
extension PlayedViewController{
    func setImage(image: String,head : String,title: String, subTitle: String, trackPreview: String) {
        self.image = image
        self.headPlayed = head
        self.titlePlayed = title
        self.subTitlePlayed = subTitle
        self.trackPreview = trackPreview
    
    }
    
    func setupUI() {
        let url = URL(string: self.image)
        imgPlayed.kf.setImage(with: url)
        labelHeadPlayed.text = headPlayed
        labelTitlePlayed.text = titlePlayed
        labelSubTitlePlayed.text = subTitlePlayed
        track = trackPreview
    }
}
extension PlayedViewController{
    func navigate(){
        navigationController?.popViewController(animated: true)
    }
}
extension PlayedViewController{
    func setupDesign(){
        imgPlayed.layer.cornerRadius = 16
        imgPlayed.layer.masksToBounds = false
        imgPlayed.layer.shadowColor = UIColor.black.cgColor
        imgPlayed.layer.shadowOpacity = 0.5
        imgPlayed.layer.shadowOffset = CGSize(width: 0, height: 2)
        imgPlayed.layer.shadowRadius = 4.0
        imgPlayed.layer.shouldRasterize = true
        imgPlayed.layer.rasterizationScale = UIScreen.main.scale
        
    }
}
extension PlayedViewController{
    func formattedTime(time: Double) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    func progress(){
        let gestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture(_:)))
        progressMusicView.progress = 0.0
        progressMusicView.addGestureRecognizer(tapGestureRecognizer)
        progressMusicView.addGestureRecognizer(gestureRecognizer)
    }
    @objc func handlePanGesture(_ sender: UIPanGestureRecognizer) {
        guard let player = audioPlayer else { return }
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
        guard let player = audioPlayer else { return }
        let location = sender.location(in: progressMusicView)
        let progressBarWidth = progressMusicView.bounds.width
        let percentage = Float(location.x / progressBarWidth)
        let duration = player.currentItem?.asset.duration.seconds ?? 1.0
        let newTime = max(0, min(Double(percentage) * duration, duration))
        player.seek(to: CMTime(seconds: newTime, preferredTimescale: 1000))
        progressMusicView.progress = Float(newTime / duration)
        durationLabel.text = formattedTime(time: newTime)
    }
    
    func handlePanChanged(_ sender: UIPanGestureRecognizer, player: AVPlayer) {
        let translation = sender.translation(in: progressMusicView)
        let progressBarWidth = progressMusicView.bounds.width
        let percentage = Float(translation.x / progressBarWidth)
        let currentTime = player.currentTime().seconds
        let duration = player.currentItem?.asset.duration.seconds ?? 1.0
        let newTime = max(0, min(currentTime + Double(percentage) * duration, duration))
        player.seek(to: CMTime(seconds: newTime, preferredTimescale: 1000))
        progressMusicView.progress = Float(newTime / duration)
        durationLabel.text = formattedTime(time: newTime)
    }
    
}
extension PlayedViewController{
    func setupAudio() {
        let audio = track
        guard let audioFileURL = URL(string: audio) else {
            print("Invalid audio file URL.")
            return
        }
        do{
            try AVAudioSession.sharedInstance().setCategory(.playback)
            try AVAudioSession.sharedInstance().setMode(.default)
            try AVAudioSession.sharedInstance().setActive(true)
            audioItem = AVPlayerItem(url: audioFileURL)
            audioPlayer = AVPlayer(playerItem: audioItem)
            
            audioPlayer?.play()
            isPlaying = true
            startTimer()
            updatePlayPauseButton()
            if !isAnimating {
                animateIng()
            }
        }catch{
            print("eror")
        }
    }
}
extension PlayedViewController{
    
    
    
}
extension PlayedViewController{
    func playPause() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        btPlay.addGestureRecognizer(tapGesture)
        btPlay.isUserInteractionEnabled = true
        
        updatePlayPauseButton()
    }
    @objc func imageTapped() {
        if isPlaying {
            pauseAudio()
        } else {
            setupAudio()
        }
    }
}
extension PlayedViewController{
    func pauseAudio() {
        audioPlayer?.pause()
        pauseTimer()
        isPlaying = false
        updatePlayPauseButton()
    }
    
    func stopAudio() {
        audioPlayer?.pause()
        audioPlayer = nil
        audioItem = nil
        stopTimer()
        isPlaying = false
        updatePlayPauseButton()
    }
    
    func updatePlayPauseButton() {
        let defaultImage = UIImage(systemName: isPlaying ? "pause.fill" : "play.fill")
        btPlay.setImage(defaultImage, for: .normal)
    }
    
    func pauseTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
        progressMusicView.progress = 0.0
        durationLabel.text = formattedTime(time: 0.0)
    }
    
}
extension PlayedViewController{
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateProgress), userInfo: nil, repeats: true)
    }
    
    @objc func updateProgress() {
        guard let player = audioPlayer else { return }
        let currentTime = player.currentTime().seconds
        let duration = player.currentItem?.asset.duration.seconds ?? 1.0
        let progress = Float(currentTime / duration)
        progressMusicView.progress = progress
        durationLabel.text = formattedTime(time: currentTime)
        if progress >= 1.0 {
            resetTimer()
        }
    }
    
    func resetTimer() {
        timer?.invalidate()
        timer = nil
        progressMusicView.progress = 0.0
        
    }
}

extension PlayedViewController {
    func nextMusic() {
//        if position < (track.count - 1){
//            position = position + 1
//            audioPlayer?.pause()
//        }
//        audioPlayer?.pause()
    }
    
    func previousMusic() {
//        if position > 0{
//            position = position - 1
//            audioPlayer?.pause()
//        }
//        setupAudio(at: position)
        
    }
    

    
}


extension PlayedViewController{
    func animateIng() {
        guard isPlaying else {
            isAnimating = false
            return
        }
        
        UIView.animate(withDuration: 2.0, delay: 0, options: .curveLinear, animations: {
            self.imgPlayed.transform = self.imgPlayed.transform.rotated(by: .pi)
        }) { _ in
            self.animateIng()
        }
        isAnimating = true
    }
    func border(){
        imgPlayed.layer.masksToBounds = false
        imgPlayed.layer.shadowRadius = 10
        imgPlayed.layer.shadowColor = UIColor.black.cgColor
        imgPlayed.layer.shadowOffset =  CGSize(width: 0, height: 2)
        imgPlayed.layer.shadowOpacity = 0.5
        imgPlayed.layer.cornerRadius = imgPlayed.frame.height / 2
        imgPlayed.clipsToBounds = true
        
    }
}
