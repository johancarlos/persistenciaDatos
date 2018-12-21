//
//  Meal.swift
//  foodStore
//
//  Created by jbian on 12/15/18.
//  Copyright © 2018 Avantica. All rights reserved.
//

import Foundation
import UIKit
class Meal {
    // TODO implement
    var id:String
    var name: String
    var photo: UIImage?
    var rating: Int
    init?(id:String, name: String, photo: UIImage, rating: Int){
        self.id = id
        self.name = name
        self.photo = photo
        self.rating = rating
        if name.isEmpty || rating < 0
        {
            return nil
        }
    }
    
}
