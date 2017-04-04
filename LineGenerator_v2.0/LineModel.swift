//
//  CategoryModel.swift
//  LineGenerator_v2.0
//
//  Created by Khan Julmagambetov on 2017-03-23.
//  Copyright © 2017 AJ. All rights reserved.
//

import Foundation

class LineModel: NSObject {
    
    //properties
    
    var content: String?
    var category: String?
    
    //empty constructor
    
    override init()
    {
        
    }
    
    //construct with @name, @address, @latitude, and @longitude parameters
    
    init(content: String, category: String) {
        
        self.content = content
        self.category = category
        
    }
    
    
    //prints object's current state
    
    override var description: String {
        return "Content: \(String(describing: content)), Category: \(String(describing: category))"
        
    }
    
    
}
