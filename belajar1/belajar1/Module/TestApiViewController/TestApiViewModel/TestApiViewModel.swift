import Foundation

class PokemonListViewModel {
    private var model: PokemontModel?
    var onDataUpdate: (() -> Void)?

    var numberOfItems: Int {
        return model?.results.count ?? 0
    }

    func fetchData() {
        let apiURL = "https://pokeapi.co/api/v2/pokemon?offset=0&limit=1000"
        NetworkManager.shared.makeAPICall(urlString: apiURL, method: .get) { [weak self] (response: Result<PokemontModel, Error>) in
            switch response {
            case .success(let trades):
                self?.model = trades
                self?.onDataUpdate?()
            case .failure(let error):
                print("API Request Error: \(error.localizedDescription)")
            }
        }
    }
    func getPokemonItem(at index: Int) -> ResultPokemon? {
            return model?.results[index]
        }
}

