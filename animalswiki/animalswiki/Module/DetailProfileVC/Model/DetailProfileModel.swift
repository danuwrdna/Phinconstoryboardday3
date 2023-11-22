import UIKit

struct DetailProfileModel {
    let imageName: String
    let height: CGFloat
}

extension DetailProfileModel {
    static var sampleData: [DetailProfileModel] {
        return [
            DetailProfileModel(imageName: "vc1", height: 100),
            DetailProfileModel(imageName: "vc2", height: 100),
            DetailProfileModel(imageName: "vc3", height: 100),
            DetailProfileModel(imageName: "vc4", height: 100),
        ]
    }
}
