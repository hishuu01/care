//
//  ViewController.swift
//  care
//
//  Created by yo hishuu on 2018/07/04.
//  Copyright © 2018年 yo hishuu. All rights reserved.
//

import UIKit

class MiddayViewController: UIViewController {

    var today: DrugTakeModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "昼ご飯"
        self.view.backgroundColor = UIColor.init(red: 0, green: 150, blue: 255, alpha: 1.0)
        installUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        today = DrugTakeManager.find(today: Common.today())
        if today!.midday == 1 {
            let nextview = MiddayDrugViewController()
            nextview.today = today
            self.navigationController?.pushViewController(nextview, animated: true)
        }
        else if today!.midday == 2 {
            let nextview = MiddayFinishViewController()
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
        msg.text = "昼ご飯を食べましたか？"
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
        today?.midday = 1
        if today!.row == 0 {
            DrugTakeManager.insert(rec: today!)
            today!.row = 1
        }
        else {
            DrugTakeManager.update(rec: today!)
        }
        let nextview = MiddayDrugViewController()
        nextview.today = self.today!
        self.navigationController?.pushViewController(nextview, animated: true)
    }
    
    @objc func NoClick(){
        let nextview = MiddayFinishViewController()
        nextview.today = self.today!
        nextview.DrugMsg = "昼藥を飲まないで下さい"
        self.navigationController?.pushViewController(nextview, animated: true)
    }
}

