//
//  ViewController.swift
//  care
//
//  Created by yo hishuu on 2018/07/04.
//  Copyright © 2018年 yo hishuu. All rights reserved.
//

import UIKit
import SnapKit

class MorningDrugViewController: UIViewController {

    var today: DrugTakeModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "朝の薬"
        self.view.backgroundColor = UIColor.yellow
        //self.edgesForExtendedLayout = UIRectEdge()
        installUI()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func installUI() {
        let msg = UILabel()
        self.view.addSubview(msg)
        msg.font = UIFont.systemFont(ofSize: 28)
        msg.text = "朝薬を飲んでください"
        msg.textAlignment = NSTextAlignment.center
        msg.snp.makeConstraints({ (maker) in
            maker.centerY.equalTo(self.view).offset(-100)
            maker.centerX.equalTo(self.view)
            maker.width.equalTo(300)
            maker.height.equalTo(40)
        })
        
        let img = UIImage(named: "DrugImage")
        let imgsize = img?.size
        let imgview = UIImageView(image:img)
        self.view.addSubview(imgview)
        imgview.snp.makeConstraints({ (maker) in
            maker.top.equalTo(msg.snp.bottom).offset(30)
            maker.centerX.equalTo(self.view)
            maker.width.equalTo(imgsize!.width)
            maker.height.equalTo(imgsize!.height)
        })

        
        let YesButton =  UIButton(type: UIButtonType.system)
        self.view.addSubview(YesButton)
        YesButton.tintColor = UIColor.white
        YesButton.titleLabel?.font = UIFont.systemFont(ofSize: 28)
        YesButton.backgroundColor = UIColor.orange
        YesButton.snp.makeConstraints({ (maker) in
            maker.top.equalTo(imgview.snp.bottom).offset(30)
            maker.centerX.equalTo(self.view)
            maker.width.equalTo(200)
            maker.height.equalTo(60)
        })
        YesButton.setTitle("飲みました", for: UIControlState())
        YesButton.layer.cornerRadius = 5
        YesButton.addTarget(self, action: #selector(self.YesClick), for: UIControlEvents.touchUpInside)
        
        if today?.morning == 1 {
            self.navigationItem.hidesBackButton = true
        }
        
    }
    
    @objc func YesClick(){
        today!.morning = 2
        DrugTakeManager.update(rec: today!)
        let nextview = MorningFinishViewController()
        nextview.today = self.today!
        nextview.DrugMsg = "朝藥を飲みました"
        self.navigationController?.pushViewController(nextview, animated: true)
    }
}

