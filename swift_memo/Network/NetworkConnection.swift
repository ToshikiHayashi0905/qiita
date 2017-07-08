//
//  NetworkConnection.swift
//  swift_memo
//
//  Created by 林 利樹 on 2017/06/17.
//  Copyright © 2017年 林 利樹. All rights reserved.
//

import Foundation
import Alamofire 
import SwiftyJSON
import Ji

class NetworkConnection : NSObject {
    
    enum apiModel {
        case qiita
    }
    
    func getArticles(modelType: apiModel, param: Parameters, url: String, completion: @escaping (_ resut : NSArray) -> Void) {
        Alamofire.request(url, parameters: param).responseJSON{ response in

            if let resultValue = response.result.value  {
                let json = JSON(resultValue)
                if (modelType == .qiita) {
                    completion(qiitaApiModel.collection(object:json ) as NSArray)
                }
            }
            
        }
    }
}
