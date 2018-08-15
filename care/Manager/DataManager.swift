//
//  DataManager.swift
//  NoteBook
//
//  Created by vip on 16/11/11.
//  Copyright © 2018年 yo. All rights reserved.
//

import UIKit
import SQLiteSwift3
class DataManager: NSObject {
    static var sqlHandle:SQLiteSwift3?
    static var isOpen = false
    //データベースオープン
    class func openDataBase(){
        let file = getDBFile()
        sqlHandle = SQLiteSwift3.openDB(file)
        isOpen=true
    }
    
    class private func isExistDb()->Bool {
        let fileManager = FileManager.default
        let file = getDBFile()
        let exist = fileManager.fileExists(atPath: file)
        return exist
    }
    
    class private func getDBFile()->String {
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let file = path + "/DataBase.sqlite"
        return file
    }
    
    class func initDB(){
        if isExistDb() {
            return
        }
        if !self.isOpen {
            self.openDataBase()
        }
        DrugPlanManager.createTable()
        DrugTakeManager.createTable()
    }

}
