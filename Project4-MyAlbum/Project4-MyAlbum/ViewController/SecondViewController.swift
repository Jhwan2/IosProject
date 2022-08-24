//
//  SecondViewController.swift
//  Project4-MyAlbum
//
//  Created by 이주환 on 2022/08/15.
//

import UIKit
import Photos

class SecondViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    //MARK: Outlet & Vars & Lets
    @IBOutlet var collectionView: UICollectionView!
    
    var selectAlbum: PHFetchResult<PHAsset>!
    private let Identifier: String = "SecondCell"
    var myAlbum: PHFetchResult<PHAsset>!
    let imageManager: PHCachingImageManager = PHCachingImageManager()
    var empAlbum: PHFetchResult<PHAsset>!
    
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //performSegue(withIdentifier: "selectImage", sender: nil)
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
        self.collectionView.allowsMultipleSelection = true
    }
    
    @objc func cancelbtAction(_ sender: UIBarButtonItem) -> Void {
//            self.actionToolbarItem.isEnabled = false // 툴바버튼 비활성화
//            self.trashToolbarItem.isEnabled = false
            self.navigationItem.hidesBackButton = false //백버튼비활성화
//            self.navigationItem.rightBarButtonItem = myrightBarButtonItem
            //저장배열 초기화
//            self.delete = [Int]()
            //다중선택비활성
            self.collectionView.allowsMultipleSelection = false
            //선택값 삭제위한 리로드
            self.collectionView.reloadData()
            
        }
    
    // MARK: - Segue
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.s
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
