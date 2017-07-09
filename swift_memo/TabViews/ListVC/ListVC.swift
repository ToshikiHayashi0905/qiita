//
//  ListVC.swift
//  swift_memo
//
//  Created by 林 利樹 on 2017/07/02.
//  Copyright © 2017年 林 利樹. All rights reserved.
//

import Foundation
import UIKit

class ListVC : UIViewController ,UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var tableView: UITableView!
    let networkConnect = NetworkConnection()
    var dataSouceDataArray : Array<Any> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.contentInset = UIEdgeInsetsMake(-1.0, 0.0, 0.0, 0.0);
        self.reloadData()
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(QiitaListVC.reloadData), for: UIControlEvents.valueChanged)
        self.tableView.refreshControl = refreshControl
        
    }
    
    // MARK: tableViewDelegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSouceDataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // セルを取得
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell") as! MyCell
        cell.textLabel?.text = self.getTitle(indexPath: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.moveWebView(selectData : self.getSelectDataDic(indexPath: indexPath))
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    // MARK: move
    func moveWebView(selectData: Dictionary<String, String>) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mainVC = storyboard.instantiateViewController(withIdentifier: "MyWebView") as! MyWebView
        mainVC.selectDataDic = selectData
        
        self.navigationController?.pushViewController(mainVC, animated: true)
        
    }
    
    // MARK: override
    func reloadData() {}
    func getTitle(indexPath: IndexPath) -> String { return "" }
    func getSelectDataDic(indexPath: IndexPath) -> Dictionary<String,String> { return Dictionary() }
    
}
