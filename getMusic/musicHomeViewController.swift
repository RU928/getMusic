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

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
