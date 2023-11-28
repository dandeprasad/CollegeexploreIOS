//
//  FestsViewController.swift
//  dandeprojects
//
//  Created by dande reddyprasad on 20/04/18.
//  Copyright © 2018 dande reddyprasad. All rights reserved.
//

import UIKit
import AACarousel
import Kingfisher
class FestsViewController: UIViewController,AACarouselDelegate ,UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    var titleArray = [String]()
    @IBOutlet weak var mycollectionview: UICollectionView!

   
    @IBOutlet weak var nearby: UICollectionView!
    
    @IBOutlet weak var festscrollview: UIScrollView!
    


    
    let elements=["horse","potato","horse","horse","horse","horse","horse","horse"]
    var imagearray = [UIImage(named: "1"),UIImage(named: "2"),UIImage(named: "3"),UIImage(named: "4"),UIImage(named: "5"),UIImage(named: "6"),UIImage(named: "7"),UIImage(named: "8"),UIImage(named: "9")]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nearby.bounces=false
        
       let layout1 = UICollectionViewFlowLayout()
//            let layout2 = UICollectionViewFlowLayout()
        
//        mycollectionview.delegate = self
//        festNearBycollView.delegate = self
//
//        mycollectionview.dataSource = self
//        festNearBycollView.dataSource = self
//festNearBycollView.collectionViewLayout.invalidateLayout()
////        mycollectionview.collectionViewLayout=layout2
//          mycollectionview.register(FestFilterCollectionViewCell.self, forCellWithReuseIdentifier: "cell1")
//////        self.view.addSubview(collectionViewA)
//////        self.view.addSubview(collectionViewB)
////
        let imagesize = UIScreen.main.bounds.width/2 - 2

        layout1.sectionInset = UIEdgeInsetsMake(20, 0, 10, 0)
        layout1.itemSize = CGSize(width: imagesize, height: imagesize)

        layout1.minimumLineSpacing = 2
        layout1.minimumInteritemSpacing = 2
        nearby.collectionViewLayout = layout1
////
//       festNearBycollView.register(FestNearbyCollectionViewCell.self, forCellWithReuseIdentifier: "cell2")
//        self.view.addSubview(festNearBycollView)
//          self.view.addSubview(mycollectionview)
       //collectionview ends
        
  
        
       
        let pathArray = ["http://www.gettyimages.ca/gi-resources/images/Embed/new/embed2.jpg",
                         "http://www.gettyimages.ca/gi-resources/images/Embed/new/embed2.jpg",
                         "https://imgct2.aeplcdn.com/img/800x600/car-data/big/honda-amaze-image-12749.png",
                         "http://www.gettyimages.ca/gi-resources/images/Embed/new/embed2.jpg",
                         "http://www.gettyimages.ca/gi-resources/images/Embed/new/embed2.jpg"]
        titleArray = []
        carouselView.delegate = self
        carouselView.setCarouselData(paths: pathArray,  describedTitle: titleArray, isAutoScroll: true, timer: 5.0, defaultImage: "defaultImage")
        //optional methods
        carouselView.setCarouselOpaque(layer: false, describedTitle: false, pageIndicator: false)
        carouselView.setCarouselLayout(displayStyle: 0, pageIndicatorPositon: 2, pageIndicatorColor: ServerUtility().hexStringToUIColor(hex: "#FF0000",alp: 1.0), describedTitleColor: nil, layerColor: ServerUtility().hexStringToUIColor(hex: "#000000",alp: 0.0))
        
    }
    //require method
    func downloadImages(_ url: String, _ index: Int) {
        
        //here is download images area
        let imageView = UIImageView()
        imageView.kf.setImage(with: URL(string: url)!, placeholder: UIImage.init(named: "defaultImage"), options: [.transition(.fade(0))], progressBlock: nil, completionHandler: { (downloadImage, error, cacheType, url) in
            self.carouselView.images[index] = downloadImage!
        })
    }
    //optional method (interaction for touch image)
    func didSelectCarouselView(_ view: AACarousel ,_ index: Int) {
        
        let alert = UIAlertView.init(title:"Alert" , message: titleArray[index], delegate: self, cancelButtonTitle: "OK")
        alert.show()
        
        //startAutoScroll()
        //stopAutoScroll()
    }
    
    //optional method (show first image faster during downloading of all images)
    func callBackFirstDisplayView(_ imageView: UIImageView, _ url: [String], _ index: Int) {
        
        imageView.kf.setImage(with: URL(string: url[index]), placeholder: UIImage.init(named: "defaultImage"), options: [.transition(.fade(1))], progressBlock: nil, completionHandler: nil)
        
    }
    
    func startAutoScroll() {
        //optional method
        carouselView.startScrollImageView()
        
    }
    
    func stopAutoScroll() {
        //optional method
        carouselView.stopScrollImageView()
    }
    @IBOutlet weak var carouselView: AACarousel!
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
        
        
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.mycollectionview {
            return elements.count // Replace with count of your data for collectionViewA
        }
        return imagearray.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        if collectionView == self.nearby {
            let cell2 = collectionView.dequeueReusableCell(withReuseIdentifier: "festdande", for: indexPath) as! FestNearbyCollectionViewCell
            cell2.festNearBy.image = imagearray[indexPath.row]
            // cell.ImgImage.layer.borderWidth = 1
            cell2.festNearBy.layer.masksToBounds = false
            // cell.ImgImage.layer.borderColor = UIColor.black
            cell2.festNearBy.layer.cornerRadius = cell2.festNearBy.frame.height/2
            cell2.festNearBy.clipsToBounds = true
            return cell2
            
        }
     else  {
            let cell1 = collectionView.dequeueReusableCell(withReuseIdentifier: "festfilterIdentifier", for: indexPath) as! FestFilterCollectionViewCell
            cell1.festFilter.setTitle(elements[indexPath.row], for: UIControlState.normal)
            cell1.festFilter.layer.borderWidth = 1
            cell1.festFilter.layer.masksToBounds = false
            let colortoapply = ServerUtility().hexStringToUIColor(hex: "#000000",alp: 1.0)
            cell1.festFilter.layer.borderColor = colortoapply.cgColor
            cell1.festFilter.layer.cornerRadius = cell1.festFilter.frame.height/2
            cell1.festFilter.clipsToBounds = true
            
            return cell1
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
