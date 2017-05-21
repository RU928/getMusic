//
//  ViewController.swift
//  getMusic
//
//  Created by 田村崚 on 2017/05/13.
//  Copyright © 2017年 ryo.tamura. All rights reserved.
//

import UIKit
import ESTabBarController
import AVFoundation
import MediaPlayer


class ViewController: UIViewController {
    
    


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
                self.setupTab()


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupTab(){
        let tabBarController: ESTabBarController! = ESTabBarController(tabIconNames: ["rank", "album", "artist"])
        addChildViewController(tabBarController)
        view.addSubview(tabBarController.view)
        tabBarController.view.frame = view.bounds
        tabBarController.didMove(toParentViewController: self)
        
        tabBarController.selectedColor = UIColor.red
        tabBarController.buttonsBackgroundColor = UIColor.white

        
        let  rankController = storyboard?.instantiateViewController(withIdentifier: "rank")
        let  albumRank = storyboard?.instantiateViewController(withIdentifier: "albumRank")
        let artistRank = storyboard?.instantiateViewController(withIdentifier: "artist")
        
        tabBarController.setView(rankController, at: 0)
        tabBarController.setView(artistRank, at: 2)
        tabBarController.setView(albumRank, at: 1)
        
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
