//
//  getRecipetitleStruct.swift
//  Fridgemate
//
//  Created by MakeSchool on 8/5/16.
//  Copyright © 2016 Kadeem. All rights reserved.
//

import Foundation
import SwiftyJSON

struct RecipeTitle {
    let recipeTitle: String
    
    init(json:JSON) {
        self.recipeTitle = json["title"].stringValue
    }
}