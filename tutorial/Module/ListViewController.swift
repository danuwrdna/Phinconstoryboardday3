//
//  ListViewController.swift
//  tutorial
//
//  Created by Phincon on 26/10/23.
//

import UIKit
class Listcell: UITableViewCell{
    
    @IBOutlet weak var mainmusik: UILabel!
    @IBOutlet weak var joni: UILabel!
    
}

class ListViewController: UIViewController {
    var nama  = ["JO", "BO", "BO"]
    var Hobi  = ["msk", "sni","bhsa"]
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "Listcell", bundle: nil), forCellReuseIdentifier: "Listcell")
    }
    
}
extension ListViewController: UITableViewDataSource, UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:"ListCell", for:indexPath) as! Listcell
        let data = nama[indexPath.row]
        let data2 = Hobi[indexPath.row]
        cell.joni.text = data
        cell.mainmusik.text = data2
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nama.count
    }
}
