import Foundation
import UIKit

struct ProfileModel {
    let imageProfile: String
    let title: String
    let subTitle: String
}

var miningModel = [ProfileModel]()

extension ProfileModel {
    static func configure() {
        miningModel = [
            ProfileModel(imageProfile: "Group12334", title: "aaa", subTitle: "aaaaa"),
            ProfileModel(imageProfile: "Group12334", title: "aaa", subTitle: "aaaaa"),
            ProfileModel(imageProfile: "Group12334-2", title: "aaa", subTitle: "aaaaa"),
            ProfileModel(imageProfile: "Group12334-3", title: "aaa", subTitle: "aaaaa"),
            ProfileModel(imageProfile: "Group12334-4", title: "aaa", subTitle: "aaaaa")
            
        ]
    }
}


