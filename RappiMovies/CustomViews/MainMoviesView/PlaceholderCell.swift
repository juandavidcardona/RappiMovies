//
//  PlaceholderCell.swift
//  RappiMovies
//
//  Created by Juan on 11/12/18.
//  Copyright © 2018 Juand. All rights reserved.
//

import UIKit

class PlaceholderCell: UITableViewCell {

    @IBOutlet weak var mainView1: UIView!
    @IBOutlet weak var mainView2: UIView!
    @IBOutlet weak var shadow: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        shadow.layer.masksToBounds = false
        shadow.layer.cornerRadius = 10
        shadow.clipsToBounds = true
        
        mainView1.layer.masksToBounds = false
        mainView1.layer.cornerRadius = 20
        mainView1.clipsToBounds = true
        mainView2.layer.masksToBounds = false
        mainView2.layer.cornerRadius = 20
        mainView2.clipsToBounds = true    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
