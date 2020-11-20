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
    
    
    
    
    @IBOutlet weak var headerView: UIView!
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
        
        saveButton.addTarget(self, action: #selector(self.pushButton_Animation(_:)), for: .touchDown)
        saveButton.addTarget(self, action: #selector(self.separateButton_Animation(_:)), for: .touchUpInside)
        
        
//        let bottomBorder = CALayer()
//        bottomBorder.frame = CGRect(x: 0, y: headerView.frame.height, width: headerView.frame.width, height: 0.5)
//        bottomBorder.backgroundColor = UIColor.black.cgColor
//        headerView.layer.addSublayer(bottomBorder)
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
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @objc func pushButton_Animation(_ sender: UIButton){
          UIView.animate(withDuration: 0.1, animations:{ () -> Void in
              sender.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
          })
      }
          
          
      @objc func separateButton_Animation(_ sender: UIButton){
          UIView.animate(withDuration: 0.2, animations:{ () -> Void in
              sender.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
              sender.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
          })
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
            let ideaArray = realm.objects(Idea.self).filter("category == '\(selectedCategory)'")
            var ideaLists: [String] = []
            if ideaArray.count == 0 {
                ideaLists = []
            }else{
                for idea in ideaArray {
                    ideaLists.append(idea.idea)
                }
            }

            if ideaLists.contains(textField.text!) {
                print("アイデア被り")
                showAlert(type: "double")

            }else{
                let idea = Idea()
                idea.idea = textField.text!
                idea.category = selectedCategory

                try! realm.write{
                    realm.add(idea)
                }

                afterSave()
            }
        }else{
            showAlert(type: "blank")
        }

        print(selectedCategory)
    }
    
    func afterSave() {
        textField.text = ""
    }
    
    
    func showAlert(type: String) {
        
        switch type {
        case "blank":
            let alertController = UIAlertController(title: "入力してください", message: "", preferredStyle: .alert)
            let cansel = UIAlertAction(title: "ok", style: .cancel, handler: nil)
            alertController.addAction(cansel)
            self.present(alertController, animated: true, completion: nil)
        case "double":
            let alertController = UIAlertController(title: "すでに同じアイデアが存在しています", message: "", preferredStyle: .alert)
            let cansel = UIAlertAction(title: "ok", style: .cancel, handler: nil)
            alertController.addAction(cansel)
            self.present(alertController, animated: true, completion: nil)
        default:
            let alertController = UIAlertController(title: "エラーが発生しました", message: "", preferredStyle: .alert)
            let cansel = UIAlertAction(title: "ok", style: .cancel, handler: nil)
            alertController.addAction(cansel)
            self.present(alertController, animated: true, completion: nil)
        }
        
    }
    
    func ideaAnimation() {
        UIView.animate(withDuration: 1.0, delay: 0.0, options: .autoreverse) { [self] in
            ideaContainer.bounds.size.height += 10
            ideaContainer.bounds.size.width += 10
        } completion: { _ in
            print("jk")
        }

    }
}
