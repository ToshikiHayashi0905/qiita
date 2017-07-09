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
    var page : UInt = 1
    
    override func viewDidLoad() {
        self.searchBar.enablesReturnKeyAutomatically = false;
        super.viewDidLoad()
        
    }
    
    // MARK: -
    // MARK: scrollView
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        print("contentOffset", tableView.contentOffset)
        print("size",tableView.frame.size.height)
        print("contentSize",tableView.contentSize.height)
        
        if tableView.contentOffset.y + tableView.frame.size.height > tableView.contentSize.height &&
            tableView.isDragging {
            
            self.page += 20;
            self.reloadData()
        }
    }
    
    // MARK: -
    override func reloadData() {
        self.networkConnect.qiitaReqest(keyWard: self.searchBar.text!, page: 0) { (result) in
            self.dataSouceDataArray += result as! Array<Any>
            self.tableView.reloadData()
            self.tableView.refreshControl?.endRefreshing()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
        self.page = 20;
        self.dataSouceDataArray = []
        self.reloadData()
    }
    
    
    // MARK: -
    // MARK: get
    override func getTitle( indexPath: IndexPath)  -> String{
        let resultData : qiitaApiModel = self.dataSouceDataArray[indexPath.row] as! qiitaApiModel
        return resultData.title
    }
    
    override func getSelectDataDic(indexPath: IndexPath) -> Dictionary<String,String> {
        let resultData : qiitaApiModel = self.dataSouceDataArray[indexPath.row] as! qiitaApiModel
        return resultData.changeDic()
    }

}
