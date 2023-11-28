//
//  HorizontalViewController.swift
//  dandeprojects
//
//  Created by dande reddyprasad on 14/04/18.
//  Copyright © 2018 dande reddyprasad. All rights reserved.
//

import UIKit

class HorizontalViewController: UIViewController ,UICollectionViewDelegate,UICollectionViewDataSource{

    @IBOutlet weak var mycollectionview: UICollectionView!
    var imagearray = [UIImage(named: "1"),UIImage(named: "2"),UIImage(named: "3"),UIImage(named: "4"),UIImage(named: "5"),UIImage(named: "6"),UIImage(named: "7"),UIImage(named: "8"),UIImage(named: "9")]
    override func viewDidLoad() {
        super.viewDidLoad()

        let imagesize = UIScreen.main.bounds.width/3 - 3
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsetsMake(20, 0, 10, 0)
        layout.itemSize = CGSize(width: imagesize, height: imagesize)
        
        layout.minimumLineSpacing = 3
        layout.minimumInteritemSpacing = 3
        mycollectionview.collectionViewLayout = layout
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imagearray.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCollectionViewCell", for: indexPath) as! ImageCollectionViewCell
        cell.imgImage.image = imagearray[indexPath.row]
       // cell.ImgImage.layer.borderWidth = 1
        cell.imgImage.layer.masksToBounds = false
       // cell.ImgImage.layer.borderColor = UIColor.black
        cell.imgImage.layer.cornerRadius = cell.imgImage.frame.height/2
        cell.imgImage.clipsToBounds = true
        return cell
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
