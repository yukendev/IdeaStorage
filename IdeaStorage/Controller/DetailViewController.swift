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
    @IBOutlet weak var headerView: UIView!
    
    
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
        
//        
//        let bottomBorder = CALayer()
//        bottomBorder.frame = CGRect(x: 0, y: headerView.frame.height, width: headerView.frame.width, height: 0.5)
//        bottomBorder.backgroundColor = UIColor.black.cgColor
//        headerView.layer.addSublayer(bottomBorder)

        
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
        showAlert(indexPath: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "削除"
    }
    
    func showAlert(indexPath: Int) {
        let alertController = UIAlertController(title: "本当に削除しますか？", message: "", preferredStyle: .alert)
        let deleteAction = UIAlertAction(title: "はい", style: .default) { (alert) in
            self.deleteAction(indexPath: indexPath)
        }
        let cansel = UIAlertAction(title: "いいえ", style: .cancel, handler: nil)

        alertController.addAction(cansel)
        alertController.addAction(deleteAction)

          self.present(alertController, animated: true, completion: nil)
    }
    
    func deleteAction(indexPath: Int) {
        print("上から\(indexPath + 1)番目を消します")
        
        print(ideaArray[indexPath])
        
        
        let newIdeaArray = realm.objects(Idea.self).filter("(idea != '\(ideaArray[indexPath])') && (category == '\(category)')")
        
        
        let deletedIdea = realm.objects(Idea.self).filter("(idea == '\(ideaArray[indexPath])') && (category == '\(category)')")
        
        ideaArray = []
        for idea in newIdeaArray {
            ideaArray.append(idea.idea)
        }
        try! realm.write{
            realm.delete(deletedIdea)
        }
        tableView.reloadData()
    }
    

}
