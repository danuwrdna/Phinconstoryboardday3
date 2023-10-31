import Foundation


class NagihUtang{
    var num: Int = 5
    
    var utang : String{ //computed prorpeties
        switch num {
        case 1:
            return "ini 1"
        case 2:
            return "ini 1"
        case 3:
            return "ini 1"
        default:
            return "ini yang penting bukan 1, 2, 3"
        }
    }
    
    init(utangawal: Int){
    utang 
    }
     static func caranagih(caranya: String) -> String{
         
        if caranya == "Kasar" {
            return "ga boleh nagih"
        }
        else{
            return "boleh deh"
       } // ini kondisi if else
       //  caranya > 0 ? "ada utang" : "gada utang" singkat if else
         
    }
}

//var nagihUtang = NagihUtang(utangawal: 50_000) instance

print(NagihUtang.caranagih(caranya: "Engga kasar"))
//NagihUtang.caranagih(caranya: 500.0)
class Totalutang{
    var total: Double{
        return 100.000
    }
    func ngePrint() -> Double {
        
      total
    }
}
var totalutang = Totalutang()
print(totalutang.ngePrint())

class daftarutang{
    func list(){
        var num:String = "makan"
        
        var utang : String{ //computed prorpeties
            switch num {
            case "makan":
                return "ini utang makan"
            case "ngopi":
                return "ini utang ngopi"
            case "ngemil":
                return "ini utang ngemil"
            default:
                return "ga punya utang"
            }
        }
        print(utang)
    }
    
}
var cek = daftarutang()
print(cek.list())

class bayarhutang{
    var bayar: Double
    
    init(listutang: Double){
        bayar = listutang
    }
    
    }
     func carabayar(bayarnya: String) -> String{
         
        if bayarnya == "Kasar" {
            return "ga boleh nagih"
        }
        else{
            return "boleh deh"
       } // ini kondisi if else
       //  caranya > 0 ? "ada utang" : "gada utang" singkat if else
         
    }

