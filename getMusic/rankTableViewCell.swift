//
//  rankTableViewCell.swift
//  getMusic
//
//  Created by 田村崚 on 2017/05/13.
//  Copyright © 2017年 ryo.tamura. All rights reserved.
//

import UIKit

class rankTableViewCell: UITableViewCell {
    
    @IBOutlet weak var blackImageView: UIImageView!
    @IBOutlet weak var rankNumberLabel: UILabel!
    @IBOutlet weak var imageVIew: UIImageView!
    @IBOutlet weak var playCountLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        blackImageView.image = UIImage(named: "black")
        imageVIew.layer.cornerRadius = 25
        blackImageView.layer.cornerRadius = 25
        self.imageVIew.layer.masksToBounds = true
        self.blackImageView.layer.masksToBounds = true
        if imageVIew.image == nil{
            imageVIew.backgroundColor = UIColor.gray
        }


    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
