//
//  testModel.swift
//  swift_memo
//
//  Created by 林 利樹 on 2017/06/17.
//  Copyright © 2017年 林 利樹. All rights reserved.
//

import Foundation
import SwiftyJSON

class qiitaApiModel : NSObject {
    dynamic var title: String = ""
    dynamic var url: String = ""
    dynamic var code: String = ""
    
    convenience required init(object: JSON) {
        self.init()
        self.title = object["title"].stringValue
        self.url = object["url"].stringValue
        self.code = object["code"].stringValue
    }
    
    convenience required init(object: Dictionary<String, Any>) {
        self.init()
        self.title = object["title"] as! String
        self.url = object["url"] as! String
        self.code = object["code"] as! String
    }
    
    static func collection(object: JSON) -> [qiitaApiModel] {
        return object.array!.map{ qiitaApiModel(object: $0) }
    }
    
    func changeDic() ->  Dictionary<String, String>{
        var resultDic :  Dictionary<String, String> = Dictionary()
        
        resultDic["url"] = self.url;
        resultDic["title"] = self.title;
        resultDic["code"] = self.code;
        
        return resultDic
    }
}
