//
//  RankingViewController.swift
//  getMusic
//
//  Created by 田村崚 on 2017/05/12.
//  Copyright © 2017年 ryo.tamura. All rights reserved.
//

import UIKit
import AVFoundation
import MediaPlayer

class RankingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var songsQuery: MPMediaQuery = MPMediaQuery.songs()
    
    var maxPlayCount = 0
    
    var counts: [Int] = []
    
    var rankCollection: [MPMediaItemCollection] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        ///ここからセル値の準備
        for songs in songsQuery.collections!{
            let playCount = songs.representativeItem?.playCount
            if playCount! > maxPlayCount{
                maxPlayCount = playCount!
                print(maxPlayCount)
            }
        }
        
        
        for i in 0...maxPlayCount {
            songsQuery = MPMediaQuery.songs()
            
            let predicate = MPMediaPropertyPredicate(value: i, forProperty: MPMediaItemPropertyPlayCount, comparisonType: MPMediaPredicateComparison.equalTo)
            
            songsQuery.addFilterPredicate(predicate)
            
            print("songsQuery.collections?.countの数は\(songsQuery.collections?.count)です")
            
            if (songsQuery.collections?.count) != 0 {
                counts.append(i)
            }
            
            print("\(i)回目です")
            print("countsの数は\(counts.count)です")
        }///ここまでセル値の準備
        
        counts.sort{$0 > $1}
        let TopTenCount = [counts[0], counts[1], counts[2], counts[3], counts[4], counts[5], counts[6], counts[7], counts[8], counts[9]]
        
        songsQuery = MPMediaQuery.songs()
        
        for i in TopTenCount{
            for song in songsQuery.collections!{
                if song.representativeItem?.playCount == i{
                    rankCollection.append(song)
                    print("\(song.representativeItem?.title)\(song.representativeItem?.playCount)")
                }
            }
        }
        
        // テーブルセルのタップを無効にする
        tableView.allowsSelection = false
        
        let nib = UINib(nibName: "rankTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "Cell")
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath as IndexPath) as! rankTableViewCell
        
        let image = rankCollection[indexPath.row].representativeItem?.artwork?.image(at: (cell.imageView?.bounds.size)!)
        cell.rankNumberLabel.text = "\(rankCollection[indexPath.row].representativeItem?.playCount)"
        cell.imageView?.image = image
        cell.rankNumberLabel.text = "\(indexPath.row + 1)"
        cell.artistLabel.text = rankCollection[indexPath.row].representativeItem?.artist
        cell.titleLabel.text = rankCollection[indexPath.row].representativeItem?.title
        
        return cell
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
