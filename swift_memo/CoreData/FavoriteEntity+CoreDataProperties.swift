//
//  FavoriteEntity+CoreDataProperties.swift
//  swift_memo
//
//  Created by 林 利樹 on 2017/07/01.
//  Copyright © 2017年 林 利樹. All rights reserved.
//

import Foundation
import CoreData


extension FavoriteEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoriteEntity> {
        return NSFetchRequest<FavoriteEntity>(entityName: "FavoriteEntity")
    }

    @NSManaged public var uuid: String?
    @NSManaged public var url: String?
    @NSManaged public var title: String?
    @NSManaged public var code: String

}
