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

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    //MARK: Property
    @IBOutlet private var collectionView: UICollectionView!
    var customAlbum: [PHAssetCollection] = []
    
    var fetchResult: PHFetchResult<PHAsset>!
    let imageManager: PHCachingImageManager = PHCachingImageManager() //이미지 에셋 관리
    let cellIdentifier: String = "FirstCell" //식별용

    
    //MARK: Photo load Method
    func requestCollection(){
        
        let fetchOptions = PHFetchOptions() //에셋 또는 컬렉션 객체를 가져올 때 Photos에서 반환하는 결과에 필터링, 정렬 등 영향을 주는 옵션입니다.
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "startDate", ascending: false)]
        
        customAlbum.removeAll()
        let result = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .albumRegular, options: fetchOptions)
        let result2 = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .albumRegular, options: fetchOptions)

        
        result.enumerateObjects({ (collection, _, _) in
            if (collection.hasAssets()) {
                self.customAlbum.append(collection)
            }
        })
        result2.enumerateObjects({ (collection, _, _) in
            if (collection.hasAssets()) {
                self.customAlbum.append(collection)
            }
        })

    }
    // MARK: - Controller lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let flowLayout: UICollectionViewFlowLayout
        flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets.zero
        flowLayout.minimumInteritemSpacing = 5
        flowLayout.minimumLineSpacing = 5
        let halfWidth: CGFloat = UIScreen.main.bounds.width / 2.0
        flowLayout.itemSize = CGSize(width: halfWidth - 30, height: 200)
        
        self.collectionView.collectionViewLayout = flowLayout
        
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
    
    // MARK: - UICollectionView Method
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return customAlbum.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: FirstCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! FirstCollectionViewCell
        
        
//        let collection: PHCollection = userCollections.object(at: indexPath.item)
//        guard let assetCollection = collection as? PHAssetCollection
//            else { fatalError("Expected an asset collection.") }
        
        
        fetchResult = PHAsset.fetchAssets(in: customAlbum[indexPath.item], options: nil)
        cell.album = fetchResult
        print(cell.album.count)

        let asset = fetchResult.firstObject

        imageManager.requestImage(for: asset!, targetSize: CGSize(width: 30, height: 30), contentMode: .aspectFill, options: nil, resultHandler: { image, _ in cell.ImageView.image = image })
        cell.nameLabel.text = customAlbum[indexPath.row].localizedTitle
        cell.numLabel.text = String(fetchResult.count)
        return cell
    }
            

    
    // MARK: - Segue

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        guard let nextViewcontroller: SecondViewController = segue.destination as? SecondViewController else {
            return
        }
        
        guard let cell: FirstCollectionViewCell = sender as? FirstCollectionViewCell else {
            return
        }
        nextViewcontroller.title = cell.nameLabel.text
        print("@@@@@@@@@@@@@@@@@@")
        print(cell.album.count)
        nextViewcontroller.selectAlbum = cell.album

    }
    


}

