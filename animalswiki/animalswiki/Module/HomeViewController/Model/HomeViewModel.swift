import Foundation

class HomeViewModel {
    private var model: Welcome?
    var onDataUpdate: (() -> Void)?

    var numberOfItems: Int {
        return model?.count ?? 0
    }

    func fetchData() {
        let apiURL = "https://api.thecatapi.com/v1/images/search?limit=20"
        NetworkManager.shared.makeAPICall(urlString: apiURL, method: .get) { [weak self] (response: Result<Welcome, Error>) in
            switch response {
            case .success(let cats):
                self?.model = cats
                self?.onDataUpdate?()
            case .failure(let error):
                print("API Request Error: \(error.localizedDescription)")
            }
        }
    }

    func getCatItem(at index: Int) -> CatModel? {
        return model?[index]
    }
}
