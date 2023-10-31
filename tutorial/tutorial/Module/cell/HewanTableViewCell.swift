import UIKit

class HewanTableViewCell: UITableViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var manggil = koleksi()
    
    
    var data = [datahewan(sectionType: "Predator", hewan: ["singa","macan","harimau"])]

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.collectionView.register(UINib(nibName: "HewanCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "HewanCollectionViewCell")
        
        
        self.collectionView.delegate = self
        self.collectionView.dataSource =  self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}

extension HewanTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! HewanCollectionViewCell
        cell.Hewanimage.image = UIImage(named: "sapi")
        
        return cell
    }
}
