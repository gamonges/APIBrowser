//
//  NewsViewController.swift
//  APIBrowser
//
//  Created by 蒲生廣人 on 2018/11/06.
//  Copyright © 2018 蒲生廣人. All rights reserved.
//

import UIKit
import SnapKit

class NewsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UINavigationControllerDelegate {

    private lazy var tableViewController: UITableViewController = {
        let vc = UITableViewController(style: .plain)
        let tableView = vc.tableView
        let tableFooterView = UIView()

        tableView?.tableFooterView = tableFooterView
        tableView?.rowHeight = 44
        tableView?.layoutMargins = UIEdgeInsets.zero
        tableView?.delegate = self
        tableView?.dataSource = self
        self.addChildViewController(vc)
        self.view.addSubview(vc.view)
        vc.view.snp.makeConstraints{ $0.edges.equalToSuperview() }
        vc.didMove(toParentViewController: self)
        
        return vc
    }()
    private var tableView: UITableView { return tableViewController.tableView }

    override func viewDidLoad() {
        super.viewDidLoad()

        let nib = UINib(nibName: "NewsCell", bundle: nil)
        self.view.addSubview(tableView)
        tableView.register(nib, forCellReuseIdentifier: "NewsCell")

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return 5
    }

    func reloadListDatas(){
        let config = URLSessionConfiguration.default

        let session = URLSession(configuration: config)
        let url = URL(string: "https://demo.wp-api.org/wp-json/wp/v2/posts/")
        let task = session.dataTask(with: url!) {(data, responese, error) in
            if error != nil {
                let controller: UIAlertController = UIAlertController(title: nil, message: "エラーが発生しました", preferredStyle: UIAlertControllerStyle.alert)
                controller.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil))
                self.present(controller, animated: true, completion: nil)

                return
            }
        }
        task.resume()
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
