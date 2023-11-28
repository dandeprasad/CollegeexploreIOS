//
//  FestCollectionReusableView.swift
//  dandeprojects
//
//  Created by dande reddyprasad on 23/04/18.
//  Copyright © 2018 dande reddyprasad. All rights reserved.
//

import UIKit
import AACarousel
class FestCollectionReusableView: UICollectionReusableView,AACarouselDelegate {
      var titleArray = [String]()
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
    
    func downloadImages(_ url: String, _ index: Int) {
        //here is download images area
        let imageView = UIImageView()
        imageView.kf.setImage(with: URL(string: url)!, placeholder: UIImage.init(named: "defaultImage"), options: [.transition(.fade(0))], progressBlock: nil, completionHandler: { (downloadImage, error, cacheType, url) in
            self.carouselView1.images[index] = downloadImage!
        })
    }
    func startAutoScroll() {
        //optional method
        carouselView1.startScrollImageView()
        
    }
    
    func stopAutoScroll() {
        //optional method
        carouselView1.stopScrollImageView()
    }
        
    @IBOutlet weak var carouselView1: AACarousel!
  
}
