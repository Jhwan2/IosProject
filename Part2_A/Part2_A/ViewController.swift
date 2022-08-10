//
//  ViewController.swift
//  Part2_A
//
//  Created by 이주환 on 2022/08/01.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet var nameField: UITextField!
    @IBOutlet var ageField: UITextField!
    
    @IBAction func touchUpSetButton (_ sender: UIButton){
        UserInformation.Shared.name = nameField.text
        UserInformation.Shared.age = ageField.text
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        print("ViewController의 view가 메모리에 로드됨")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Do any additional setup after loading the view.
        
        print("ViewController의 view가 화면에 보여질 예정")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // Do any additional setup after loading the view.
        
        print("ViewController의 view가 화면에 보여짐")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Do any additional setup after loading the view.
        
        print("ViewController의 view가 화면에 사라질 예정")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        // Do any additional setup after loading the view.
        
        print("ViewController의 view가 화면에 사라짐")
        
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        print("ViewController의 view가 SubView를 Layout 하려함")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        print("ViewController의 view가 Subview를 Layout 함")
    }
    

}

