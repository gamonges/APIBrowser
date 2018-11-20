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

    var dataList: [SampleModel] = []

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

        reloadListDatas()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: NewsCell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as! NewsCell
        let data = dataList[indexPath.row]

        cell.dateLabel.text = data.date
        cell.titleLabel.text = data.title.rendered

        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return dataList.count
    }

    func reloadListDatas() {
        
        // セッション用のコンフィグを設定・今回はデフォルトの設定
        let config = URLSessionConfiguration.default
        
        // NSURLSessionのインスタンスを生成
        let session = URLSession(configuration: config)
        
        // 接続するURLを指定
        let url = URL(string: "https://demo.wp-api.org/wp-json/wp/v2/posts/")
        
        // 通信処理タスクを設定
        let task = session.dataTask(with: url!) {(data, response, error) in
            
            // エラーが発生した場合にのみ処理
            if error != nil {
                // ここでエラーが発生したことをアラートで表示
                let controller : UIAlertController = UIAlertController(title: nil, message: "エラーが発生しました。", preferredStyle: UIAlertControllerStyle.alert)
                controller.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil))
                self.present(controller, animated: true, completion: nil)
                
                // 表示後は処理終了
                return
            }
            
            // エラーがなければ、JSON形式にデータを変換して格納
            guard let jsonData: Data = data else {
                // ここでエラーが発生したことをアラートで表示
                let controller : UIAlertController = UIAlertController(title: nil, message: "エラーが発生しました。", preferredStyle: UIAlertControllerStyle.alert)
                controller.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil))
                self.present(controller, animated: true, completion: nil)
                
                // 表示後は処理終了
                return
            }

            self.dataList = try! JSONDecoder().decode([SampleModel].self, from: jsonData)
            
            // メインスレッドに処理を戻す
            DispatchQueue.main.async {
                // 最新のデータに更新する
                self.tableView.reloadData()
            }
        }
        // タスクを実施
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
