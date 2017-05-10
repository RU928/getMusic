//
//  ViewController.swift
//  getMusic
//
//  Created by 田村崚 on 2017/05/09.
//  Copyright © 2017年 ryo.tamura. All rights reserved.
//

import UIKit
import AVFoundation
import MediaPlayer

class ViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var arbamLabel: UILabel!
    @IBOutlet weak var songLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    
    var player = MPMusicPlayerController()
    
    let albumsQuery = MPMediaQuery.songs()
    
    let predicate = MPMediaPropertyPredicate(value: 3, forProperty: MPMediaItemPropertyPlayCount, comparisonType: MPMediaPredicateComparison.equalTo)
    
    var music : [AnyObject] = []
    
   
    

    
    @IBAction func handlePlayButton(_ sender: Any) {
        
        let query = albumsQuery.collections?[3]
        // プレイヤーにqueryから作成したキューをセット
        // (playerはMPMusicPlayerControllerのインスタンスを示す)
        player.setQueue(with: query!)
        player.play()
    }
    
    @IBAction func handleStopLabel(_ sender: Any) {
        player.stop()
    }
    
    

    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        player = MPMusicPlayerController.applicationMusicPlayer()
        
        albumsQuery.addFilterPredicate(predicate)
        
        if let collections = albumsQuery.collections {
            for collection in collections {
            
                if let representativeTitle = collection.representativeItem!.title {
                    print("曲名: \(representativeTitle)  再生回数: \(collection.representativeItem!.playCount)")
                    music.append(collection.representativeItem!)
                }
     
                
            }
        }///if let collections = albumsQuery.collections
    }///view Did Load

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateSongInformationUI(mediaItem: MPMediaItem) {
        arbamLabel.text = mediaItem.albumTitle ?? "不明なアルバム"
        songLabel.text = mediaItem.title ?? "不明な曲"
        artistLabel.text = mediaItem.artist ?? "不明なアーティスト"
        
        if let artwork = mediaItem.artwork {
            let image = artwork.image(at: imageView.bounds.size)
            imageView.image = image
        }else{
            imageView.image = nil
            imageView.backgroundColor = UIColor.black
        }
    }
    
   

}

