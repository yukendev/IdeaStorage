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
            let category = Category()
            category.categoryName = textField.text
            
            let realm = try! Realm()
            try! realm.write{
                realm.add(category)
            }
            
            
            dismiss(animated: true, completion: nil)
        }else{
            print("空白はダメです")
        }
        
        
    }
    
    @IBAction func backAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
