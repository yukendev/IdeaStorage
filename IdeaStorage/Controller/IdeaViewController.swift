//
//  IdeaViewController.swift
//  IdeaStorage
//
//  Created by 手塚友健 on 2020/11/16.
//

import UIKit

class IdeaViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addButton: UIButton!
    
    let dataList: [String] = ["アイデア", "ブログ", "やること"]
    var selectedCell = String()
    
    enum SegueIdentifier: String {
            case a
            case b
        }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        
        tableView.register(UINib(nibName: "CustomCell1", bundle: nil), forCellReuseIdentifier: "customCell1")

        addButton.layer.cornerRadius = 5
        
    }
    

    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell1", for: indexPath) as! CustomCell1
        
        cell.categoryLabel.text = dataList[indexPath.row]
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print(indexPath.row)
        selectedCell = dataList[indexPath.row]
        performSegue(withIdentifier: "detail", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "detail" {
            let detailVC = segue.destination as! DetailViewController
            detailVC.category = selectedCell
        }
        
//        let addVC = segue.destination as! AddViewController
        
    }
    
    
    @IBAction func addAction(_ sender: Any) {
        performSegue(withIdentifier: "add", sender: nil)
    }
    
}
