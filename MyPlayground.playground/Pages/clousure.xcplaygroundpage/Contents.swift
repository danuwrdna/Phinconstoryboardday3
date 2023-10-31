class Test{
    //: [Previous](@previous)

//    import Foundation
    func oke () {
        var num: Int = 4
        
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
        
        print(utang)
        //: [Next](@next)
    }


}
var cek = Test()
print(cek.oke())
