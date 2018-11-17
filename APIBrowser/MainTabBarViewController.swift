//
//  MainTabBarViewController.swift
//  APIBrowser
//
//  Created by 蒲生廣人 on 2018/11/13.
//  Copyright © 2018 蒲生廣人. All rights reserved.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
 
        super.viewDidLoad()

        let vc = NewsViewController()
        vc.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 1)
        let nv = UINavigationController(rootViewController: vc)
        
//        let vc2 = Nav2ViewController()
//        vc2.tabBarItem = UITabBarItem(tabBarSystemItem: .downloads, tag: 2)
//        let nv2 = UINavigationController(rootViewController: vc2)
//
        setViewControllers([nv], animated: false)
        
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
