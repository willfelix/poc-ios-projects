//
//  DB.swift
//  NinjaTodo
//
//  Created by Will Felix on 30/06/20.
//  Copyright © 2020 Will Felix. All rights reserved.
//

import Foundation

struct DB {
    
    private let key = Constants.TODO_KEY
    
    
    private func merge(_ tasks: [String: Bool]) {
        UserDefaults.standard.setValue(tasks, forKey: key)
    }
    
    func tasks() -> [String:Bool] {
        guard let tasks = UserDefaults.standard.dictionary(forKey: key) else {
            
            let newObj: [String: Bool] = [:]
            return newObj
            
        }
        
        return tasks as! [String: Bool]
    }
    
    func add(title: String) {
        var tasks = self.tasks()
        
        tasks[title] = false
        
        self.merge(tasks)
    }
    
    func remove(title: String) {
        var tasks = self.tasks()
        
        if tasks[title] == nil {
            return
        }

        tasks.removeValue(forKey: title)
        self.merge(tasks)
    }
    
    func mark(title: String, isComplete: Bool) {
        var tasks = self.tasks()
        
        if tasks[title] == nil {
            return
        }

        tasks[title] = isComplete
        
        self.merge(tasks)
    }
    
}
