//
//  ViewController.swift
//  MyDatepickle
//
//  Created by 이주환 on 2022/08/03.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var datepicker: UIDatePicker!
    @IBOutlet weak var dateLabel: UILabel!
    let dateFormatter: DateFormatter = {
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = "MM.dd hh:mm:ss"
        return formatter
    }()
    
    @IBAction func didDatepickerValueChanged(_ sender: UIDatePicker){
        let date: Date! = self.datepicker.date
        let dateString: String = self.dateFormatter.string(from: date)
        
        self.dateLabel.text = dateString
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

