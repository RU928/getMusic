//
//  artistRankTableViewCell.swift
//  getMusic
//
//  Created by 田村崚 on 2017/05/18.
//  Copyright © 2017年 ryo.tamura. All rights reserved.
//

import UIKit

class artistRankTableViewCell: UITableViewCell {

    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var artistImageView: UIImageView!
    @IBOutlet weak var playDurationSumLabel: UILabel!
    @IBOutlet weak var playCountSumLabel: UILabel!
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var blackImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        artistImageView.layer.cornerRadius = 22.5
        blackImageView.layer.cornerRadius = 22.5
        artistImageView.layer.masksToBounds = true
        blackImageView.layer.masksToBounds = true
        if artistImageView.image == nil{
            artistImageView.backgroundColor = UIColor.gray
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
