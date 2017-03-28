//
//  CategoryModel.swift
//  LineGenerator_v2.0
//
//  Created by Khan Julmagambetov on 2017-03-23.
//  Copyright © 2017 AJ. All rights reserved.
//

import Foundation

class CategoryModel: NSObject {
    
    //properties
    
    var name: String?
    var color: String?
    
    //empty constructor
    
    override init()
    {
        
    }
    
    //construct with @name, @address, @latitude, and @longitude parameters
    
    init(name: String, color: String) {
        
        self.name = name
        self.color = color
        
    }
    
    
    //prints object's current state
    
    override var description: String {
        return "Name: \(name), Color: \(color)"
        
    }
    
    
}
