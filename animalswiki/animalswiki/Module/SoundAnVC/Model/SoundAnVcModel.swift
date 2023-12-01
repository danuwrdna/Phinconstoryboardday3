
import UIKit
struct SoundAnVcModel {
    let id: Int
    let name: String
    let imageName: String
    let sound: String
}

extension SoundAnVcModel {
    static var sampleData: [SoundAnVcModel] {
        return [
            SoundAnVcModel(id: 0, name:"Cheetah",imageName: "cheetah", sound: "Cheetah5"),
            SoundAnVcModel(id: 1, name:"Lion", imageName: "lion", sound: "lion"),
            SoundAnVcModel(id: 2, name:"Jaguar", imageName: "jaguar", sound: "JAGUARS"),
            SoundAnVcModel(id: 3, name:"Wolf", imageName: "wolf", sound: "wolf"),
        ]
    }
}
