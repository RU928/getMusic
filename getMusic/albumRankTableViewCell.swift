//
//  albumRankTableViewCell.swift
//  getMusic
//
//  Created by 田村崚 on 2017/05/17.
//  Copyright © 2017年 ryo.tamura. All rights reserved.
//

import UIKit

class albumRankTableViewCell: UITableViewCell {

    @IBOutlet weak var albumImageView: UIImageView!
    @IBOutlet weak var blackImageView: UIImageView!
    @IBOutlet weak var rankNumberLabel: UILabel!
    @IBOutlet weak var albumPlayCountLabel: UILabel!
    @IBOutlet weak var albumPlayTimeLabel: UILabel!
    
    @IBOutlet weak var ArtistLabel: UILabel!
    @IBOutlet weak var albumTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        albumImageView.layer.cornerRadius = 22.5
        blackImageView.layer.cornerRadius = 22.5
        albumImageView.layer.masksToBounds = true
        self.blackImageView.layer.masksToBounds = true
        if albumImageView.image == nil{
            albumImageView.backgroundColor = UIColor.gray
        }

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
