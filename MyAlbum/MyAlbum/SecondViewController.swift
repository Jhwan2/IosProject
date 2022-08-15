//
//  SecondViewController.swift
//  MyAlbum
//
//  Created by 이주환 on 2022/08/15.
//

import UIKit
import Photos

class SecondViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    let imageManager = PHCachingImageManager()
    var availableWidth: CGFloat = 0
    var fetchResult: PHFetchResult<PHAsset>!
    var assetCollection: PHAssetCollection!
    @IBOutlet weak var collectionViewFlowLayout: UICollectionViewFlowLayout!
    fileprivate var thumbnailSize: CGSize!
    @IBOutlet weak var collectionView: UICollectionView!
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fetchResult.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let asset = fetchResult.object(at: indexPath.item)
        // Dequeue a GridViewCell.
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GridViewCell", for: indexPath) as? UICollectionViewCell
            else { fatalError("Unexpected cell in collection view") }
        
        imageManager.requestImage(for: asset, targetSize: thumbnailSize, contentMode: .aspectFill, options: nil, resultHandler: { image, _ in
            // UIKit may have recycled this cell by the handler's activation time.
            // Set the cell's thumbnail image only if it's still showing the same asset.
            //cell.largeContentImage?.images = image
            
        })
        return cell
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let columnCount = (availableWidth / 80).rounded(.towardZero)
        let itemLength = (availableWidth - columnCount - 1) / columnCount
        collectionViewFlowLayout.itemSize = CGSize(width: itemLength, height: itemLength)
        
        // Reaching this point without a segue means that this AssetGridViewController
        // became visible at app launch. As such, match the behavior of the segue from
        // the default "All Photos" view.
        if fetchResult == nil {
            let allPhotosOptions = PHFetchOptions()
            allPhotosOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]
            fetchResult = PHAsset.fetchAssets(with: allPhotosOptions)
        }
        
        self.collectionView.collectionViewLayout = collectionViewFlowLayout

        // Do any additional setup after loading the view.
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        let width = view.bounds.inset(by: view.safeAreaInsets).width
        // Adjust the item size if the available width has changed.
        if availableWidth != width {
            availableWidth = width
            let columnCount = (availableWidth / 80).rounded(.towardZero)
            let itemLength = (availableWidth - columnCount - 1) / columnCount
            collectionViewFlowLayout.itemSize = CGSize(width: itemLength, height: itemLength)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Determine the size of the thumbnails to request from the PHCachingImageManager.
        let scale = UIScreen.main.scale
        let cellSize = collectionViewFlowLayout.itemSize
        thumbnailSize = CGSize(width: cellSize.width * scale, height: cellSize.height * scale)
        
        // Add a button to the navigation bar if the asset collection supports adding content.
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
