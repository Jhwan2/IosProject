//
//  SecondViewController.swift
//  SignUp_Project
//
//  Created by 이주환 on 2022/08/01.
//

import UIKit

class SecondViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate {

    @IBOutlet var IDtextFeild: UITextField!
    @IBOutlet var PwTextFeild: UITextField!
    @IBOutlet var RepwTextFeild: UITextField!
    @IBOutlet var BackButton: UIButton!
    @IBOutlet var NextButton: UIButton!
    @IBOutlet var SelfIntro: UITextView!
    @IBOutlet var MyImage: UIImageView!
    
    lazy var imagePicker: UIImagePickerController = {
        let picker: UIImagePickerController = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        picker.delegate = self
        return picker
    }()//imag Picker set
    
//MARK: view state Method
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.hidesBackButton = true // hide Back button
        
        self.MyImage.isUserInteractionEnabled = true //image gesture on

        self.SelfIntro.delegate = self//textView Delegate set
        
        IDtextFeild.addTarget(self, action: #selector(SecondViewController.textFieldDidChange(_:)), for: UIControl.Event.allEditingEvents)
        PwTextFeild.addTarget(self, action: #selector(SecondViewController.textFieldDidChange(_:)), for: UIControl.Event.allEditingEvents)
        RepwTextFeild.addTarget(self, action: #selector(SecondViewController.textFieldDidChange(_:)), for: UIControl.Event.allEditingEvents) // textField set

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Do any additional setup after loading the view.
//        print("SecondViewController의 view가 화면에 사라질 예정")

        UserInformation.shared.Image = self.MyImage.image
        UserInformation.shared.id = self.IDtextFeild.text
        UserInformation.shared.pw = self.PwTextFeild.text
        UserInformation.shared.selfIntroduce = self.SelfIntro.text
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Do any additional setup after loading the view.

        //print("ViewController의 view가 화면에 보여질 예정")
        UserInformation.shared.Image = self.MyImage.image
        UserInformation.shared.id = self.IDtextFeild.text
        UserInformation.shared.pw = self.PwTextFeild.text
        UserInformation.shared.selfIntroduce = self.SelfIntro.text
    }
    
    
    //MARK: Action Method
    @IBAction func SecondTouchUpBackButton(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func touchImage (_ sender: UITapGestureRecognizer){
        self.present(self.imagePicker, animated: true, completion: nil)
        //print("image tap!!")
    }
    @IBAction func tapView2 (_ sender: UITapGestureRecognizer){
        self.view.endEditing(true)
    }
    
    //MARK: image Picker Method
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let Imagea: UIImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            self.MyImage.image = Imagea
        }
        if (self.MyImage.image != nil) && (self.SelfIntro.text != "" )&&(self.IDtextFeild.text != nil)&&(self.PwTextFeild.text != nil)&&(self.PwTextFeild.text == self.RepwTextFeild.text) {
                   self.NextButton.isEnabled = true
                }else{
                    self.NextButton.isEnabled = false
                }
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK: Text Field Method
    @objc private func textFieldDidChange(_ textField: UITextField) {
        if (self.MyImage.image != nil) && (self.SelfIntro.text != "" )&&(self.IDtextFeild.text != nil)&&(self.PwTextFeild.text != nil)&&(self.PwTextFeild.text == self.RepwTextFeild.text) {
                   self.NextButton.isEnabled = true
                }else{
                    self.NextButton.isEnabled = false
                }

        }
    @objc func textViewDidChange(_ textView: UITextView) {
        if (self.MyImage.image != nil) && (self.SelfIntro.text != "" )&&(self.IDtextFeild.text != nil)&&(self.PwTextFeild.text != nil)&&(self.PwTextFeild.text == self.RepwTextFeild.text) {
                   self.NextButton.isEnabled = true
                }else{
                    self.NextButton.isEnabled = false
                }
    }
    


}
