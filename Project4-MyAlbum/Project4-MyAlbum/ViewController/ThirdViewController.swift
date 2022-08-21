//
//  ThirdViewController.swift
//  Project4-MyAlbum
//
//  Created by 이주환 on 2022/08/21.
//

import UIKit
import Photos

extension UINavigationItem {
    func setTitle(title:String, subtitle:String) {
        
        let one = UILabel()
        one.text = title
        one.font = UIFont.boldSystemFont(ofSize: 17)
        one.sizeToFit()
        
        let two = UILabel()
        two.text = subtitle
        two.font = UIFont.systemFont(ofSize: 12)
        two.textAlignment = .center
        two.textColor = UIColor.gray
        two.sizeToFit()
        
        let stackView = UIStackView(arrangedSubviews: [one, two])
        stackView.distribution = .equalCentering
        stackView.axis = .vertical
        stackView.alignment = .center
        
        let width = max(one.frame.size.width, two.frame.size.width)
        stackView.frame = CGRect(x: 0, y: 0, width: width, height: 35)
        
        one.sizeToFit()
        two.sizeToFit()
        
        self.titleView = stackView
    }
}

class ThirdViewController: UIViewController,UIGestureRecognizerDelegate {
    
    @IBOutlet var imageView: UIImageView!
    var imageAsset: PHAsset!
    let imageManager: PHCachingImageManager = PHCachingImageManager()
    var DateTitle: String!
    var timeTitle: String!
    
    var pinch = UIPinchGestureRecognizer()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.setTitle(title: DateTitle, subtitle: timeTitle)
        // Do any additional setup after loading the view.
        let option = PHImageRequestOptions()
        option.deliveryMode = .highQualityFormat
        
        imageManager.requestImage(for: self.imageAsset, targetSize: CGSize(width: self.imageView.frame.width, height: self.imageView.frame.height), contentMode: PHImageContentMode.aspectFit, options: option, resultHandler: { image, _ in
            self.imageView.image = image
        })
        
        pinch = UIPinchGestureRecognizer(target: self, action: #selector(ThirdViewController.doPinch(_:)))
           self.view.addGestureRecognizer(pinch)
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(ThirdViewController.handleTap(_:)))
            tapGR.delegate = self
            tapGR.numberOfTapsRequired = 2
            view.addGestureRecognizer(tapGR)
    }
    
    
    @objc func doPinch(_ pinch: UIPinchGestureRecognizer){

        imageView.transform = imageView.transform.scaledBy(x: pinch.scale, y: pinch.scale) // 이미지 imgPinch를 scale에 맞게 변환

        pinch.scale = 1 //다음 변환을 위하여 핀지의 스케일 속성을 1로 설정

    }
    
    @objc func handleTap(_ gesture: UITapGestureRecognizer){
       imageView.transform = CGAffineTransform.identity
   }
    
    @IBAction func ImageShare(_ sender: UIBarButtonItem) {
        
        let activityViewController = UIActivityViewController(activityItems: [self.imageView.image as Any], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)

    }
    

}
