//
//  FestsViewController1.swift
//  dandeprojects
//
//  Created by dande reddyprasad on 23/04/18.
//  Copyright © 2018 dande reddyprasad. All rights reserved.
//

import UIKit
import AACarousel
import Kingfisher
class FestsViewController1: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    var titleArray = [String]()


    @IBOutlet weak var nearby1: UICollectionView!
    


    
  
    var imagearray = [UIImage(named: "1"),UIImage(named: "2"),UIImage(named: "3"),UIImage(named: "4"),UIImage(named: "5"),UIImage(named: "6"),UIImage(named: "7"),UIImage(named: "8"),UIImage(named: "9")]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nearby1.bounces=false
   
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
          layout1.headerReferenceSize = CGSize(width: UIScreen.main.bounds.width, height: 150)
        layout1.minimumLineSpacing = 2
        layout1.minimumInteritemSpacing = 2
        nearby1.collectionViewLayout = layout1
        
        ////
        //       festNearBycollView.register(FestNearbyCollectionViewCell.self, forCellWithReuseIdentifier: "cell2")
        //        self.view.addSubview(festNearBycollView)
        //          self.view.addSubview(mycollectionview)
        //collectionview ends
        
        
        
        


        
    }


    

    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
        
        
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return  1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        if collectionView == self.mycollectionview1 {
//            return elements.count // Replace with count of your data for collectionViewA
//        }
        return imagearray.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
       
            let cell2 = collectionView.dequeueReusableCell(withReuseIdentifier: "festdande1", for: indexPath) as! FestNearbyCollectionViewCell1
            cell2.festNearBy1.image = imagearray[indexPath.row]
            // cell.ImgImage1.layer.borderWidth = 1
            cell2.festNearBy1.layer.masksToBounds = false
            // cell.ImgImage1.layer.borderColor = UIColor.black
            cell2.festNearBy1.layer.cornerRadius = cell2.festNearBy1.frame.height/2
            cell2.festNearBy1.clipsToBounds = true
            return cell2
            
    }
//        else  {
//            let cell1 = collectionView.dequeueReusableCell(withReuseIdentifier: "festfilterIdentifier1", for: indexPath) as! FestFilterCollectionViewCell1
//            cell1.festFilter1.setTitle(elements[indexPath.row], for: UIControlState.normal)
//            cell1.festFilter1.layer.borderWidth = 1
//            cell1.festFilter1.layer.masksToBounds = false
//            let colortoapply = ServerUtility().hexStringToUIColor(hex: "#000000",alp: 1.0)
//            cell1.festFilter1.layer.borderColor = colortoapply.cgColor
//            cell1.festFilter1.layer.cornerRadius = cell1.festFilter1.frame.height/2
//            cell1.festFilter1.clipsToBounds = true
//
//            return cell1
//        }}
    
        func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
            let sectionHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Festsheader", for: indexPath) as! FestCollectionReusableView
            
            let pathArray = ["http://www.gettyimages.ca/gi-resources/images/Embed/new/embed2.jpg",
                             "http://www.gettyimages.ca/gi-resources/images/Embed/new/embed2.jpg",
                             "https://imgct2.aeplcdn.com/img/800x600/car-data/big/honda-amaze-image-12749.png",
                             "http://www.gettyimages.ca/gi-resources/images/Embed/new/embed2.jpg",
                             "http://www.gettyimages.ca/gi-resources/images/Embed/new/embed2.jpg"]
            titleArray = []
            
            sectionHeaderView.carouselView1.delegate = FestCollectionReusableView() as AACarouselDelegate
            sectionHeaderView.carouselView1.setCarouselData(paths: pathArray,  describedTitle: titleArray, isAutoScroll: true, timer: 5.0, defaultImage: "defaultImage")
            //optional methods
            sectionHeaderView.carouselView1.setCarouselOpaque(layer: false, describedTitle: false, pageIndicator: false)
            sectionHeaderView.carouselView1.setCarouselLayout(displayStyle: 0, pageIndicatorPositon: 2, pageIndicatorColor: ServerUtility().hexStringToUIColor(hex: "#FF0000",alp: 1.0), describedTitleColor: nil, layerColor: ServerUtility().hexStringToUIColor(hex: "#000000",alp: 0.0))
            return sectionHeaderView
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
