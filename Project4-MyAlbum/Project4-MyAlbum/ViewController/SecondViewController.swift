//
//  SecondViewController.swift
//  Project4-MyAlbum
//
//  Created by 이주환 on 2022/08/15.
//

import UIKit
import Photos

class SecondViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    //MARK: Outlet & Vars & Lets
    @IBOutlet var collectionView: UICollectionView!
    
    var selectAlbum: PHFetchResult<PHAsset>!
    let Identifier: String = "SecondCell"
    private var myAlbum: PHFetchResult<PHAsset>!
    let imageManager: PHCachingImageManager = PHCachingImageManager()
    private let numbeOfItemsInRow = 3
    
    let dateFormatter: DateFormatter = {
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = "yyyy - MM - dd"
        return formatter
    }()
    let timeFormatter: DateFormatter = {
        let formatter: DateFormatter = DateFormatter()
        formatter.locale = Locale(identifier:"ko_KR")
        formatter.dateFormat = "a hh : mm "
        return formatter
    }()
    
    // MARK: - Controller lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.myAlbum = selectAlbum
        // Do any additional setup after loading the view.
    }
    // MARK: - UICollectionView setting
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if myAlbum.count != 0{
            return myAlbum.count
        }
        else{
            return 0
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: SecondCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifier, for: indexPath) as! SecondCollectionViewCell
        
        cell.imageView.contentMode = .scaleToFill
        let asset = selectAlbum.object(at: indexPath.item)
        let option = PHImageRequestOptions()
        option.deliveryMode = .fastFormat
        
        cell.selectImage = asset
        
        imageManager.requestImage(for: asset, targetSize: CGSize(width: cell.frame.width, height: cell.frame.height), contentMode: .aspectFill, options: option, resultHandler: { image, _ in
            cell.imageView.image = image
        })
        
        return cell
    }
    
    
    // MARK: collectionView FlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 20, left: 20, bottom: 20, right: 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (Int(UIScreen.main.bounds.size.width) - (numbeOfItemsInRow - 1) * 6 - 40) / numbeOfItemsInRow
        return CGSize(width: width, height: width)
    }

    
    // MARK: - Segue
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        guard let nextViewcontroller: ThirdViewController = segue.destination as? ThirdViewController else {
            return
        }
        
        guard let cell: SecondCollectionViewCell = sender as? SecondCollectionViewCell else {
            return
        }
        nextViewcontroller.imageAsset = cell.selectImage
        nextViewcontroller.DateTitle = dateFormatter.string(from: cell.selectImage.creationDate ?? Date())
        nextViewcontroller.timeTitle = timeFormatter.string(from: cell.selectImage.creationDate ?? Date())
  
    }
    

}
