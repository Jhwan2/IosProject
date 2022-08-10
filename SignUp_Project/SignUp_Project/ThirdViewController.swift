//
//  ThirdViewController.swift
//  SignUp_Project
//
//  Created by 이주환 on 2022/08/01.
//

import UIKit

class ThirdViewController: UIViewController {
    
    @IBOutlet var birthLable: UILabel!
    @IBOutlet var birthPicker: UIDatePicker!
    @IBOutlet var CancleButton: UIButton!
    @IBOutlet var BackBu:UIButton!
    @IBOutlet var SignInButton:UIButton!
    @IBOutlet var PhoneNumber:UITextField!
    
    let dateFormatter: DateFormatter = {
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = "yyyy년 MM월 dd일"
        return formatter
    }()

    //MARK: Action Method
    @IBAction func pickerValueChanged (_ sender: UIDatePicker){
        let date: Date! = self.birthPicker.date
        let dateString: String = self.dateFormatter.string(from: date)
        
        self.birthLable.text = dateString
        
        if self.PhoneNumber.text!.count > 3 {
                   self.SignInButton.isEnabled = true
                }else{
                    self.SignInButton.isEnabled = false
                }
    }
    
    @IBAction func thirBackButton(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func tapView3 (_ sender: UITapGestureRecognizer){
        self.view.endEditing(true)
    }
    
//MARK: View state Method
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.hidesBackButton = true // hide back button
        
        PhoneNumber.addTarget(self, action: #selector(ThirdViewController.textFieldDidChange(_:)), for: UIControl.Event.allEditingEvents)

        // Do any additional setup after loading the view.
    }
    
        override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
            // Do any additional setup after loading the view.
            UserInformation.shared.Number = self.PhoneNumber.text
            UserInformation.shared.birthday = self.birthLable.text
        }
    
    
    //MARK: text field Method
    @objc private func textFieldDidChange(_ textField: UITextField) {
        if self.birthLable.text != "" && self.PhoneNumber.text!.count > 3 {
                   self.SignInButton.isEnabled = true
                }else{
                    self.SignInButton.isEnabled = false
                }
        }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
