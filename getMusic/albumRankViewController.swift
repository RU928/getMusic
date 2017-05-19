//
//  albumRankViewController.swift
//  getMusic
//
//  Created by 田村崚 on 2017/05/16.
//  Copyright © 2017年 ryo.tamura. All rights reserved.
//

import UIKit
import AVFoundation
import MediaPlayer


class albumRankViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var tableView: UITableView!
    let albumQuery = MPMediaQuery.albums()
    var albumTopTewnty: [MPMediaItemCollection] = []
    var topTwentyDuration: [Int] = []
    var albumPlayCount: [Int] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.allowsSelection = false
        let nib = UINib(nibName: "albumRankTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "Cell")
        tableView.estimatedRowHeight = 120
        tableView.rowHeight = UITableViewAutomaticDimension
        
        ///アルバムデータ取得
        ///総再生時間代入用リスト
        var playlengthList: [Int] = []
       
        for album in albumQuery.collections!{
            let albumTitle = album.representativeItem?.albumTitle
            var playSum = 0
            var playTime = 0
            var playLengthSum = 0
            var playLengthSumList = 0
            
            for count in album.items{
                let songsPlayCount = count.playCount
                playSum = playSum + songsPlayCount
                let duration: Int = Int(count.playbackDuration)
                playLengthSum = songsPlayCount * duration ///再生回数x曲の長さ
                playLengthSumList = playLengthSumList + playLengthSum
            }
            
            playlengthList.append(playLengthSumList)
            albumPlayCount.append(playSum)
            print("アルバム名：\((albumTitle)!)、総再生回数\(playSum)回、総再生時間\(playLengthSumList)")
        }
        ///ここまでアルバムデータ取得
        
        playlengthList.sort{$0 > $1}
        
        var number = 0
        if playlengthList.count < 19{
            number = playlengthList.count
        }else{
            number = 19
        }
        
        for i in 0...number{
            if playlengthList[i] >= 0{
                topTwentyDuration.append(playlengthList[i]) ///総再生時間を昇順に代入
                print(playlengthList[i])
            }
        }
        
        for topTwenty in topTwentyDuration{
            print("DEBUG: \(topTwenty)のアルバムを探す")
            for album in albumQuery.collections!{ ///前のやつと同じ処理
                let albumTitle = album.representativeItem?.albumTitle
                var playSum = 0
                var playTime = 0
                var playLengthSum = 0
                var playLengthSumList = 0
                
                for count in album.items{
                    let songsPlayCount = count.playCount
                    playSum = playSum + songsPlayCount
                    let duration: Int = Int(count.playbackDuration)
                    playLengthSum = songsPlayCount * duration ///再生回数x曲の長さ
                    playLengthSumList = playLengthSumList + playLengthSum
                }
                
                if topTwenty == playLengthSumList {
                    albumTopTewnty.append(album)
                    print("\(album.representativeItem?.albumTitle)が追加されました")
                }
            }///ここまで
        }
        
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(albumTopTewnty.count)
        return albumTopTewnty.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath as IndexPath) as! albumRankTableViewCell
        
        let topTwenty = albumTopTewnty[indexPath.row]
        
        cell.albumImageView.image = topTwenty.representativeItem?.artwork?.image(at: (cell.albumImageView?.bounds.size)!)
        cell.albumTitleLabel.text = topTwenty.representativeItem?.albumTitle
        cell.ArtistLabel.text = topTwenty.representativeItem?.artist
        let days = Int(topTwentyDuration[indexPath.row] / (3600 * 24))
        let hours = Int((topTwentyDuration[indexPath.row] % (3600 * 24)) / 3600)
        let minutes = Int(((topTwentyDuration[indexPath.row] % (3600 * 24)) % 3600) / 60)
        cell.albumPlayTimeLabel.text = "\(days)d\(hours)h\(minutes)m"
        
        albumPlayCount.sort{$0 > $1}
        cell.albumPlayCountLabel.text = "\(albumPlayCount[indexPath.row])"
        cell.rankNumberLabel.text = "\(indexPath.row + 1)"
        
        return cell
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

