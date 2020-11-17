//
//  StorageViewController.swift
//  IdeaStorage
//
//  Created by 手塚友健 on 2020/11/16.
//

import UIKit
import RealmSwift

class Idea: Object {
    @objc dynamic var idea: String = ""
    @objc dynamic var category: String = ""
}

class StorageViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    
    
    @IBOutlet weak var ideaContainer: UIView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var pickerView: UIPickerView!
    
    var dataList = [String]()
    let realm = try! Realm()
    var selectedCategory = String()
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        ideaContainer.layer.cornerRadius = 5
        saveButton.layer.cornerRadius = 5

        textField.delegate = self
        pickerView.delegate = self
        pickerView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        print("viewWillAppear開始")
        
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
        
        selectedCategory = dataList[0]
       
        pickerView.reloadAllComponents()
//        if dataList.count != 0 {
//            selectedCategory = dataList[0]
//        }else{
//            dataList = ["カテゴリー１"]
//        }
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return dataList[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        selectedCategory = dataList[row]
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    
    @IBAction func saveAction(_ sender: Any) {
        
        if textField.text != "" {
            let idea = Idea()
            idea.idea = textField.text!
            idea.category = selectedCategory
            
            try! realm.write{
                realm.add(idea)
            }
            
            afterSave()
        }else{
            
        }
        
        print(selectedCategory)
    }
    
    func afterSave() {
        textField.text = ""
    }
    
    
}
