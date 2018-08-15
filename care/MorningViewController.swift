//
//  ViewController.swift
//  care
//
//  Created by yo hishuu on 2018/07/04.
//  Copyright © 2018年 yo hishuu. All rights reserved.
//

import UIKit
import SnapKit

class MorningViewController: UIViewController {

    var today: DrugTakeModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "朝ご飯"
        self.view.backgroundColor = UIColor.yellow
        //self.edgesForExtendedLayout = UIRectEdge()
        installUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        today = DrugTakeManager.find(today: Common.today())
        if today!.morning == 1 {
            let nextview = MorningDrugViewController()
            nextview.today = today
            self.navigationController?.pushViewController(nextview, animated: true)
        }
        else if today!.morning == 2 {
            let nextview = MorningFinishViewController()
            nextview.today = today
            self.navigationController?.pushViewController(nextview, animated: true)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func installUI() {
        let msg = UILabel()
        self.view.addSubview(msg)
        msg.font = UIFont.systemFont(ofSize: 28)
        msg.text = "朝ご飯を食べましたか？"
        msg.textAlignment = NSTextAlignment.center
        msg.snp.makeConstraints({ (maker) in
            maker.centerY.equalTo(self.view).offset(-100)
            maker.centerX.equalTo(self.view)
            maker.width.equalTo(290)
            maker.height.equalTo(40)
        })
        
        let YesButton =  UIButton(type: UIButtonType.system)
        self.view.addSubview(YesButton)
        YesButton.tintColor = UIColor.white
        YesButton.titleLabel?.font = UIFont.systemFont(ofSize: 28)
        YesButton.backgroundColor = UIColor.orange
        YesButton.snp.makeConstraints({ (maker) in
            maker.top.equalTo(msg.snp.bottom).offset(40)
            maker.left.equalTo(20)
            maker.width.equalTo(120)
            maker.height.equalTo(60)
        })
        YesButton.setTitle("はい", for: UIControlState())
        YesButton.layer.cornerRadius = 5
        YesButton.addTarget(self, action: #selector(self.YesClick), for: UIControlEvents.touchUpInside)
        
        let NoButton =  UIButton(type: UIButtonType.system)
        self.view.addSubview(NoButton)
        NoButton.tintColor = UIColor.white
        NoButton.titleLabel?.font = UIFont.systemFont(ofSize: 28)
        NoButton.backgroundColor = UIColor.orange
        NoButton.snp.makeConstraints({ (maker) in
            maker.top.equalTo(msg.snp.bottom).offset(40)
            maker.right.equalTo(-20)
            maker.width.equalTo(120)
            maker.height.equalTo(60)
        })
        NoButton.setTitle("いいえ", for: UIControlState())
        NoButton.layer.cornerRadius = 5
        
        NoButton.addTarget(self, action: #selector(self.NoClick), for: UIControlEvents.touchUpInside)
    }
    
    @objc func YesClick(){
        today?.morning = 1
        if today!.row == 0 {
            DrugTakeManager.insert(rec: today!)
            today!.row = 1
        }
        else {
            DrugTakeManager.update(rec: today!)
        }
        let nextview = MorningDrugViewController()
        nextview.today = self.today!
        self.navigationController?.pushViewController(nextview, animated: true)
    }
    
    @objc func NoClick(){
        let nextview = MorningFinishViewController()
        nextview.today = self.today!
        nextview.DrugMsg = "朝藥を飲まないで下さい"
        self.navigationController?.pushViewController(nextview, animated: true)
    }
}

