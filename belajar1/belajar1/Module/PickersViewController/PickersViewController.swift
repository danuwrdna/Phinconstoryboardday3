import UIKit

class PickersViewController: UIViewController {

    @IBOutlet weak var penilaianKebersihan: UITextField!
    @IBOutlet weak var penilaianHewan: UITextField!
    @IBOutlet weak var penilaianPelayanan: UITextField!
    @IBAction func kirimButton(_ sender: Any) {
        let kirimbutton = HomeViewController()
        self.navigationController?.pushViewController(kirimbutton, animated: true)
    }
    @IBAction func kembaliButton(_ sender: Any) {
        let kembalibutton = HomeViewController()
        self.navigationController?.pushViewController(kembalibutton, animated: true)
    }
    let kebersihan = ["Lengkap","Biasa Aja", "Tidak lengkap"]
    let hewan = ["Efektif", "Tidak Efektif"]
    let pelayanan = ["Tepat","Tidak Tepat"]
    
    var kebersihanPickerView = UIPickerView()
    var hewanPickerView = UIPickerView()
    var pelayananPickerView = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        penilaianKebersihan.inputView = kebersihanPickerView
        penilaianHewan.inputView = hewanPickerView
        penilaianPelayanan.inputView = pelayananPickerView
        
        penilaianKebersihan.placeholder = "Apa penilaian mu"
        penilaianHewan.placeholder = "Apa penilaian mu"
        penilaianPelayanan.placeholder = "Apa penilaian mu"
        
        kebersihanPickerView.delegate = self
        kebersihanPickerView.dataSource = self
        hewanPickerView.delegate = self
        hewanPickerView.dataSource = self
        pelayananPickerView.delegate = self
        pelayananPickerView.dataSource = self
        
        kebersihanPickerView.tag = 1
        hewanPickerView.tag = 2
        pelayananPickerView.tag = 3
    }
}
extension PickersViewController: UIPickerViewDataSource, UIPickerViewDelegate{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        case 1:
            return kebersihan.count
        case 2:
            return hewan.count
        case 3:
            return pelayanan.count
        default:
            return 1
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        switch pickerView.tag {
        case 1:
            return kebersihan[row]
        case 2:
            return hewan[row]
        case 3:
            return pelayanan[row]
        default:
            return "Data Tidak Ada"
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag {
        case 1:
            penilaianKebersihan.text = kebersihan[row]
            penilaianKebersihan.resignFirstResponder()
        case 2:
            penilaianHewan.text = hewan[row]
            penilaianHewan.resignFirstResponder()
        case 3:
            penilaianPelayanan.text = pelayanan[row]
            penilaianPelayanan.resignFirstResponder()
        default:
            return
        }
    }
}
