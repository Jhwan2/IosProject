//
//  SecondViewController.swift
//  Project4-MyAlbum
//
//  Created by 이주환 on 2022/08/15.
//

import UIKit
import Photos

class SecondViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, PHPhotoLibraryChangeObserver {
    //MARK: Outlet & Vars & Lets
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet weak var actionButton: UIBarButtonItem!
    @IBOutlet weak var trashButton: UIBarButtonItem!
    
    var selectAlbum: PHFetchResult<PHAsset>!
    var myAlbum: PHFetchResult<PHAsset>!
    let imageManager: PHCachingImageManager = PHCachingImageManager()
    var empAlbum: PHFetchResult<PHAsset>!
    var albumName: String!
    var selectArray: [PHAsset]! = []
    
    private let Identifier: String = "SecondCell"
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
        // Do any additional setup after loading the view.
        self.collectionView.delegate = self
        self.albumName = self.navigationItem.title
        PHPhotoLibrary.shared().register(self)
    }
    
    // MARK: - UICollectionView setting
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.selectAlbum.count != 0{
            return self.selectAlbum.count
        }
        else{
            return 0
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell: SecondCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifier, for: indexPath) as? SecondCollectionViewCell ?? SecondCollectionViewCell()

        
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if !self.actionButton.isEnabled {
            performSegue(withIdentifier: "selectImage", sender: collectionView.cellForItem(at: indexPath))
        }
        else{
            collectionView.cellForItem(at: indexPath)?.alpha = 0.7
            collectionView.cellForItem(at: indexPath)?.backgroundColor = UIColor.black
            guard let cell = collectionView.cellForItem(at: indexPath) as? SecondCollectionViewCell else{ return }
            
            self.selectArray.append(cell.selectImage!)
        }
        
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
    
//MARK: bar button action
    @IBAction func sortButton(_ sender: UIBarButtonItem) {
        if sender.title == "최신순" {
            sender.title = "과거순"
            self.empAlbum = self.selectAlbum
            self.selectAlbum = self.myAlbum
            self.myAlbum = self.empAlbum
            self.collectionView.reloadData()
        }
        else {
            sender.title = "최신순"
            self.empAlbum = self.selectAlbum
            self.selectAlbum = self.myAlbum
            self.myAlbum = self.empAlbum
            self.collectionView.reloadData()
        }
    }
    
    @IBAction func selectButton(_ sender: UIBarButtonItem) {
        self.navigationItem.title = "항목선택"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "취소", style: .plain , target: self, action: #selector(cancelbtAction(_:)))
        self.trashButton.isEnabled = true
        self.actionButton.isEnabled = true
    }
    
    @objc func cancelbtAction(_ sender: UIBarButtonItem) -> Void {
        self.actionButton.isEnabled = false // 툴바버튼 비활성화
        self.trashButton.isEnabled = false
        self.navigationItem.rightBarButtonItem? = UIBarButtonItem(title: "선택", style: .plain , target: self, action: #selector(selectButton(_:)))

        self.navigationItem.title = self.albumName
            //저장배열 초기화
        selectArray.removeAll()
            //다중선택비활성
        self.collectionView.allowsMultipleSelection = false
            //선택값 삭제위한 리로드
        self.collectionView.reloadData()
        }
    
    @IBAction func actionBtn(_ sender: UIBarButtonItem){
        var shareImages: [UIImage]! = []
        for i in 0...selectArray.count-1 {
            let asset = self.selectArray[i]
            imageManager.requestImage(for: asset, targetSize: CGSize(width: PHImageManagerMaximumSize.width, height:PHImageManagerMaximumSize.height), contentMode: .aspectFill, options: nil, resultHandler: { image, _ in
            shareImages.append(image!)
        })
        }
        
        let activityViewController = UIActivityViewController(activityItems: shareImages, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    @IBAction func trashBtn(_ sender: UIBarButtonItem){
        
        PHPhotoLibrary.shared().performChanges({PHAssetChangeRequest.deleteAssets(self.selectArray as NSFastEnumeration)}, completionHandler: nil)
        
    }
    
    //MARK: photo Change Method
    func photoLibraryDidChange(_ changeInstance: PHChange) {
        guard let changes = changeInstance.changeDetails(for: selectAlbum) else { return }
        selectAlbum = changes.fetchResultAfterChanges  //바뀐값 다시 저장
                //바꼇으면 컬렉션뷰 다시 리로드
        OperationQueue.main.addOperation { self.collectionView.reloadData() }
    }

    
    
    // MARK: - Segue
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.s
        // Pass the selected object to the new view controller.
        if segue.identifier == "selectImage" {
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
    

}
