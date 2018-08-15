//
//  NoteModel.swift
//  NoteBook
//
//  Created by vip on 16/11/12.
//  Copyright © 2016年 jaki. All rights reserved.
//

import UIKit

class DrugPlanModel: NSObject {
    var row: Int?               //rowid
    var drugName:String?        //名称
    var startDate:String?       //開始日
    var endDate:String?         //終了日
    var morning:Int?         //朝の薬有無　0:無　1:有
    var midday:Int?          //昼の薬有無　0:無　1:有
    var night:Int?           //夜の薬有無　0:無　1:有
    var time:String?            //登録時刻
    
    func toDictionary() -> Dictionary<String,Any> {
        var dic:[String:Any] = ["DrugName":drugName!,"StartDate":startDate!,"EndDate":endDate!,"Morning":morning!,"Midday":midday!,"Night":night!,"Time":time!]
        if let id = row {
            dic["Row"] = id
        }
        return dic
    }
}
