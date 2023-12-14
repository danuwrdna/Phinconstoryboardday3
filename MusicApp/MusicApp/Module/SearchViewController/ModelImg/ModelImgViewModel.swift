import Foundation
struct DataImage{
    var image: String
}
class ModelImgViewModel{
    var imageArray: [DataImage] = []

        init() {
           
            imageArray = [
                DataImage(image: "side-by-side-4e5f57-and-495e57-small"),
                DataImage(image: "f4ce14"),
                DataImage(image: "45474B")
                // ... tambahkan data lainnya jika diperlukan
            ]
        }
}

