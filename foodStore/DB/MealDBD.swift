//
//  MealDB.swift
//  FoodTracker
//
//  Copyright © 2017 Apple Inc. All rights reserved.
//

import Foundation
import RealmSwift
class MealDBD:Object{
    @objc dynamic var id:String?
    @objc dynamic var name:String?
    @objc dynamic var photo:NSData?
    @objc dynamic var raiting:Int = 0
    @objc dynamic var city:String?
    override static func primaryKey() -> String?{
        return "id"
    }
}

