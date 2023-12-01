import Foundation
import UIKit
struct DogModel: Codable {
    let message: [String]
    let status: String
}

class DogViewModel {
    private var model: DogModel?
    
    var onDataUpdate: (() -> Void)?

    var numberOfItems: Int {
        return model?.message.count ?? 0
    }

    func fetchData() {
        let apiURL = "https://dog.ceo/api/breeds/image/random/500"
        
        NetworkManager.shared.makeAPICall(urlString: apiURL, method: .get) { [weak self] (response: Result<DogModel, Error>) in
            switch response {
            case .success(let dogs):
                self?.model = dogs
                self?.onDataUpdate?()
            case .failure(let error):
                print("Dog API Request Error: \(error.localizedDescription)")
                self?.showErrorMessage("Internet Required For API")
              
            }
        }
    }
    func showErrorMessage(_ message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        UIApplication.shared.keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
    }

    func getDogItem(at index: Int) -> String? {
        return model?.message[index]
    }
}
