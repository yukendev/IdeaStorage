//
//  IdeaViewController.swift
//  IdeaStorage
//
//  Created by 手塚友健 on 2020/11/16.
//

import UIKit
import RealmSwift

class IdeaViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var headerView: UIView!
    
    
//    let dataList: [String] = ["アイデア", "ブログ", "やること"]
    var dataList = [String]()
    var selectedCell = String()
    let realm = try! Realm()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        
        tableView.register(UINib(nibName: "CustomCell1", bundle: nil), forCellReuseIdentifier: "customCell1")

        addButton.layer.cornerRadius = 5
        
        addButton.addTarget(self, action: #selector(self.pushButton_Animation(_:)), for: .touchDown)
        addButton.addTarget(self, action: #selector(self.separateButton_Animation(_:)), for: .touchUpInside)
        
//        let bottomBorder = CALayer()
//        bottomBorder.frame = CGRect(x: 0, y: headerView.frame.height, width: headerView.frame.width, height: 0.5)
//        bottomBorder.backgroundColor = UIColor.black.cgColor
//        headerView.layer.addSublayer(bottomBorder)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        let categoryArray = realm.objects(Category.self)
        
        dataList = []
        
        if categoryArray.count == 0 {
            let category = Category()
            category.categoryName = "カテゴリー１"
            try! realm.write{
                realm.add(category)
            }
            dataList = ["カテゴリー１"]
        }else{
            for category in categoryArray {
                dataList.append(category.categoryName!)
            }
        }
        tableView.reloadData()
        
        print(dataList)
        print(Realm.Configuration.defaultConfiguration.fileURL!)
    }
    
    @objc func pushButton_Animation(_ sender: UIButton){
          UIView.animate(withDuration: 0.1, animations:{ () -> Void in
              sender.transform = CGAffineTransform(scaleX: 0.99, y: 0.99)
          })
      }
          
          
      @objc func separateButton_Animation(_ sender: UIButton){
          UIView.animate(withDuration: 0.2, animations:{ () -> Void in
              sender.transform = CGAffineTransform(scaleX: 0.99, y: 0.99)
              sender.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
          })
      }

    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell1", for: indexPath) as! CustomCell1
        
        cell.categoryLabel.text = dataList[indexPath.row]
        
        let amountOfIdea = realm.objects(Idea.self).filter("category == '\(dataList[indexPath.row])'")


        cell.amountOfNumber.text = String(amountOfIdea.count)
//
        
        
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print(indexPath.row)
        selectedCell = dataList[indexPath.row]
        performSegue(withIdentifier: "detail", sender: nil)
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        print(indexPath.row)
        showAlert(indexPath: indexPath.row, type: "delete")
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "削除"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "detail" {
            let detailVC = segue.destination as! DetailViewController
            detailVC.category = selectedCell
        }
        
    }
    
    
    @IBAction func addAction(_ sender: Any) {
        performSegue(withIdentifier: "add", sender: nil)
    }
    
    func showAlert(indexPath: Int, type: String) {
        
        switch type {
        case "delete":
            let alertController = UIAlertController(title: "本当に削除しますか？", message: "", preferredStyle: .alert)
            let deleteAction = UIAlertAction(title: "はい", style: .default) { (alert) in
                self.deleteAction(indexPath: indexPath)
            }
            let cansel = UIAlertAction(title: "いいえ", style: .cancel, handler: nil)
            alertController.addAction(cansel)
            alertController.addAction(deleteAction)
            self.present(alertController, animated: true, completion: nil)
        case "warning":
            let alertController = UIAlertController(title: "カテゴリーは最低1つ必要です", message: "", preferredStyle: .alert)
            let cansel = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(cansel)
            self.present(alertController, animated: true, completion: nil)
        default:
            print("error")
        }
        
        
    }
    
    func deleteAction(indexPath: Int) {
        print("上から\(indexPath + 1)番目を消します")
        print(dataList[indexPath])
        
        let deletedCategoryName = dataList[indexPath]
        
        if dataList.count == 1 {
            showAlert(indexPath: 0, type: "warning")
        }else{
            deleteCategory(category: deletedCategoryName)

            deleteIdeas(category: deletedCategoryName)

            tableView.reloadData()
        }
    }
    
    
    
    func deleteCategory(category: String) {
        let newDataList = realm.objects(Category.self).filter("categoryName != '\(category)'")
        let deletedCategory = realm.objects(Category.self).filter("categoryName == '\(category)'")
        
        dataList = []
        for category in newDataList {
            dataList.append(category.categoryName!)
        }
        try! realm.write{
            realm.delete(deletedCategory)
        }
    }
    
    
    
    func deleteIdeas(category: String) {
        let deletedIdeas = realm.objects(Idea.self).filter("category == '\(category)'")
        
        try! realm.write{
            realm.delete(deletedIdeas)
        }
    }
    
}
