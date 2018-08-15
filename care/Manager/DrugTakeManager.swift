//
//  DataManager.swift
//  NoteBook
//
//  Created by vip on 16/11/11.
//  Copyright © 2016年 jaki. All rights reserved.
//

import UIKit
import SQLiteSwift3
class DrugTakeManager: NSObject {

    //追加
    class func insert(rec:DrugTakeModel){
        if !DataManager.isOpen {
            DataManager.openDataBase()
        }
        let now = Date()
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
        rec.insTime = dateformatter.string(from: now)
        DataManager.sqlHandle!.insertData(rec.toDictionary(), intoTable: "DrugTake")
    }
    
    //追加
    class func update(rec:DrugTakeModel){
        if !DataManager.isOpen {
            DataManager.openDataBase()
        }
        let now = Date()
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
        rec.updTime = dateformatter.string(from: now)
        let condition = "TakeDate='\(rec.takeDate!)'"
        DataManager.sqlHandle!.updateData(rec.toDictionary(), intoTable: "DrugTake", while: condition, isSecurity: false)
    }
    //削除
    class func delete(row:Int){
        if !DataManager.isOpen {
            DataManager.openDataBase()
        }
        DataManager.sqlHandle!.deleteData("Row=\(row)", intoTable: "DrugTake", isSecurity: false)
    }
    
    class func delete(today:String){
        if !DataManager.isOpen {
            DataManager.openDataBase()
        }
        DataManager.sqlHandle!.deleteData("TakeDate='\(today)'", intoTable: "DrugTake", isSecurity: false)
    }

    //売上取得
    class func find(today:String) -> DrugTakeModel {
        if !DataManager.isOpen {
            DataManager.openDataBase()
        }
        
        let request = SQLiteSearchRequest()
        request.contidion = "TakeDate='\(today)'"
        var array = Array<DrugTakeModel>()
        DataManager.sqlHandle?.searchData(withReeuest: request, inTable: "DrugTake", searchFinish: { (success, dataArray) in
            dataArray?.forEach({ (element) in
                let rec = DrugTakeModel()
                rec.row = element["Row"] as! Int?
                rec.takeDate = element["TakeDate"] as! String?
                rec.morning = element["Morning"] as! Int?
                rec.midday = element["Midday"] as! Int?
                rec.night = element["Night"] as! Int?
                rec.insTime = element["InsTime"] as! String?
                rec.updTime = element["UpdTime"] as! String?
                array.append(rec)
            })
        })
        var todayDrugTake = DrugTakeModel()
        if array.count == 0 {
            todayDrugTake.row = 0
            todayDrugTake.takeDate = Common.today()
            todayDrugTake.morning = 0
            todayDrugTake.midday = 0
            todayDrugTake.night = 0
            todayDrugTake.insTime = ""
            todayDrugTake.updTime = ""
        }
        else{
            todayDrugTake = array[0]
        }
        return todayDrugTake
    }

    class func createTable(){
        //伝票番号
        let row = SQLiteKeyObject()
        row.name = "Row"
        row.fieldType = INTEGER
        row.modificationType = PRIMARY_KEY
        
        let takeDate = SQLiteKeyObject()
        takeDate.name = "TakeDate"
        takeDate.fieldType = TEXT

        let morning = SQLiteKeyObject()
        morning.name = "Morning"
        morning.fieldType = INTEGER
        
        let midday = SQLiteKeyObject()
        midday.name = "Midday"
        midday.fieldType = INTEGER
        
        let night = SQLiteKeyObject()
        night.name = "Night"
        night.fieldType = INTEGER
        
        let insTime = SQLiteKeyObject()
        insTime.name = "InsTime"
        insTime.fieldType = TEXT
        
        let updTime = SQLiteKeyObject()
        updTime.name = "UpdTime"
        updTime.fieldType = TEXT
        
        DataManager.sqlHandle!.createTable(withName: "DrugTake", keys: [row,takeDate,morning,midday,night,insTime,updTime])
    }
    
}
