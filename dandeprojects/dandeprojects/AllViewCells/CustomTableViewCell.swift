//
//  CustomTableViewCell.swift
//  dandeprojects
//
//  Created by dande reddyprasad on 14/04/18.
//  Copyright © 2018 dande reddyprasad. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet weak var streamType: UILabel!
    @IBOutlet weak var Tabletext: UILabel!
    @IBOutlet weak var tableimage: UIImageView!
    @IBOutlet weak var cellView: UIView!
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
