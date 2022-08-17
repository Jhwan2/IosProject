//
//  ViewController.swift
//  Project4-MyAlbum
//
//  Created by 이주환 on 2022/08/15.
//

import UIKit
import Photos

extension PHAssetCollection {
    
    // MARK: - Public methods
    func hasAssets() -> Bool {
        let assets = PHAsset.fetchAssets(in: self, options: nil)
        return assets.count > 0
    }
    
}

class ViewController: UIViewController, UICollectionViewDataSource {
    
    @IBOutlet private var collectionView: UICollectionView!
    var customAlbum: [PHAssetCollection] = []
    
    var fetchResult: PHFetchResult<PHAsset>!
    let imageManager: PHCachingImageManager = PHCachingImageManager() //이미지 에셋 관리
    let cellIdentifier: String = "FirstCell" //식별용

    
    //MARK: Photo load Method
    func requestCollection(){
        
        customAlbum.removeAll()
        let result = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .albumRegular, options: nil)
//        let result2 = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .smartAlbumUserLibrary, options: nil)
        result.enumerateObjects({ (collection, _, _) in
            if (collection.hasAssets()) {
                self.customAlbum.append(collection)
            }
        })
//        result2.enumerateObjects({ (collection, _, _) in
//            if (collection.hasAssets()) {
//                self.customAlbum.append(collection)
//            }
//        })

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let photoAurhorizationStatus = PHPhotoLibrary.authorizationStatus()
        
        switch photoAurhorizationStatus {
        case .authorized:
            print("access complite")
            self.requestCollection()
            self.collectionView.reloadData()
        case .denied:
            print("access Fail")
            
        case .notDetermined:
            print("before access")
            PHPhotoLibrary.requestAuthorization({ (status) in
                switch status {
                case .authorized:
                    print("user allow")
                    self.requestCollection()
                    OperationQueue.main.addOperation {
                        self.collectionView.reloadData()
                    }
                case .denied:
                    print("user not allow")
                default: break
                }
            })
        case .restricted:
            print("error ")
        case .limited:
            print("??")
        @unknown default:
            print("de end ??")
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //print(userCollections.count)
        return customAlbum.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: FirstCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! FirstCollectionViewCell
        
        
//        let collection: PHCollection = userCollections.object(at: indexPath.item)
//        guard let assetCollection = collection as? PHAssetCollection
//            else { fatalError("Expected an asset collection.") }

        fetchResult = PHAsset.fetchAssets(in: customAlbum[indexPath.item], options: nil)

        let asset = fetchResult.object(at: indexPath.item)
        
        imageManager.requestImage(for: asset, targetSize: CGSize(width: 30, height: 30), contentMode: .aspectFill, options: nil, resultHandler: { image, _ in cell.ImageView.image = image })
        
        
        cell.nameLabel.text = customAlbum[indexPath.row].localizedTitle
        cell.numLabel.text = String(fetchResult.count)
        return cell
    }
            




}

