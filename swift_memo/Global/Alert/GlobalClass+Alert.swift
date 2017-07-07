//
//  GlobalClass+Alert.swift
//  qiitaReader
//
//  Created by 林 利樹 on 2017/07/08.
//  Copyright © 2017年 林 利樹. All rights reserved.
//

import Foundation
import UIKit

extension GlobalClass {
    
    class func showAlertOkAndCancel(presentView: UIViewController, title: String, message: String, okHandler: @escaping () -> Swift.Void) {
        
        let alertController = UIAlertController(title: title,message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        let okAction = UIAlertAction(title: "はい", style: UIAlertActionStyle.default){ (action: UIAlertAction) in
            okHandler()
        }
        
        let cancelButton = UIAlertAction(title: "いいえ", style: UIAlertActionStyle.cancel, handler: nil)
        
        alertController.addAction(okAction)
        alertController.addAction(cancelButton)
        
        presentView.present(alertController,animated: true,completion: nil)
        
    }
}
