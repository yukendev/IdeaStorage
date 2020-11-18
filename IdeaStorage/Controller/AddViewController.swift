//
//  AddViewController.swift
//  IdeaStorage
//
//  Created by 手塚友健 on 2020/11/16.
//

import UIKit
import RealmSwift

class Category: Object {
    @objc dynamic var categoryName: String?
//    let ideaLists = List<Idea>()
}

class AddViewController: UIViewController, UITextFieldDelegate {
    
    
    
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var textField: UITextField!
    
    
    let realm = try! Realm()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        textField.delegate = self
        
        addButton.layer.cornerRadius = 5
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    

    @IBAction func addAction(_ sender: Any) {
        if textField.text != "" {
            let categories = realm.objects(Category.self)
            
            var categoryNames = [String]()
            
            for category in categories {
                categoryNames.append(category.categoryName!)
            }
            
            if categoryNames.contains(textField.text!) {
                print("被りはダメです")
                showAlert(type: "double")
            }else{
                print("被ってないです")
                addToRealm()
                dismiss(animated: true, completion: nil)
            }
        }else{
            showAlert(type: "blank")
            print("空白はダメです")
        }
        
        
    }
    
    @IBAction func backAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    func showAlert(type: String) {
        switch type {
        case "blank":
            let alertController = UIAlertController(title: "入力してください", message: "", preferredStyle: .alert)
            let cansel = UIAlertAction(title: "ok", style: .cancel, handler: nil)
            alertController.addAction(cansel)
            self.present(alertController, animated: true, completion: nil)
        case "double":
            let alertController = UIAlertController(title: "カテゴリーが重複しています", message: "", preferredStyle: .alert)
            let cansel = UIAlertAction(title: "ok", style: .cancel, handler: nil)
            alertController.addAction(cansel)
            self.present(alertController, animated: true, completion: nil)
        default:
            let alertController = UIAlertController(title: "エラーです", message: "", preferredStyle: .alert)
            let cansel = UIAlertAction(title: "ok", style: .cancel, handler: nil)
            alertController.addAction(cansel)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func addToRealm() {
        let category = Category()
        category.categoryName = textField.text
        try! realm.write{
            realm.add(category)
        }
    }

}
