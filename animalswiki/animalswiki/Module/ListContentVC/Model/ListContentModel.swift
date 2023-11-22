import UIKit

struct ListContentModel {
    let imageName: String
    let height: CGFloat
}

extension ListContentModel {
    static func sampleData() -> [ListContentModel] {
        let images = Array(1...6).map { "profile\($0)" }
        return images.enumerated().map { (index, value) in
            if index == 0 {
                return ListContentModel(imageName: value, height: 272)
            } else if index % 2 != 0 {
                return ListContentModel(imageName: value, height: 200)
            } else {
                return ListContentModel(imageName: value, height: 200)
            }
        }
    }
}
