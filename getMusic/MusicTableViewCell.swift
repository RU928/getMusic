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
    
    @IBOutlet weak var blackImageView: UIImageView!
    
    @IBOutlet weak var musicAlbumLabel: UILabel!
    
    @IBOutlet weak var musicMusicLabel: UILabel!
    
    @IBOutlet weak var musicArtistLabel: UILabel!
    
    @IBOutlet weak var handlePlayButton: UIButton!
    
    var music: AnyObject!
    
    var playOrStop: Int = 0

    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.MusicImageView.layer.cornerRadius = 40
        self.handlePlayButton.layer.cornerRadius = 40
        self.blackImageView.layer.cornerRadius = 40
        
        self.MusicImageView.layer.masksToBounds = true
        self.handlePlayButton.layer.masksToBounds = true
        self.blackImageView.layer.masksToBounds = true
        
        blackImageView.image = UIImage(named: "black")
        
        
        

        
        if musicAlbumLabel.text == nil {
            musicAlbumLabel.text = "不明なアルバム"
        }
        
        if musicArtistLabel.text == nil {
           musicArtistLabel.text = "不明なアーティスト"
        }
        
        if musicMusicLabel.text == nil {
            musicMusicLabel.text = "不明な曲"
        }
        }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
