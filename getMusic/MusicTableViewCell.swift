//
//  MusicTableViewCell.swift
//  getMusic
//
//  Created by 田村崚 on 2017/05/09.
//  Copyright © 2017年 ryo.tamura. All rights reserved.
//

import UIKit

class MusicTableViewCell: UITableViewCell {
    
    @IBOutlet weak var MusicImageView: UIImageView!
    
    @IBOutlet weak var musicAlbumLabel: UILabel!
    
    @IBOutlet weak var musicMusicLabel: UILabel!
    
    @IBOutlet weak var musicArtistLabel: UILabel!
    
    @IBOutlet weak var handlePlayButton: UIButton!
    @IBOutlet weak var handleStopButton: UIButton!
    
    var music: AnyObject!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
