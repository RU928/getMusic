//
//  rankTableViewCell.swift
//  getMusic
//
//  Created by 田村崚 on 2017/05/13.
//  Copyright © 2017年 ryo.tamura. All rights reserved.
//

import UIKit

class rankTableViewCell: UITableViewCell {
    
    @IBOutlet weak var rankNumberLabel: UILabel!
    @IBOutlet weak var imageVIew: UIImageView!
    @IBOutlet weak var playCountLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
