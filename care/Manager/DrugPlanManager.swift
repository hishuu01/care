//
//  DataManager.swift
//  NoteBook
//
//  Created by vip on 16/11/11.
//  Copyright © 2016年 jaki. All rights reserved.
//

import UIKit
import SQLiteSwift3
class DrugPlanManager: NSObject {

    //売上保存
    class func insert(rec:DrugPlanModel){
        if !DataManager.isOpen {
            DataManager.openDataBase()
        }
        DataManager.sqlHandle!.insertData(rec.toDictionary(), intoTable: "DrugPlan")
    }
    
    //売上削除
    class func delete(row:Int){
        if !DataManager.isOpen {
            DataManager.openDataBase()
        }
        DataManager.sqlHandle!.deleteData("Row=\(row)", intoTable: "DrugPlan", isSecurity: false)
    }

    //売上取得
    class func find(today:String)->[DrugPlanModel]{
        if !DataManager.isOpen {
            DataManager.openDataBase()
        }
        
        let request = SQLiteSearchRequest()
        request.contidion = "StartDate<='\(today)' AND EndDate>='\(today)'"
        var array = Array<DrugPlanModel>()
        DataManager.sqlHandle?.searchData(withReeuest: request, inTable: "DrugPlan", searchFinish: { (success, dataArray) in
            dataArray?.forEach({ (element) in
                let rec = DrugPlanModel()
                rec.row = element["Row"] as! Int?
                rec.drugName = element["DrugName"] as! String?
                rec.startDate = element["StartDate"] as! String?
                rec.endDate = element["EndDate"] as! String?
                rec.morning = element["Morning"] as! Int?
                rec.midday = element["Midday"] as! Int?
                rec.night = element["Night"] as! Int?
                rec.time = element["Time"] as! String?
                array.append(rec)
            })
        })
        return array
    }

    //今日の予約取得する
    class func getPlan(today:String)->Array<String>{
        if !DataManager.isOpen {
            DataManager.openDataBase()
        }
        let sql = "select sum(a.Morning) as Morning, sum(a.Midday) as Midday, sum(a.Night) as Night from DrugPlan as a where StartDate <= '\(today)' and EndDate >= '\(today)'"
        let fields:Array<String> = ["Morning", "Midday", "Night"]
        var array = Array<String>()
        DataManager.sqlHandle?.runSelectSQL(sql, selectField: fields, searchFinish: { (success, dataArray) in
            dataArray?.forEach({ (element) in
                array.append((element["Morning"] as! String?)!)
                array.append((element["Midday"] as! String?)!)
                array.append((element["Night"] as! String?)!)
            })
        })
        return array
    }

    class func createTable(){
        //伝票番号
        let row = SQLiteKeyObject()
        row.name = "Row"
        row.fieldType = INTEGER
        row.modificationType = PRIMARY_KEY
        
        let drugName = SQLiteKeyObject()
        drugName.name = "DrugName"
        drugName.fieldType = TEXT
        
        let startDate = SQLiteKeyObject()
        startDate.name = "StartDate"
        startDate.fieldType = TEXT
        
        let endDate = SQLiteKeyObject()
        endDate.name = "EndDate"
        endDate.fieldType = TEXT
        
        let morning = SQLiteKeyObject()
        morning.name = "Morning"
        morning.fieldType = INTEGER
        
        let midday = SQLiteKeyObject()
        midday.name = "Midday"
        midday.fieldType = INTEGER
        
        let night = SQLiteKeyObject()
        night.name = "Night"
        night.fieldType = INTEGER
        
        let time = SQLiteKeyObject()
        time.name = "Time"
        time.fieldType = TEXT
        
        DataManager.sqlHandle!.createTable(withName: "DrugPlan", keys: [row,drugName,startDate,endDate,morning,midday,night,time])
    }
    
}
