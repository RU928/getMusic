//
//  musicHomeViewController.swift
//  getMusic
//
//  Created by 田村崚 on 2017/05/11.
//  Copyright © 2017年 ryo.tamura. All rights reserved.
//

import UIKit
import AVFoundation
import MediaPlayer



class musicHomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var songsQuery = MPMediaQuery.songs()
    
    var maxPlayCount: Int = 0

    var counts: [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
        
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
        
        //グラデーションの開始色
        let topColor = UIColor(red:0.07, green:0.13, blue:0.26, alpha:1)
        //グラデーションの開始色
        let bottomColor = UIColor(red:0.54, green:0.74, blue:0.74, alpha:1)
        
        //グラデーションの色を配列で管理
        let gradientColors: [CGColor] = [topColor.cgColor, bottomColor.cgColor]
        
        //グラデーションレイヤーを作成
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        
        //グラデーションの色をレイヤーに割り当てる
        gradientLayer.colors = gradientColors
        //グラデーションレイヤーをスクリーンサイズにする
        gradientLayer.frame = self.view.bounds
        
        //グラデーションレイヤーをビューの一番下に配置
        self.view.layer.insertSublayer(gradientLayer, at: 0)
        
        tableView.backgroundColor = UIColor.clear
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("セル数を確定する時点でのcountsの数は\(counts.count)です")
        return counts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel?.text = "再生回数: \(counts[indexPath.row])回"
        cell.detailTextLabel?.text = ""
        
        // cellの背景を透過
        cell.backgroundColor = UIColor.clear
        // cell内のcontentViewの背景を透過
        cell.contentView.backgroundColor = UIColor.clear
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "segue",sender: nil) // ←追加する
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        let playViewController:PlayViewController = segue.destination as! PlayViewController
        let indexPath = self.tableView.indexPathForSelectedRow
        playViewController.predicateValue = counts[(indexPath?.row)!]
    }
    
    @IBAction func unwind(segue: UIStoryboardSegue) {
        
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
