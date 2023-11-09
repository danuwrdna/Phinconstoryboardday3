import UIKit

class TableViewCell: UITableViewCell {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageAutoCarousel: UIPageControl!
    
    var images = (1...2).compactMap{ namaFile in
        UIImage(named: "aa\(namaFile)")}
    var timer: Timer?
    var currentIndex = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCollection()
        pageAutoCarousel.numberOfPages = images.count
        startAutoSlide()
        print("ini file danu: \(images)")
    }
    func setupCollection(){
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CollectionViewCell")
        
    }
    func startAutoSlide(){
        timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(autoSlide), userInfo: nil, repeats: true)
    }
    @objc func autoSlide(){
        let nextIndex = (currentIndex + 1) % images.count
        collectionView.scrollToItem(at: IndexPath(item: nextIndex,section: 0), at: .centeredHorizontally, animated: true)
        currentIndex = nextIndex
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

extension TableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        cell.imageView.image = images[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 600, height: 600)
    }
    
    
    
    
}
