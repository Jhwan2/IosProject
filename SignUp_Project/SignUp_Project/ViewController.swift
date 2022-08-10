//
//  ViewController.swift
//  SignUp_Project
//
//  Created by 이주환 on 2022/08/01.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var Idfeild: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.hidesBackButton = true // hide Back button
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Do any additional setup after loading the view.
        
        if UserInformation.shared.id != "" && UserInformation.shared.birthday != "" {
            self.Idfeild.text = UserInformation.shared.id
        }
    }
    
    @IBAction func tapView1 (_ sender: UITapGestureRecognizer){
        self.view.endEditing(true)
    }


}

