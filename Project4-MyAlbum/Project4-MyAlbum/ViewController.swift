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

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    //MARK: Property
    @IBOutlet private var collectionView: UICollectionView!
    var customAlbum: [PHAssetCollection] = []
    
    var fetchResult: PHFetchResult<PHAsset>!
    let imageManager: PHCachingImageManager = PHCachingImageManager() //이미지 에셋 관리
    let cellIdentifier: String = "FirstCell" //식별용
    let numbeOfItemsInRow = 10

    
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

        let asset = fetchResult.firstObject

        imageManager.requestImage(for: asset!, targetSize: CGSize(width: 30, height: 30), contentMode: .aspectFill, options: nil, resultHandler: { image, _ in cell.ImageView.image = image
//            cell.ImageView.layer.cornerRadius = cell.ImageView.frame.width/15
//            cell.ImageView.clipsToBounds = true
        })
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
        nextViewcontroller.selectAlbum = cell.album

    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        //return UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        return UIEdgeInsets.init(top: 20, left: 20, bottom: 20, right: 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (Int(UIScreen.main.bounds.size.width) - (numbeOfItemsInRow - 1) * 10 - 40) / numbeOfItemsInRow
        return CGSize(width: width, height: width + 36)
    }
    
    


}

