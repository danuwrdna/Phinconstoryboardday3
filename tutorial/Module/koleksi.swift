//
//  koleksi.swift
//  tutorial
//
//  Created by Phincon on 30/10/23.
//

import UIKit

class koleksi: UIViewController {
    
    @IBOutlet weak var tableview: UITableView!
    
    var data = [datahewan(sectionType: "Predator", hewan: ["singa","macan","harimau"])]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableview.delegate = self
        tableview.dataSource = self
        
    }

}

extension koleksi: UITableViewDelegate,UITableViewDataSource{   
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return data[section].sectionType
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? HewanTableViewCell
      
        return cell ?? UITableViewCell()
    }
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = .green
    }
    
    
}
