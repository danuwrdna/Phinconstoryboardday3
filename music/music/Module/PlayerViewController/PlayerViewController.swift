//import UIKit
//import AVFoundation
//
//class PlayerViewController: UIViewController {
//    @IBOutlet weak var holder: UIView!
//    var player = AVAudioPlayer?(nil)
//
//    public var position: Int = 0
//    public var songs: [Song] = []
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//    }
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        if holder.subviews.count == 0{
//            configure()
//        }
//    }
//    func configure(){
//        let song = songs[position]
//        let urlString = Bundle.main.path(forResource: song.trackName, ofType: "Mp3")
//        do{
//            try AVAudioSession.sharedInstance().setMode(.default)
//            try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
//
//            guard let urlString = urlString else{
//                print("url string is nill")
//                return
//            }
//            player = try AVAudioPlayer(contentsOf: URL(string: urlString)!)
//            guard let player = player else{
//                print("player is nill")
//                return
//            }
//            player.play ()
//        }
//        catch{
//            print("Eror Occured")
//        }
//    }
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        if let player = player{
//            player.stop()
//        }
//    }
//
//    func playSound(soundName: String){
//        let url = Bundle.main.url(forResource: soundName, withExtension: "mp3")
//        player = try! AVAudioPlayer(contentsOf: url!)
//        player!.play()
//    }
//}
