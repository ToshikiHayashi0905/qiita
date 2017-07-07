//
//  FavoriteListVC.swift
//  swift_memo
//
//  Created by 林 利樹 on 2017/07/02.
//  Copyright © 2017年 林 利樹. All rights reserved.
//

import Foundation
import UIKit

class FavoriteListVC : ListVC{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.reloadData()
    }
    
    override func reloadData() {
        self.dataSouceDataArray = FavoriteDataManager.sharedManager.roadlRecord().reversed()
        self.tableView.refreshControl?.endRefreshing()
        self.tableView.reloadData()
        
    }
    
    override func getTitle( indexPath: IndexPath)  -> String{
        if let resultData : Dictionary<String,String> = self.dataSouceDataArray[indexPath.row] as? Dictionary<String, String>,
            let title = resultData["title"]{
            return title
        }
        
        return ""
    }
    
    override func getSelectDataDic(indexPath: IndexPath) -> Dictionary<String,String> {
        let resultData : Dictionary<String,String> = self.dataSouceDataArray[indexPath.row] as! Dictionary<String,String>
        return resultData
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            GlobalClass.showAlertOkAndCancel(presentView: self, title: "削除", message: "このお気に入りを削除しますか？") { () in
                if let selectData = self.dataSouceDataArray[indexPath.row] as? Dictionary<String, String> {
                    FavoriteDataManager.sharedManager.deleteRecord(deleteRecordData:selectData)
                    self.reloadData()
                }
            }
        }
    }
}
