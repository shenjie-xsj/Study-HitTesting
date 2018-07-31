//
//  ViewController.swift
//  HitTesting
//
//  Created by EU_ShenJie on 2018/7/31.
//  Copyright © 2018年 EU_ShenJie. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var layerView: UIView!
    var blueLayer:CALayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        blueLayer = CALayer()
        //frame指视图或图层对于其父视图或图层所要占据的位置【旋转会变】（坐标系在父视图或父图层上）
        blueLayer.frame = CGRect(x: 50, y: 50, width: 100, height: 100)
        //bounds指视图或图层对于自身的描述【旋转不变】（原点和宽高）
        
        blueLayer.backgroundColor = UIColor.blue.cgColor
        layerView.layer.addSublayer(blueLayer)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }


}

