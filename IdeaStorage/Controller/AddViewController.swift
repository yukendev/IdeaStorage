//
//  AddViewController.swift
//  IdeaStorage
//
//  Created by 手塚友健 on 2020/11/16.
//

import UIKit

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
        dismiss(animated: true, completion: nil)
    }
    

}
