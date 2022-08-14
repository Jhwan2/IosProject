//
//  ViewController.swift
//  MyAlbum
//
//  Created by 이주환 on 2022/08/13.
//

import UIKit
import Photos

class ViewController: UIViewController, UICollectionViewDataSource,UICollectionViewDelegate {
    

    @IBOutlet weak var collectionView: UICollectionView!
    var fetchResult: PHFetchResult<PHAsset>! // 불러온 이미지의 배열
    let imageManager: PHCachingImageManager = PHCachingImageManager() //이미지 에셋 관리
    let cellIdentifier: String = "FirstCell" //식별용
    
    
    var allPhotos: PHFetchResult<PHAsset>!
    var smartAlbums: PHFetchResult<PHAssetCollection>!
    var userCollections: PHFetchResult<PHCollection>!
    enum Section: Int {
        case allPhotos = 0
        case smartAlbums
        case userCollections
        
        static let count = 3
    }
    
    
    
    func requestCollection(){
        
        

        let cameraRoll: PHFetchResult<PHAssetCollection> = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .smartAlbumUserLibrary, options: nil) // 앨범 검색 ?

        guard let cameraRollColletion = cameraRoll.firstObject else { return }

        let fetchOptions = PHFetchOptions() //에셋 또는 컬렉션 객체를 가져올 때 Photos에서 반환하는 결과에 필터링, 정렬 등 영향을 주는 옵션입니다.
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        self.fetchResult = PHAsset.fetchAssets(in: cameraRollColletion, options: fetchOptions)
        
        
        let allPhotosOptions = PHFetchOptions()
        allPhotosOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]
        allPhotos = PHAsset.fetchAssets(with: allPhotosOptions)
        smartAlbums = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .albumRegular, options: nil)
        userCollections = PHCollectionList.fetchTopLevelUserCollections(with: nil)

    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return Section.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch Section(rawValue: section)! {
        case .allPhotos: return 1
        case .smartAlbums: return smartAlbums.count
        case .userCollections: return userCollections.count
        }
        //return self.fetchResult?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: FirstCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! FirstCollectionViewCell
        switch Section(rawValue: indexPath.section)! {
        case .allPhotos:
            cell.nameLabel.text = NSLocalizedString("All Photos", comment: "")
            cell.numOfCountLabel.text = String(allPhotos.count)
            return cell
            
        case .smartAlbums:
            let collection: PHCollection = smartAlbums.object(at: indexPath.item)
//            guard let assetCollection = collection as? PHAssetCollection
//                else { fatalError("Expected an asset collection.") }
//
//            fetchResult = PHAsset.fetchAssets(in: assetCollection, options: nil)
//
//            let asset = fetchResult.object(at: indexPath.item)
//
//            imageManager.requestImage(for: asset, targetSize: CGSize(width: 30, height: 30), contentMode: .aspectFill, options: nil, resultHandler: { image, _ in cell.imageView.image = image })
            
            cell.nameLabel.text = collection.localizedTitle
            cell.numOfCountLabel.text = String(smartAlbums.count)
            
            return cell
            
        case .userCollections:
            let collection = userCollections.object(at: indexPath.row)
            cell.nameLabel.text = collection.localizedTitle
            cell.numOfCountLabel.text = String(userCollections.count)
            return cell
        }
        
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

}

