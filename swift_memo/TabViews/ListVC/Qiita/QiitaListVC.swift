//
//  MainView.swift
//  swift_memo
//
//  Created by 林 利樹 on 2017/06/17.
//  Copyright © 2017年 林 利樹. All rights reserved.
//

import Foundation
import UIKit

class QiitaListVC : ListVC{
    
    var apiUrl : String = "https://qiita.com/api/v2/items"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func reloadData() {
        self.networkConnect.getArticles(modelType: .qiita, url: self.apiUrl) { (result) in
            self.dataSouceDataArray = result as! Array<Any>
            self.tableView.reloadData()
            self.tableView.refreshControl?.endRefreshing()
        }
    }
    
    override func getTitle( indexPath: IndexPath)  -> String{
        let resultData : qiitaApiModel = self.dataSouceDataArray[indexPath.row] as! qiitaApiModel
        return resultData.title
    }
    
    override func getSelectDataDic(indexPath: IndexPath) -> Dictionary<String,String> {
        let resultData : qiitaApiModel = self.dataSouceDataArray[indexPath.row] as! qiitaApiModel
        return resultData.changeDic()
    }

    
}
