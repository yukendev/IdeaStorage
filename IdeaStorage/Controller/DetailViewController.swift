//
//  DetailViewController.swift
//  IdeaStorage
//
//  Created by 手塚友健 on 2020/11/16.
//

import UIKit
import RealmSwift

class DetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var noIdeaLabel: UILabel!
    
    
    var category: String = ""
    
//    let ideaArray: [String] = ["30日チャレンジアプリ", "運ゲーアプリ", "雲SNSアプリ"]
    var ideaArray = [String]()
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(UINib(nibName: "CustomCell2", bundle: nil), forCellReuseIdentifier: "customCell2")

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        titleLabel.text = category
        
        print("JK")
        let ideas = realm.objects(Idea.self).filter("category == '\(category)'")
        if ideas.count != 0 {
            noIdeaLabel.isHidden = true
            for idea in ideas {
                ideaArray.append(idea.idea)
            }
        }else{
            ideaArray = []
            noIdeaLabel.isHidden = false
        }
        
    }
    

    @IBAction func backAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return ideaArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell2", for: indexPath) as! CustomCell2
        cell.ideaLabel.text = ideaArray[indexPath.row]
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        print(indexPath.row)
    }
    

}
