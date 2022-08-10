//
//  ViewController.swift
//  TabGesture
//
//  Created by 이주환 on 2022/08/03.
//

import UIKit

class ViewController: UIViewController {
    
    @IBAction func tapView (_ sender: UITapGestureRecognizer){
        self.view.endEditing(true)
        print("tap!")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

