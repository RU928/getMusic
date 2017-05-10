//
//  PlayViewController.swift
//  getMusic
//
//  Created by 田村崚 on 2017/05/10.
//  Copyright © 2017年 ryo.tamura. All rights reserved.
//

import UIKit
import AVFoundation
import MediaPlayer

class PlayViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var player = MPMusicPlayerController()
    
    let albumsQuery = MPMediaQuery.songs()
    
    let predicate = MPMediaPropertyPredicate(value: 3, forProperty: MPMediaItemPropertyPlayCount, comparisonType: MPMediaPredicateComparison.equalTo)
    

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = false
        
        let nib = UINib(nibName: "MusicTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "Cell")
        tableView.rowHeight = UITableViewAutomaticDimension

        
        player = MPMusicPlayerController.applicationMusicPlayer()
        
        albumsQuery.addFilterPredicate(predicate)
        
        if let collections = albumsQuery.collections {
            for collection in collections {
                
                if let representativeTitle = collection.representativeItem!.title {
                    print("曲名: \(representativeTitle)  再生回数: \(collection.representativeItem!.playCount)")
                }
            }
        }///if let collections = albumsQuery.col
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (albumsQuery.collections?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // セルを取得してデータを設定する
        let music = albumsQuery.collections?[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath as IndexPath) as! MusicTableViewCell
        
        ///セルの値設定
        let image = music?.representativeItem?.artwork?.image(at: cell.MusicImageView.bounds.size)
        
        cell.MusicImageView?.image = image
        cell.musicAlbumLabel?.text = music?.representativeItem?.albumTitle
        cell.musicMusicLabel?.text = music?.representativeItem?.title
        cell.musicArtistLabel?.text = music?.representativeItem?.artist
        cell.music = music
        

        cell.handlePlayButton.addTarget(self, action:#selector(handlePlayButton(sender:event:)), for:  UIControlEvents.touchUpInside)
        
        cell.handleStopButton.addTarget(self, action:#selector(handleStopButton(sender:event:)), for:  UIControlEvents.touchUpInside)
        
        return cell
    }
    
    func handlePlayButton (sender: UIButton, event:UIEvent) {
        let touch = event.allTouches?.first
        let point = touch!.location(in: self.tableView)
        let indexPath = tableView.indexPathForRow(at: point)
        
        // 配列からタップされたインデックスのデータを取り出す
        let query = albumsQuery.collections?[indexPath!.row]
        
        // プレイヤーにqueryから作成したキューをセット
        // (playerはMPMusicPlayerControllerのインスタンスを示す)
        player.setQueue(with: query!)
        player.play()

    }
    
    func handleStopButton (sender: UIButton, event:UIEvent) {
        player.stop()
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        // Auto Layoutを使ってセルの高さを動的に変更する
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // セルをタップされたら何もせずに選択状態を解除する
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
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
