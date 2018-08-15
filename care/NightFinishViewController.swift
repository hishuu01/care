//
//  ViewController.swift
//  care
//
//  Created by yo hishuu on 2018/07/04.
//  Copyright © 2018年 yo hishuu. All rights reserved.
//

import UIKit
import SnapKit

class NightFinishViewController: UIViewController {

    var DrugMsg: String?
    var today: DrugTakeModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "夜薬飲む状況"
        self.view.backgroundColor = UIColor.brown
        self.edgesForExtendedLayout = UIRectEdge()
        if today?.night == 2 {
            DrugMsg = "夜藥を飲みました"
            let nItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: self, action: nil)
            self.navigationItem.leftBarButtonItem = nItem
            //self.navigationItem.hidesBackButton = true
        }
        else {
            DrugMsg = "夜藥を飲まないで下さい"
        }
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
        msg.text = self.DrugMsg!
        msg.textAlignment = NSTextAlignment.center
        msg.snp.makeConstraints({ (maker) in
            maker.centerY.equalTo(self.view).offset(-100)
            maker.centerX.equalTo(self.view)
            maker.width.equalTo(320)
            maker.height.equalTo(40)
        })
        
        let img = UIImage(named: "BanImage")
        let imgsize = img?.size
        let imgview = UIImageView(image:img)
        self.view.addSubview(imgview)
        imgview.snp.makeConstraints({ (maker) in
            maker.top.equalTo(msg.snp.bottom).offset(30)
            maker.centerX.equalTo(self.view)
            maker.width.equalTo(imgsize!.width)
            maker.height.equalTo(imgsize!.height)
        })
    }
}

