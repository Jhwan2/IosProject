//
//  ViewController.swift
//  BoxOfficeInProject5
//
//  Created by 이주환 on 2022/09/02.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var label: UILabel!
    var moVies: Movies!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
            }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        guard let url: URL = URL(string: "https://connect-boxoffice.run.goorm.io/movies?order_type=1") else{ print(" ??")
            return }
        let session: URLSession = URLSession(configuration: .default)
        let `dataTask`: URLSessionDataTask = session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
            if let error = error {
                print(error.localizedDescription)
            }
            guard let data = data else {
                return
            }
            let log = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
            print(log as Any)
            
            do {
                let apiDictionary = try JSONSerialization.jsonObject(with: data, options: [])
                print(apiDictionary)
                //let apiResponse: Movies = try JSONDecoder().decode(Movies.self, from: data)
                //let result = try JSONDecoder().decode(movie.self, from: data)
                //self.moVies = apiResponse
                //print(apiResponse.movies[0].title)
//                DispatchQueue.main.async {
//                    self.label.text = self.moVies.movies[0].title
//                }
                

            } catch(let err) {
                print(err.localizedDescription)
                DispatchQueue.main.async {
                    self.label.text = " ?? "
                }
            }
        
        }
        dataTask.resume()
        
    }
    
    


}

