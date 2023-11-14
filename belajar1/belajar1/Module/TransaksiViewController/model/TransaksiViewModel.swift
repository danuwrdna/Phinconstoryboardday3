import Foundation
class TransaksiViewModel{
    var dataList = [History]()
    var list = [History]()
    
    func listData(){
        dataList = [
            History(judul: "oke", subJudul: "olok", total: "ook")
        ]
        list = dataList
    }
}
