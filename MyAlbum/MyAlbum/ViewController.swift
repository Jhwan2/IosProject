//
//  ViewController.swift
//  MyAlbum
//
//  Created by 이주환 on 2022/08/13.
//

import UIKit
import Photos

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    

    @IBOutlet weak var collectionView: UICollectionView!
    var fetchResult: PHFetchResult<PHCollection>! // 불러온 이미지의 배열
    let imageManager: PHCachingImageManager = PHCachingImageManager() //이미지 에셋 관리
    let cellIdentifier: String = "FirstCell" //식별용
    
    func requestCollection(){

        let cameraRoll: PHFetchResult<PHCollectionList> = PHCollectionList.fetchCollectionLists(with: .folder, subtype: .regularFolder, options: nil) // 앨범 검색 ?

        guard let cameraRollColletion = cameraRoll.firstObject else { return }

        let fetchOptions = PHFetchOptions() //에셋 또는 컬렉션 객체를 가져올 때 Photos에서 반환하는 결과에 필터링, 정렬 등 영향을 주는 옵션입니다.
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "localizedTitle", ascending: false)]
        self.fetchResult = PHAssetCollection.fetchCollections(in: cameraRollColletion, options: fetchOptions)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.fetchResult.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: FirstCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! FirstCollectionViewCell
        
        let asset: PHCollection = fetchResult.object(at: indexPath.item)
        
        imageManager.requestImage(for: asset, targetSize: CGSize(width: 30, height: 30), contentMode: .aspectFill, options: nil, resultHandler: {image, _ in cell.imageView.image = image })
        return cell
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

