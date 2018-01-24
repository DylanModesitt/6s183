//
//  Model.swift
//  ToDo
//
//  Created by William Caruso on 1/23/18.
//  Copyright © 2018 wcaruso. All rights reserved.
//

class ToDoItem
{
    var title: String
    var done: Bool
    
    public init(title: String)
    {
        self.title = title
        self.done = false
    }
}

extension ToDoItem
{
    public class func getMockData() -> [ToDoItem]
    {
        return [
            ToDoItem(title: "Buy Milk"),
            ToDoItem(title: "Eat Chocolate"),
            ToDoItem(title: "Screw in the Light bulb"),
            ToDoItem(title: "Feed Dog")
        ]
    }
}
