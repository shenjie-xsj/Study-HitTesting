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

    /**
     总结：
     hitTest方法接受一个相对于根视图的点坐标，然后返回这个点触控的layer。内部按照图层树的父子关系来判断这个点属于哪一个叶子视图。
     所以这里需要【注意】：如果更改了zPosition的Z轴的高低，会导致hitTest方法返回layer的和看见的不一致，因为更改了zPosition但是所在的图层树的父子关系并没有改变。于是产生如下现象：将A图层提高到顶层，看见A图层，点击看到的A图层，但是判断返回的是B图层，因为在图层树中，B才是最叶子的图层。
     containsPoint注意接受的点坐标是相对于谁的！bool返回值说明传入点是否在检测的layer内，这就要求传入点的坐标必须是相对于调用者layer的相对坐标。就像代码中显示的一样，首先判断是否在白色图层中，使用白色图层来调用containsPoin方法，传入的参数是相对于白色图层的触点坐标。后来判断是否在蓝色图层中，就转而使用蓝色图层来调用containsPoint方法，传入的参数也变为了相对于蓝色图层的触点坐标。
     所以这里需要【注意】：使用containsPoint方法，传入的点必须是相对于调用者图层的坐标点，不然得出的结果不正确！！！
     */
    
    //屏幕触摸事件（UIViewController通过继承UIResponder类【此类定义对于各种事件的响应函数】获得）
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //获取相对于主视图的触摸位置
        if var point = touches.first?.location(in: self.view) {
            //-hitTest:方法同样接受一个CGPoint类型参数，它返回图层本身，或者包含这个坐标点的叶子节点图层。通过判断这个图层是谁获知谁被点击了
            useSystemFunctionHitTest(cgpoint: point)//参数是相对于根视图的触点坐标
            
            
            
            
            //获取相对于白图层的触摸位置
            point = layerView.layer.convert(point, from: self.view.layer)
            //-containsPoint:接受一个在本图层坐标系下的CGPoint，如果这个点在图层【frame】范围内就返回true。通过判断谁在这个函数下返回true获知谁被点击了。
            useSystemFunctionContainsPoint(cgpoint: point)//参数是相对于白视图的触点坐标
        }
    }
    
    private func useSystemFunctionContainsPoint(cgpoint:CGPoint) {
        var point = cgpoint
        if (layerView.layer.contains(point)) {
            //如果触摸点在白图层的frame中
            //那么将触摸点的位子转为相对于蓝图层
            point = blueLayer.convert(point, from: layerView.layer)
            //如果触摸点在蓝图层中
            if (blueLayer.contains(point)) {
                //                    print("触点在蓝色区域内")
                let alert = UIAlertController(title: "系统提示", message: "您点击了蓝色区域", preferredStyle: UIAlertControllerStyle.alert)
                let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alert.addAction(okAction)
                self.present(alert, animated: true, completion: nil)
            }
            else {
                //                    print("触点在白色区域内")
                let alert = UIAlertController(title: "系统提示", message: "您点击了白色区域", preferredStyle: UIAlertControllerStyle.alert)
                let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alert.addAction(okAction)
                self.present(alert, animated: true, completion: nil)
            }
        }
        else {
            //                print("触点在白色区域外")
            let alert = UIAlertController(title: "系统提示", message: "您点击了灰色区域", preferredStyle: UIAlertControllerStyle.alert)
            let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    private func useSystemFunctionHitTest(cgpoint:CGPoint) {
        let layer = layerView.layer.hitTest(cgpoint)
        if(layer == blueLayer) {
            print("您点击了蓝色区域")
        }
        else if(layer == layerView.layer) {
            print("您点击了白色区域")
        }else {
            print("您点击了灰色区域")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }


}

