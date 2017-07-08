//
//  NetworkConnection+Qiita.swift
//  qiitaReader
//
//  Created by 林 利樹 on 2017/07/08.
//  Copyright © 2017年 林 利樹. All rights reserved.
//

import Foundation
import Alamofire

extension NetworkConnection  {
    
    var apiUrl : String {
        return "https://qiita.com/api/v2/items"
    }
    
    func qiitaReqest(keyWard: String, completion: @escaping (_ resut : NSArray) -> Void) {
        var param : Parameters = Parameters()
        if (keyWard.utf16.count > 0) {
            param["query"] = keyWard
        }
        self.getArticles(modelType: .qiita, param: param, url: apiUrl, completion: completion)
    }
    
}
