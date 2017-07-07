//
//  FavoriteDataManager.swift
//  swift_memo
//
//  Created by 林 利樹 on 2017/07/01.
//  Copyright © 2017年 林 利樹. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class FavoriteDataManager : NSObject{
    static let sharedManager = FavoriteDataManager()
    private override init() {
        
    }
    
    func createRecordWithQiitaData(newRecordData: qiitaApiModel) {
        var newRecordDic : Dictionary<String, String> = Dictionary()
        newRecordDic["url"] = newRecordData.url
        newRecordDic["title"] = newRecordData.title
        newRecordDic["code"] = newRecordData.code
        
        self.createRecord(newRecordData:newRecordDic)
    }
    
    func createRecord(newRecordData: Dictionary<String, String>) {
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let viewContext = appDelegate.persistentContainer.viewContext
        
        let favoriteEntity = FavoriteEntity(context: viewContext)
        favoriteEntity.url = newRecordData["url"]!
        favoriteEntity.title = newRecordData["title"]!
        favoriteEntity.code = newRecordData["code"]!
        favoriteEntity.uuid = NSUUID().uuidString
        appDelegate.saveContext()
    }
    
    func roadlRecord() -> Array<Any> {
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let viewContext = appDelegate.persistentContainer.viewContext
        let query: NSFetchRequest<FavoriteEntity> = FavoriteEntity.fetchRequest()
        do {
            var resutlArray : Array<Any> = []
            
            let fetchResults = try viewContext.fetch(query)
            for fetchResultsData in fetchResults {
                var resutlDic : Dictionary<String,String> = Dictionary()
                let title: String? = (fetchResultsData as AnyObject).value(forKey: "title") as? String
                let url: String? = (fetchResultsData as AnyObject).value(forKey: "url") as? String
                let code: String? = (fetchResultsData as AnyObject).value(forKey: "code") as? String
                let uuid: String? = (fetchResultsData as AnyObject).value(forKey: "uuid") as? String
                
                resutlDic["title"] = title
                resutlDic["url"] = url
                resutlDic["code"] = code
                resutlDic["uuid"] = uuid
                resutlArray.append(resutlDic)
                
            }
            return resutlArray
        } catch {
        }
        
        return Array<Any>()
    }
    
    func deleteRecord(deleteRecordData: Dictionary<String, String>) {
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let viewContext = appDelegate.persistentContainer.viewContext
        let query: NSFetchRequest<FavoriteEntity> = FavoriteEntity.fetchRequest()
        
        do {
            let fetchResults = try viewContext.fetch(query)
            for fetchResultsData in fetchResults {
                if (self.checkSameRecrod(fetchResult: fetchResultsData, recordData: deleteRecordData)) {
                    let record = fetchResultsData as NSManagedObject
                    viewContext.delete(record)
                }
            }
            try viewContext.save()
        } catch {
        }
    }
    
    func checkSameRecrod(fetchResult: AnyObject, recordData: Dictionary<String, String>) -> Bool {

        let uuid: String? = (fetchResult as AnyObject).value(forKey: "uuid") as? String
        if ( uuid  == recordData["uuid"] ) {
            return true
        }
        
        return false
    }
    
}
