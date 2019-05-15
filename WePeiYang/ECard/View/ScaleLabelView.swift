//
//  ScaleLabelView.swift
//  WePeiYang
//
//  Created by 王申宇 on 2019/5/9.
//  Copyright © 2019 twtstudio. All rights reserved.
//

import UIKit

struct MyColor {
    static func ColorHex(_ color: String) -> UIColor? {
        if color.count <= 0 || color.count != 7 || color == "(null)" || color == "<null>" {
            return nil
        }
        var red: UInt32 = 0x0
        var green: UInt32 = 0x0
        var blue: UInt32 = 0x0
        let redString = String(color[color.index(color.startIndex, offsetBy: 1)...color.index(color.startIndex, offsetBy: 2)])
        let greenString = String(color[color.index(color.startIndex, offsetBy: 3)...color.index(color.startIndex, offsetBy: 4)])
        let blueString = String(color[color.index(color.startIndex, offsetBy: 5)...color.index(color.startIndex, offsetBy: 6)])
        Scanner(string: redString).scanHexInt32(&red)
        Scanner(string: greenString).scanHexInt32(&green)
        Scanner(string: blueString).scanHexInt32(&blue)
        let hexColor = UIColor.init(red: CGFloat(red)/255.0, green: CGFloat(green)/255.0, blue: CGFloat(blue)/255.0, alpha: 1)
        return hexColor
    }
}

class ScaleLabelView: UIView {
    var llabel = UILabel()
    var mlabel = UILabel()
    var rlabel = UILabel()
    var myrect: CGRect!
    
    func LabelScale(_ firstView: inout UIView, _ secondView: inout UIView, _ thirdView: inout UIView, _ firstData: Double, _ secondData: Double, _ thirdData: Double, _ rect: CGRect) {
        let totalData: Double = firstData + secondData + thirdData
        let firstWidth = rect.size.width * CGFloat(firstData / totalData)
        let secondWidth = rect.size.width * CGFloat(secondData / totalData)
        let thirdWidth = rect.size.width * CGFloat(thirdData / totalData)
        let minx = rect.minX
        let miny = rect.minY
        
        firstView = UIView(frame: CGRect(x: minx, y: miny, width: firstWidth, height: rect.height))
        firstView.backgroundColor = MyColor.ColorHex("#f8d316")
        llabel = UILabel(frame: CGRect(x: minx + firstWidth / 4 + 1, y: miny, width: 3 * firstWidth / 4, height: rect.height))
        let temptext: String = String(100 * firstData / totalData)
        llabel.text = temptext.prefix(2) + "%"
        llabel.textAlignment = NSTextAlignment.center
        llabel.textColor = UIColor.black
        llabel.backgroundColor = MyColor.ColorHex("#f8d316")
        firstView.addSubview(llabel)
        secondView = UIView(frame: CGRect(x: firstView.frame.maxX - 1, y: miny, width: secondWidth, height: rect.height))
        secondView.backgroundColor = MyColor.ColorHex("#fff5c2")
        mlabel = UILabel(frame: CGRect(x: firstView.frame.maxX + secondWidth / 4, y: miny, width: 3 * secondWidth / 4 , height: rect.height))
        mlabel.text = String(100 * secondData/totalData).prefix(2) + "%"
        mlabel.textAlignment = NSTextAlignment.center
        mlabel.sizeToFit()
        mlabel.textColor = .black
        mlabel.backgroundColor = MyColor.ColorHex("#fff5c2")
        secondView.addSubview(mlabel)
        
        thirdView = UIView(frame: CGRect(x: secondView.frame.maxX, y: miny, width: thirdWidth, height: rect.height))
        thirdView.backgroundColor = MyColor.ColorHex("ffeb86")
        rlabel = UILabel(frame: CGRect(x: secondView.frame.maxX + thirdWidth / 4, y: miny, width: 3 * thirdWidth / 4, height: rect.height))
        rlabel.text = String(100 * thirdData/totalData).prefix(2) + "%"
        rlabel.textColor = .black
        rlabel.backgroundColor = MyColor.ColorHex("ffeb86")
        thirdView.addSubview(rlabel)
        var tempView: UIView = UIView()
        if firstData != 0 {
            tempView = firstView
        }else if firstData == 0 && secondData != 0 {
            tempView = secondView
        }else if firstData == 0 && secondData == 0 && thirdData != 0 {
            tempView = thirdView
        }else{
            tempView = UIView(frame: rect)
        }
        let leftbezierPath = UIBezierPath(roundedRect: tempView.bounds, byRoundingCorners: [.bottomLeft,.topLeft], cornerRadii: CGSize(width: rect.height / 2, height: rect.height / 2))
        let leftshape: CAShapeLayer = CAShapeLayer()
        tempView.layer.mask = leftshape
        leftshape.fillColor = tempView.backgroundColor?.cgColor
        leftshape.path = leftbezierPath.cgPath
        leftshape.frame = tempView.bounds
        tempView.backgroundColor = .white
        tempView.layer.addSublayer(leftshape)
        
        if thirdData != 0 {
            tempView = thirdView
        }else if thirdData == 0 && secondData != 0 {
            tempView = secondView
        }else if thirdData == 0 && secondData == 0 && firstData != 0 {
            tempView = firstView
        }else{
            tempView = UIView(frame: rect)
        }
        let rightbezierPath = UIBezierPath(roundedRect: tempView.bounds, byRoundingCorners: [.bottomRight,.topRight], cornerRadii: CGSize(width: rect.height / 2, height: rect.height / 2))
        let rightshape: CAShapeLayer = CAShapeLayer()
        rightshape.fillColor = tempView.backgroundColor?.cgColor
        rightshape.path = rightbezierPath.cgPath
        rightshape.frame = tempView.bounds
        tempView.backgroundColor = .white
        tempView.layer.addSublayer(rightshape)
    }
}
