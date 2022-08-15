//
//  ViewController.swift
//  Project4-MyAlbum
//
//  Created by 이주환 on 2022/08/15.
//

import UIKit
import Photos

class ViewController: UIViewController, UICollectionViewDataSource {
    
    @IBOutlet private var collectionView: UICollectionView!
    var allPhotos: PHFetchResult<PHAsset>! // 불러온 이미지의 배열
    var favoritePhotos: PHFetchResult<PHAssetCollection>!
    var userCollections: PHFetchResult<PHCollection>!
    var fetchResult: PHFetchResult<PHAsset>!
    let imageManager: PHCachingImageManager = PHCachingImageManager() //이미지 에셋 관리
    let cellIdentifier: String = "FirstCell" //식별용
    
    //MARK: Photo load Method
    func requestCollection(){

        let fetchOptions = PHFetchOptions() //에셋 또는 컬렉션 객체를 가져올 때 Photos에서 반환하는 결과에 필터링, 정렬 등 영향을 주는 옵션입니다.
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]

        
        allPhotos = PHAsset.fetchAssets(with: fetchOptions)
        favoritePhotos = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .albumRegular, options: nil)
        userCollections = PHCollectionList.fetchTopLevelUserCollections(with: nil)

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
        return favoritePhotos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: FirstCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! FirstCollectionViewCell
        
        let collection: PHCollection = favoritePhotos.object(at: indexPath.item)
        guard let assetCollection = collection as? PHAssetCollection
            else { fatalError("Expected an asset collection.") }

        fetchResult = PHAsset.fetchAssets(in: assetCollection, options: nil)

        let asset = fetchResult.object(at: indexPath.item)
        
        
        imageManager.requestImage(for: asset, targetSize: CGSize(width: 30, height: 30), contentMode: .aspectFill, options: nil, resultHandler: { image, _ in cell.ImageView.image = image })
        
        
        cell.nameLabel.text = collection.localizedTitle
        cell.numLabel.text = String(favoritePhotos.count)
        return cell
    }
            




}

