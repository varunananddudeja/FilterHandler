//
//  FilterHandler.swift
//  FilterHandler
//
//  Created by Varun on 09/08/17.
//  Copyright © 2017 Varun. All rights reserved.
//

import Foundation

protocol Selection {
    var selected: Bool {set get}
}

protocol FilterHandler: class {
    
    // a type with conforms to Selection protocol
    associatedtype T: Selection
    
    var list: [T]! {set get}
    
    // has single or multiple selections possible
    var hasSingleSelection: Bool {get}
}

extension FilterHandler {
    
    // resets to no selection
    func reset() {
        
        list = list.map { (model) -> T in
            var modelCopy = model
            modelCopy.selected = false
            return modelCopy
        }
    }
    
    // on selection of item
    func clickedListItem(index: Int) {
        
        list[index].selected = !(list[index].selected)
        
        guard hasSingleSelection else {
            return
        }
        
        for tuple in list.enumerated() {
            if tuple.offset != index {
                list[tuple.offset].selected = false
            }
        }
    }
}
