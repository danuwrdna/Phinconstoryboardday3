
import UIKit
struct SoundAnVcModel {
    let name: String
    let imageName: String
    let sound: String
}

extension SoundAnVcModel {
    static var sampleData: [SoundAnVcModel] {
        return [
            SoundAnVcModel(name:"Cheetah",imageName: "cheetah", sound: "Cheetah5"),
            SoundAnVcModel(name:"Lion", imageName: "lion", sound: "lion"),
            SoundAnVcModel(name:"Jaguar", imageName: "jaguar", sound: "JAGUARS"),
            SoundAnVcModel(name:"Wolf", imageName: "wolf", sound: "wolf"),
        ]
    }
}
