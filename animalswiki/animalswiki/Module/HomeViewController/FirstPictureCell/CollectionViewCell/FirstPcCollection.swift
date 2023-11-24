//
//  FirstPcCollection.swift
//  animalswiki
//
//  Created by Phincon on 20/11/23.
//

import UIKit

class FirstPcCollection: UICollectionViewCell {

    @IBOutlet weak var imageViewFirst: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        imageViewFirst.layer.cornerRadius = 15.0
    }

}
