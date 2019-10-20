//
//  ScaleLabelView.swift
//  WePeiYang
//
//  Created by 王申宇 on 2019/5/9.
//  Copyright © 2019 twtstudio. All rights reserved.
//

import UIKit

class ScaleLabelView: UIView {
    let firstView = UIView()
    let secondView = UIView()
    let thirdView = UIView()
    let llabel = UILabel()
    let mlabel = UILabel()
    let rlabel = UILabel()
    
    func LabelScale( _ firstData: Double, _ secondData: Double, _ thirdData: Double){
        let totalData: Double = firstData + secondData + thirdData
        let firstWidth = (Device.width - 56) * CGFloat(firstData / totalData)
        let secondWidth = (Device.width - 56) * CGFloat(secondData / totalData)
        let thirdWidth = (Device.width - 56) * CGFloat(thirdData / totalData)
        
        firstView.backgroundColor = UIColor(hex6: 0xf8d316)
        self.addSubview(firstView)
        firstView.snp.makeConstraints { make in
            make.left.equalTo(self.snp.left).inset(28)
            make.centerY.equalTo(self.snp.centerY).inset(self.height / 4)
            make.width.equalTo(firstWidth)
            make.top.equalTo(self.snp.top)
            make.bottom.equalTo(self.snp.bottom)
        }
        
        llabel.text = String(100 * firstData / totalData).prefix(2) + "%"
        llabel.textAlignment = NSTextAlignment.center
        llabel.textColor = UIColor(hex6: 0x666666)
        llabel.backgroundColor = UIColor(hex6: 0xf8d316)
        self.addSubview(llabel)
        llabel.snp.makeConstraints { make in
            make.center.equalTo(firstView.snp.center)
            make.edges.equalTo(firstView).inset(UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20))
        }
       
        secondView.backgroundColor = UIColor(hex6: 0xfff5c2)
        self.addSubview(secondView)
        secondView.snp.makeConstraints { make in
            make.left.equalTo(firstView.snp.right)
            make.centerY.equalTo(self.snp.centerY).inset(self.height / 4)
            make.width.equalTo(secondWidth)
            make.top.equalTo(self.snp.top)
            make.bottom.equalTo(self.snp.bottom)
        }
        
        mlabel.text = String(100 * secondData/totalData).prefix(2) + "%"
        mlabel.textAlignment = NSTextAlignment.center
        mlabel.sizeToFit()
        mlabel.textColor = .black
        mlabel.backgroundColor = UIColor(hex6: 0xfff5c2)
        self.addSubview(mlabel)
        mlabel.snp.makeConstraints { make in
            make.center.equalTo(secondView.snp.center)
            make.width.equalTo(secondView.snp.width).inset(20)
            make.height.equalTo(secondView.snp.height)
        }
        
        thirdView.backgroundColor = UIColor(hex6: 0xffeb86)
        self.addSubview(thirdView)
        thirdView.snp.makeConstraints { make in
            make.left.equalTo(secondView.snp.right)
            make.centerY.equalTo(self.snp.centerY).inset(self.height / 4)
            make.width.equalTo(thirdWidth)
            make.top.equalTo(self.snp.top)
            make.bottom.equalTo(self.snp.bottom)
        }
       
        rlabel.text = String(100 * thirdData/totalData).prefix(2) + "%"
        rlabel.textColor = .black
        rlabel.backgroundColor = UIColor(hex6: 0xffeb86)
        thirdView.addSubview(rlabel)
        rlabel.snp.makeConstraints { make in
            make.center.equalTo(thirdView.snp.center)
            make.width.equalTo(thirdView.snp.width).inset(20)
            make.height.equalTo(thirdView.height)
        }
        var tempView: UIView = UIView()
        if firstData != 0 {
            tempView = firstView
        }else if firstData == 0 && secondData != 0 {
            tempView = secondView
        }else if firstData == 0 && secondData == 0 && thirdData != 0 {
            tempView = thirdView
        }else{
            tempView = self
        }
        let leftbezierPath = UIBezierPath(roundedRect: tempView.bounds, byRoundingCorners: [.bottomLeft,.topLeft], cornerRadii: CGSize(width: self.height / 2, height: self.height / 2))
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
            tempView = self
        }
        let rightbezierPath = UIBezierPath(roundedRect: tempView.bounds, byRoundingCorners: [.bottomRight,.topRight], cornerRadii: CGSize(width: self.height / 2, height: self.height / 2))
        let rightshape: CAShapeLayer = CAShapeLayer()
        rightshape.fillColor = tempView.backgroundColor?.cgColor
        rightshape.path = rightbezierPath.cgPath
        rightshape.frame = tempView.bounds
        tempView.backgroundColor = .white
        tempView.layer.addSublayer(rightshape)
    }
}

