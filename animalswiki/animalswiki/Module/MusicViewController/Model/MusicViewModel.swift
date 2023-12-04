
import Foundation
import UIKit

struct MusicViewModel {
    let id: Int
    let title: String
    let subTitle: String
    let imageName: String
    let sound: String
}
extension MusicViewModel{
    
    static var sampleData: [MusicViewModel] {
        return [
            MusicViewModel(id: 0, title:"Coldplay",subTitle:"The Scientist",imageName: "coldplay", sound: "coldplay"),
            MusicViewModel(id: 1, title:"Oasis",subTitle:"Stand By Me",imageName: "oasis", sound: "oasis"),
            MusicViewModel(id: 2, title:"Slank",subTitle:"Terlalu Manis",imageName: "slank", sound: "slank"),
            MusicViewModel(id: 3, title:"Peterpan",subTitle:"Semua Tentang Kita",imageName: "peterpan", sound: "peterpan"),
        ]
    }
}
