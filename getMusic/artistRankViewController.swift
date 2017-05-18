//
//  artistRankViewController.swift
//  getMusic
//
//  Created by 田村崚 on 2017/05/18.
//  Copyright © 2017年 ryo.tamura. All rights reserved.
//

import UIKit
import AVFoundation
import MediaPlayer


class artistRankViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    let artistQuery = MPMediaQuery.artists()
    let songsQuery = MPMediaQuery.songs()
    
    var artistRank: [String] = []
    var playCountRank: [Int] = []
    var DurationSumRank: [Int] = []
    var artistImage: [MPMediaItemArtwork] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.allowsSelection = false
        let nib = UINib(nibName: "artistRankTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "Cell")
        tableView.estimatedRowHeight = 120
        tableView.rowHeight = UITableViewAutomaticDimension

        // Do any additional setup after loading the view.
        var allArtistPlayCountList: [Int] = []
        var allArtistDurationList: [Int] = []
        var forSetDurationRank: [Int] = []
        var forSetPlayCountRank: [Int] = []
        var forSetArtistRank: [String] = []
        var forSetArtistImage: [MPMediaItemArtwork?] = []
        
        for artist in artistQuery.collections!{
            var artistDurationSum = 0
            var artistCountSum = 0
            
            for songs in songsQuery.collections!{
                
                if artist.representativeItem?.artist == songs.representativeItem?.artist{
                    let playCount = songs.representativeItem?.playCount
                    artistCountSum = artistCountSum + playCount!
                    let songDuration =  Int((songs.representativeItem?.playbackDuration)!)
                    let sumDuration = songDuration * playCount!
                    artistDurationSum = artistDurationSum + sumDuration
                }
                
            }
            allArtistPlayCountList.append(artistCountSum)
            allArtistDurationList.append(artistDurationSum)
            forSetDurationRank.append(artistDurationSum)
            forSetPlayCountRank.append(artistCountSum)
            forSetArtistRank.append((artist.representativeItem?.artist)!)
            
            if artist.representativeItem?.artwork != nil{
            forSetArtistImage.append((artist.representativeItem?.artwork)!)
            }else{
                forSetArtistImage.append(nil)
            }
        }
        
        allArtistDurationList.sort{ $0 > $1 }
        for i in 0...19{ ///上位２０の総再生時間を取得
            if allArtistDurationList[i] >= 0 {
                DurationSumRank.append(allArtistDurationList[i])
                print("\(allArtistDurationList[i])を追加しました。")
            }
        }
        
        ///もう一度同じ処理（だった）
               ///ここまで同じ処理（だった）
        for i in 0...(DurationSumRank.count - 1){
            print("\(i)回目です")
        
            for number in 0...(forSetDurationRank.count - 1){
                
                if DurationSumRank[i] == forSetDurationRank[number]{
                    artistRank.append(forSetArtistRank[number])
                    playCountRank.append(forSetPlayCountRank[number])
                    artistImage.append(forSetArtistImage[number]!)
                    print("追加しました")
                    break
                }///if
                
            }///for number
            
        }
        
        print("for文抜けました")
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DurationSumRank.count
       
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath as IndexPath) as! artistRankTableViewCell
        
        cell.playCountSumLabel.text = "\(playCountRank[indexPath.row])"
        let days = Int(DurationSumRank[indexPath.row] / (3600 * 24))
        let hours = Int((DurationSumRank[indexPath.row] % (3600 * 24)) / 3600)
        let minutes = Int(((DurationSumRank[indexPath.row] % (3600 * 24)) % 3600) / 60)
        cell.playDurationSumLabel.text = "\(days)d\(hours)h\(minutes)m"
        cell.artistNameLabel.text = "\(artistRank[indexPath.row])"
        cell.rankLabel.text = "\(indexPath.row + 1)"
        
        if artistImage[indexPath.row] != nil{
            let image = artistImage[indexPath.row].image(at: cell.artistImageView.bounds.size)
            cell.artistImageView.image = image
        }else{
            cell.artistImageView.backgroundColor = UIColor.gray
        }
        
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
