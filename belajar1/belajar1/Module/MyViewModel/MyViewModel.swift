import Foundation
import RxSwift

class HomeViewModel {
    private let networkManager: NetworkManager // Anda perlu menambahkan ketergantungan ke NetworkManager
    private var disposeBag = DisposeBag()

    var learnItems: BehaviorRelay<[Learn]> = BehaviorRelay(value: [])

    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }

    func fetchData() {
        networkManager.makeAPICall(urlString: "URL_API_ANDA")
            .subscribe(onNext: { [weak self] response in
                self?.learnItems.accept(response)
            })
            .disposed(by: disposeBag)
    }
}
