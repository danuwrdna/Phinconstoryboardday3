//
//  UpdateViewController.swift
//  tutorial
//
//  Created by Phincon on 26/10/23.
//

import UIKit

class UpdateViewController: UIViewController {
//    @IBAction func konfirm(_ sender: UIButton) {
//        performSegue(withIdentifier: "DetailViewController", sender: nil)
//    }
    @IBAction func DetailStoryBoard(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let destinasiviewcontroller = storyboard.instantiateViewController(withIdentifier: "DetailStoryBoardID")
        
        self.navigationController?.pushViewController(destinasiviewcontroller, animated: true)
        
    }
    @IBOutlet weak var container: UIView!
//    @IBAction func detail(_ sender: Any) {
//        performSegue(withIdentifier: "DetailViewController", sender: nil)
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        container.layer.cornerRadius = container.frame.size.width / 15
        container.clipsToBounds = true

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
