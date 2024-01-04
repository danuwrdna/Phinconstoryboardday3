//
//  RecentlyPlayedCell.swift
//  MusicApp
//
//  Created by Phincon on 03/01/24.
//

import UIKit
import CoreData

protocol RecentlyPlayedViewCellDelegate {
    func didSelectItemAt(subTitle: String)
}

class RecentlyPlayedCell: UITableViewCell {
    
    @IBOutlet var recentlyPlayedCollectionView: UICollectionView!
   
    private var coreDataArray: [Music] = [] {
            didSet {
                if coreDataArray.isEmpty {
                    recentlyPlayedCollectionView.isHidden = true
                    self.isHidden = true
                } else {
                    recentlyPlayedCollectionView.isHidden = false
                    recentlyPlayedCollectionView.reloadData()
                    self.isHidden = false
                }
            }
        }
    
    var data: [Music] = []
    var didSelectItem: ((Music) -> Void)?
    var delegate: RecentlyPlayedViewCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        delegateCollection()

    }
}
extension RecentlyPlayedCell: UICollectionViewDelegate, UICollectionViewDataSource{
    func delegateCollection(){
        recentlyPlayedCollectionView.delegate = self
        recentlyPlayedCollectionView.dataSource = self
        recentlyPlayedCollectionView.registerCellWithNib(RecentlyPlayedViewCollection.self)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return coreDataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = recentlyPlayedCollectionView.dequeueReusableCell(withReuseIdentifier: "RecentlyPlayedViewCollection", for: indexPath) as! RecentlyPlayedViewCollection
        let datum = coreDataArray[indexPath.item]
        didSelectItem?(datum)
        cell.labelRecentlyPlayed?.text = datum.subtitle
        if let imageUrl = datum.image {
            let url = URL(string: imageUrl)
            cell.imgViewRecentlyPlayed?.kf.setImage(with: url)
        } else {
            cell.imgViewRecentlyPlayed?.image = UIImage(named: "placeholderImage")
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedDatum = coreDataArray[indexPath.item]
      if let subTitle = selectedDatum.subtitle{
          delegate?.didSelectItemAt(subTitle: subTitle)
     }
    }
}
extension RecentlyPlayedCell{
    internal func passData(data: [Music]) {
        self.coreDataArray = data
    }
}
