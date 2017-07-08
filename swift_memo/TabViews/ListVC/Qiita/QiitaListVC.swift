//
//  MainView.swift
//  swift_memo
//
//  Created by 林 利樹 on 2017/06/17.
//  Copyright © 2017年 林 利樹. All rights reserved.
//

import Foundation
import UIKit

class QiitaListVC : ListVC, UISearchBarDelegate{
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        self.searchBar.enablesReturnKeyAutomatically = false;
        super.viewDidLoad()
        
    }
    
    override func reloadData() {
        self.networkConnect.qiitaReqest(keyWard:self.searchBar.text!) { (result) in
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

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
        self.reloadData()
    }
    
}
