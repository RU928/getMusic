//
//  CheckViewController.swift
//  getMusic
//
//  Created by 田村崚 on 2017/05/21.
//  Copyright © 2017年 ryo.tamura. All rights reserved.
//

import UIKit
import AVFoundation
import MediaPlayer

class CheckViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 9.3, *) {
            MPMediaLibrary.requestAuthorization { (status) in
                if status == .authorized {
                    // 許可されたので処理を継続して良い
                } else {
                    // 許可されていないので、処理が継続できない
                }
            }
        } else {
            // Fallback on earlier versions
        }
        
       
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
