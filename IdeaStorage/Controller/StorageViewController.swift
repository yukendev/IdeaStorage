//
//  StorageViewController.swift
//  IdeaStorage
//
//  Created by 手塚友健 on 2020/11/16.
//

import UIKit

class StorageViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    
    
    @IBOutlet weak var ideaContainer: UIView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var pickerView: UIPickerView!
    
    let dataList: [String] = ["アイデア", "ブログ", "やること"]
    
    var category = String()
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        ideaContainer.layer.cornerRadius = 5
        saveButton.layer.cornerRadius = 5

        textField.delegate = self
        pickerView.delegate = self
        pickerView.dataSource = self
        
        
        category = dataList[0]
        
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
        
        category = dataList[row]
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    
    @IBAction func saveAction(_ sender: Any) {
        print(category)
    }
    
    
    
}
