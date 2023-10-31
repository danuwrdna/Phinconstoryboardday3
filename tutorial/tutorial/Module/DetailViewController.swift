//
//  DetailViewController.swift
//  tutorial
//
//  Created by Phincon on 26/10/23.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var viewcontainer: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewcontainer.layer.cornerRadius = viewcontainer.frame.size.width / 15
        viewcontainer.clipsToBounds = true
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
