//
//  SecondViewController.swift
//  WeatherToday
//
//  Created by 이주환 on 2022/08/08.
//

import UIKit

class SecondViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var NaviInfomation: String?
    @IBOutlet weak var tableView: UITableView!
    let cellIdentifier: String = "cityCell"
    var Citys: [City] = []
    var StateInfo: [Int:String] = [10 : "sunny", 11 : "cloudy", 12 : "rainy", 13 : "snowy"]
    var uiImageView: UIImageView = UIImageView()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        let cityname: String = NaviInfomation
        let jsonDecoder: JSONDecoder = JSONDecoder()
        guard let dataAsset: NSDataAsset = NSDataAsset(name: NaviInfomation!) else {
            print("error")
            return }
        
        do {
             self.Citys = try jsonDecoder.decode([City].self, from: dataAsset.data)
        } catch {
            print(error.localizedDescription)
        }
        
        self.tableView.rowHeight = 80
        self.tableView.reloadData()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Citys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: CustomTableViewCell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath) as! CustomTableViewCell
        
        let city: City = self.Citys[indexPath.row]

        cell.cityLabel.text = city.cityName
        cell.tempLabel.text = city.TempString
        cell.rainLabel.text = city.rainfallString
        
        let image: UIImage = UIImage(named: self.StateInfo[city.state]!)!
        uiImageView = UIImageView(image: image)
        cell.img.image = uiImageView.image
        
        
        return cell
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        guard let nextViewcontroller: ThirdViewController = segue.destination as? ThirdViewController else {
            return
        }
        
        guard let cell: CustomTableViewCell = sender as? CustomTableViewCell else {
            return
        }
        nextViewcontroller.title = cell.cityLabel.text
        nextViewcontroller.resultInfo1 = cell.cityLabel.text
        nextViewcontroller.resultInfo2 = cell.rainLabel.text
        nextViewcontroller.resultInfo3 = cell.tempLabel.text
        nextViewcontroller.rImg.image = cell.img.image
        
        
        
    }
    

}
