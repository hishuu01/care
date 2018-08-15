//
//  NoteModel.swift
//  NoteBook
//
//  Created by vip on 16/11/12.
//  Copyright © 2016年 jaki. All rights reserved.
//

import UIKit

class DrugTakeModel: NSObject {
    var row: Int?               //rowid
    var takeDate:String?        //服用日
    var morning:Int?            //朝の薬有無　0:未　1:済
    var midday:Int?             //昼の薬有無　0:未　1:済
    var night:Int?              //夜の薬有無　0:未　1:済
    var insTime: String?        //新規登録時間
    var updTime:String?         //最終登録時刻
    
    func toDictionary() -> Dictionary<String,Any> {
        var dic:[String:Any] = ["TakeDate":takeDate!,"Morning":morning!,"Midday":midday!,"Night":night!,"InsTime": insTime!,"UpdTime":updTime!]
        if let id = row {
            dic["Row"] = id
        }
        return dic
    }
}
