//
//  ViewController.swift
//  WeatherToday
//
//  Created by 이주환 on 2022/08/08.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
    //MARK: property
    var Countrys: [Country] = []
    @IBOutlet weak var tableView: UITableView!
    let cellIdentifier: String = "countryCell"
    
    var uiImageView: UIImageView = UIImageView()
    let nicName: String = String("flag_")
    
//    func TextToSet(cell: UITableViewCell) -> String{
//
//                for index in 0...Countrys.count-1 {
//                    if cell.textLabel?.text == Countrys[index].koreanName {
//                        return Countrys[index].assetName
//                    }
//                }
//        return "No Data !"
//    }

    //MARK: ControlView didLoad preparation
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let jsonDecoder: JSONDecoder = JSONDecoder()
        guard let dataAsset: NSDataAsset = NSDataAsset(name: "countries") else {
            print("error")
            return }
        
        do {
             self.Countrys = try jsonDecoder.decode([Country].self, from: dataAsset.data)
        } catch {
            print(error.localizedDescription)
        }
        self.tableView.rowHeight = 60
        self.tableView.reloadData()
    }
    
    
    //MARK: tableView setting
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Countrys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath)
        
        let country: Country = self.Countrys[indexPath.row]

        cell.textLabel?.text = country.koreanName
        
        let image: UIImage = UIImage(named: nicName + country.assetName)!
        uiImageView = UIImageView(image: image)
        cell.imageView?.image = uiImageView.image
        
        return cell
    }
    
    
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        guard let nextViewcontroller: SecondViewController = segue.destination as? SecondViewController else {
            return
        }
        
        guard let cell: UITableViewCell = sender as? UITableViewCell else {
            return
        }
        nextViewcontroller.title = cell.textLabel?.text
        
        for index in 0...Countrys.count-1 {
            if cell.textLabel?.text == Countrys[index].koreanName {
                nextViewcontroller.NaviInfomation = Countrys[index].assetName
            }
        }
    }
    



}

