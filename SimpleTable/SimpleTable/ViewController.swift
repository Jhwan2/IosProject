//
//  ViewController.swift
//  SimpleTable
//
//  Created by 이주환 on 2022/08/07.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    let cellIndentifier: String = "cell"
    let customCellIndentifier: String = "customCell"
    
    let korean: [String] = ["가","나","다","라","마","바","사","아","자","차","카","타","파","하"]
    let english: [String] = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]
    var dates: [Date] = []
    let dateFormatter: DateFormatter = {
        let formatter: DateFormatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }()
    let timeFormatter: DateFormatter = {
        let formatter: DateFormatter = DateFormatter()
        formatter.timeStyle = .medium
        return formatter
    }()
    
    @IBAction func touchUpAddButton(_ sender: UIButton){
        dates.append(Date())
        //self.tableView.reloadData()
        self.tableView.reloadSections(IndexSet(2...2), with: UITableView.RowAnimation.automatic)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    } // 총 몇개의 섹션 할건지 설정하는 함수
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            return self.korean.count
        case 1:
            return self.english.count
        case 2:
            return self.dates.count
        default:
            return 0
        }
        
        
    }// TableView 구현시 필수 구성될 함수 (섹션당 행의 갯수 설정함수)
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section < 2{
            let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: self.cellIndentifier, for: indexPath)
            
            let text: String = indexPath.section == 0 ? korean[indexPath.row] : english[indexPath.row]
            
            cell.textLabel?.text = text
            return cell
        } else{
            
            let cell: CustomTableViewCell = tableView.dequeueReusableCell(withIdentifier: self.customCellIndentifier, for: indexPath) as! CustomTableViewCell //강제 타입 캐스팅 이기에 더좋은 방법이 있다고 함
            
            cell.leftLable.text = self.dateFormatter.string(from: self.dates[indexPath.row])
            cell.rightLable.text = self.timeFormatter.string(from: self.dates[indexPath.row])
            return cell
        }
    }// TableView 구현시 필수 구성될 함수 (셀의 구성, 설정 함수)
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section < 2{
        return section == 0 ? "한글":"영어"
        }
        return nil
    }
    
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        guard let nextViewcontroller: SecondViewController = segue.destination as? SecondViewController else {
            return
        }
        
        guard let cell: UITableViewCell = sender as? UITableViewCell else {
            return
        }
        
        nextViewcontroller.textTocSet = cell.textLabel?.text
        
    }




}

