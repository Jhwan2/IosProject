//
//  ViewController.swift
//  Alert
//
//  Created by 이주환 on 2022/08/29.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func touchUpShowAlertButton(_ sender: UIButton){
        self.showAlertController(style: UIAlertController.Style.alert)
    }
    @IBAction func touchUpShowActionSheetButton(_ sender: UIButton){
        self.showAlertController(style: UIAlertController.Style.actionSheet)
    }
    
    func showAlertController(style: UIAlertController.Style){
        
        let alertController: UIAlertController
        alertController = UIAlertController(title: "Title", message: "Message", preferredStyle: style)
        let okAction: UIAlertAction
        okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (action: UIAlertAction) in
            print("OK pressed") })
        let cancelAction: UIAlertAction
        cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil)
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        
        let handler: (UIAlertAction) ->Void
        handler = { (action: UIAlertAction) in
            print("action pressed \(action.title ?? "")")
        }
        
        let someAction: UIAlertAction
        someAction = UIAlertAction(title: "Some", style: UIAlertAction.Style.destructive, handler: handler)
        let anotherAction: UIAlertAction
        anotherAction = UIAlertAction(title: "Another", style: UIAlertAction.Style.default, handler: handler)
        
        alertController.addAction(someAction)
        alertController.addAction(anotherAction)
        alertController.addTextField{ (field: UITextField) in
            field.placeholder = "Place Holder"
            field.textColor = UIColor.red
        }// Alert textfield 생성및 액션추가 액션시트와 더불어
        
        self.present(alertController, animated: true, completion: { print("Alert controller shown") })
    }


}

