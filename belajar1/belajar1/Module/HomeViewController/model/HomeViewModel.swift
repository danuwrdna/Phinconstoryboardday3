import Foundation
class HomeViewModel {
    var originalLearn = [Learn]()
    var learn = [Learn]()

    func configure() {
        originalLearn = [
            Learn(id: 1, nama: "Duo sejoli", description: "Rp. 200.000", imageName: "two-cats-lying-white-background-pet-animals_73107-1", detailViewControllerType: Tiket1ViewController.self),
            Learn(id: 2, nama: "jomblo sejati", description: "Rp. 150.000", imageName: "afe76dd0358105b5b9c84be3ce8b2143", detailViewControllerType: Tiket1ViewController.self),
            Learn(id: 3, nama: "Peduli teman", description: "Rp. 400.000", imageName: "360_F_101249007_L4x7p3dSC13zCOnQn7GZUoxRz5Opoobz", detailViewControllerType: Tiket2ViewController.self),
            Learn(id: 4, nama: "Peduli keluarga", description: "Rp. 350.000", imageName: "four-different-kittens-white-background-huddle-together_485703-44", detailViewControllerType: Tiket2ViewController.self),
            Learn(id: 5, nama: "It", description: "aasaasasasasasasa", imageName: "", detailViewControllerType: Tiket1ViewController.self),
            Learn(id: 6, nama: "It", description: "aasaasasasasasasa", imageName: "Lion_waiting_in_Namibia", detailViewControllerType: Tiket1ViewController.self)
        ]
        learn = originalLearn
    }

    func filterData(by index: Int) {
        switch index {
        case 0:
            learn.sort(by: { learn1, learn2 in
                let harga1 = extractHarga(from: learn1.description)
                let harga2 = extractHarga(from: learn2.description)
                return harga1 > harga2
            })
        case 1:
            learn.sort(by: { learn1, learn2 in
                let harga1 = extractHarga(from: learn1.description)
                let harga2 = extractHarga(from: learn2.description)
                return harga1 < harga2
            })
        default:
            learn = originalLearn
        }
    }

    private func extractHarga(from description: String) -> Double {
        let components = description.components(separatedBy: " ")
        if let hargaString = components.last, let harga = Double(hargaString) {
            return harga
        }
        return 0.0
    }
    
}
