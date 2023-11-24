//
//  SecondPcCollection.swift
//  animalswiki
//
//  Created by Phincon on 20/11/23.
//

import UIKit

class SecondPcCollection: UICollectionViewCell {
    @IBOutlet weak var imageSecond: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        imageSecond.layer.cornerRadius = 15.0
    }

}

