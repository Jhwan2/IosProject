//
//  ThirdViewController.swift
//  WeatherToday
//
//  Created by 이주환 on 2022/08/08.
//

import UIKit

class ThirdViewController: UIViewController {
    
    @IBOutlet var label1: UILabel!
    @IBOutlet var label2: UILabel!
    @IBOutlet var label3: UILabel!
    @IBOutlet var imgView: UIImageView!
    var resultInfo1: String? = ""
    var resultInfo2: String? = ""
    var resultInfo3: String? = ""
    var rImg: UIImageView = UIImageView()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.label1.text = resultInfo1
        self.label2.text = resultInfo3
        self.label3.text = resultInfo2
        self.imgView.image = rImg.image

        // Do any additional setup after loading the view.
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
