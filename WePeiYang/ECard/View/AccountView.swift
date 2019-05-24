//
//  AccountView.swift
//  WePeiYang
//
//  Created by 王申宇 on 2019/5/23.
//  Copyright © 2019 twtstudio. All rights reserved.
//

import UIKit

class AccountView: UIView {
    var DayLabel = UILabel()
    var tuenover: ConsumeDetail!
    var accountTableview = UITableView(frame: .zero, style: .grouped)
    var leftButton = UIButton()
    var rightButton = UIButton()
    var scrollerview: UIScrollView!
    var lineScrollerView: UIScrollView!
    var dateScrollerView: UIScrollView!
    var shapeLayer: CAShapeLayer!
    var costLabel = UILabel() //消费
    var rechargeLabel = UILabel() // 充值
    var lineScrollerLength: CGFloat = ScaleScreen.scaleWidth * CGFloat(215 * (Figure.term + 1))
    //折线图长度（可变）
    var cost = UILabel() //
    var costsign = UILabel()
    var dateScrollViewLeftLabel = UILabel()
    var dateScrollViewRightLabel = UILabel()
    
    var messCostFront = UILabel()
    var marketCostFront = UILabel()
    var otherCostFront = UILabel()
    var messCost = UILabel() //食堂
    var marketCost = UILabel() //超市
    var otherCost = UILabel() //其他
    var messScale = UIView()
    var marketScale = UIView()
    var otherScale = UIView()
    var dateview = UIView()
    var dateArray = [UILabel]() //折线图下的日期
    var slideBackView: UIView! // ScrollerView滚动条背景
    var slideView: UIView! //ScrollerView滚动块
    var pointView: UIImageView!
    var lineView: UIImageView!
    //构建三角形button
    var datetext = [String]()
    var point = [CGPoint]()
    var scaleview: ScaleLabelView = ScaleLabelView()
    var lintView: EcardLineChartsView = EcardLineChartsView()
    var sjsw: CGRect = CGRect(x: Device.width + 30, y: 470, width: 360, height: 26)
    var moneyOfYours: MoneyTest = MoneyTest()
    
    func addAllSubviews(){
        accountTableview.frame = CGRect(x: 0, y: -20 , width: Device.width, height: Device.height)
        accountTableview.delegate = self
        accountTableview.dataSource = self
        accountTableview.showsVerticalScrollIndicator = false
        accountTableview.bounces = false
        accountTableview.backgroundColor = .white
        DayLabel.frame = CGRect(x: Device.width / 2 - 50, y: 15, width: 100, height: 27)
        DayLabel.backgroundColor = MyColor.ColorHex("#ffeb86")
        DayLabel.text = "最近7天"
        DayLabel.textAlignment = NSTextAlignment.center
        DayLabel.layer.masksToBounds = true
        DayLabel.layer.cornerRadius = 15
        addSubview(DayLabel)
        leftButton.frame = CGRect(x: DayLabel.frame.minX - 35, y: 15, width: 27, height: 27)
        let lchangeimage = UIImage.resizedImage(image: UIImage(named: "选择三角左")!, scaledToSize: CGSize(width: 27, height: 27))
        leftButton.setImage(lchangeimage, for: .normal)
        //        leftButton.backgroundColor.
//        leftButton.addTarget(self, action: #selector(LessList), for: .touchUpInside)
        addSubview(leftButton)
        rightButton.frame = CGRect(x: DayLabel.frame.maxX + 8, y: 15, width: 27, height: 27)
        let rchangeimage = UIImage.resizedImage(image: UIImage(named: "选择三角右")!, scaledToSize: CGSize(width: 27, height: 27))
        rightButton.setImage(rchangeimage, for: .normal)
//        rightButton.addTarget(self, action: #selector(MoreList), for: .touchUpInside)
        addSubview(rightButton)
        costLabel.text = "消费：\(String(num1 + num2 + num3).prefix(5))元"
        costLabel.frame = CGRect(x: Device.width + 230 * 1.15 / 3, y: 10, width: 200, height: 56 * 1.15 / 3)
        rechargeLabel.text = "充值：\(String(num4).prefix(5))元"
        rechargeLabel.frame = CGRect(x: Device.width + 650 * 1.15 / 3, y: 10, width: 150, height: 56 * 1.15 / 3)
        
        cost = UILabel(frame:CGRect(x: Device.width + 30 * 1.15, y: 430, width: Device.width * 4 / 5, height: 20))
        cost.text = "消费占比"
        cost.font = UIFont.flexibleSystemFont(ofSize: 19)
        addSubview(cost)
        
        costsign = UILabel(frame: CGRect(x: cost.frame.minX - 14, y: cost.frame.minY - 10, width: 10, height: 30))
        costsign.backgroundColor = MyColor.ColorHex("#ffeb86")
        
        messCostFront.frame = CGRect(x: Device.width + 85 * 1.15 / 3, y: cost.frame.maxY + 52, width: 10, height: 10)
        messCostFront.backgroundColor = MyColor.ColorHex("#f8d316")
        messCostFront.layer.masksToBounds = true
        messCostFront.layer.cornerRadius = messCostFront.bounds.size.width / 2
        
        messCost.frame = CGRect(x: messCostFront.frame.maxX + 2, y: messCostFront.frame.minY, width: 105, height: 10)
        messCost.backgroundColor = .white
        messCost.text = "食堂:\(num3)元"
        messCost.font = UIFont.flexibleSystemFont(ofSize: 13)
        
        marketCostFront.frame = CGRect(x: messCost.frame.maxX + 12 , y: cost.frame.maxY + 52, width: 10, height: 10)
        marketCostFront.backgroundColor = MyColor.ColorHex("#fff5c2")
        marketCostFront.layer.masksToBounds = true
        marketCostFront.layer.cornerRadius = messCostFront.bounds.size.width / 2
        
        marketCost.frame = CGRect(x: marketCostFront.frame.maxX + 2, y: cost.frame.maxY + 52, width: 105, height: 10)
        marketCost.backgroundColor = .white
        marketCost.text = "超市:\(num2)元"
        marketCost.font = UIFont.flexibleSystemFont(ofSize: 13)
        
        otherCostFront.frame = CGRect(x: marketCost.frame.maxX + 2 , y: cost.frame.maxY + 52 , width: 10, height: 10)
        otherCostFront.backgroundColor = MyColor.ColorHex("#ffeb86")
        otherCostFront.layer.masksToBounds = true
        otherCostFront.layer.cornerRadius = otherCostFront.bounds.size.width / 2
        
        otherCost.frame = CGRect(x: otherCostFront.frame.maxX + 2, y: cost.frame.maxY + 52 , width: 120, height: 10)
        otherCost.backgroundColor = .white
        otherCost.text = "其他:\(num1)元"
        otherCost.font = UIFont.flexibleSystemFont(ofSize: 13)
    }
    
    func addDateLabel() {
        dateScrollViewRightLabel.frame = CGRect(x: dateScrollerView.frame.maxX + 5, y: dateScrollerView.frame.minY + 7, width: 30, height: dateScrollerView.frame.height)
        dateScrollViewRightLabel.text = "日"
        dateScrollViewRightLabel.textColor = MyColor.ColorHex("#e3cca1")
        dateScrollViewRightLabel.backgroundColor = .white
        self.scrollerview.addSubview(dateScrollViewRightLabel)
        
        dateScrollViewLeftLabel.frame = CGRect(x: dateScrollerView.frame.minX - 30, y: dateScrollerView.frame.minY + 7, width: 40, height: dateScrollerView.frame.height)
        dateScrollViewLeftLabel.textColor = MyColor.ColorHex("#e3cca1")
        dateScrollViewLeftLabel.backgroundColor = .white
        self.scrollerview.addSubview(dateScrollViewLeftLabel)
    }
    //很多scrollerview
    func addScrollerView() {
        scrollerview = UIScrollView(frame: CGRect(x: 0, y: 57, width: Device.width, height: Device.height * 2 / 3))
        scrollerview.isPagingEnabled = true
        scrollerview.backgroundColor = .white
        scrollerview.showsHorizontalScrollIndicator = false
        scrollerview.showsVerticalScrollIndicator = false
        scrollerview.contentSize = CGSize(width: Device.width*2,height: Device.height )
        scrollerview.contentOffset = CGPoint(x: 0, y: 0.0)
        scrollerview.delegate = self
        scrollerview.bounces = false
        
        lineScrollerView = UIScrollView(frame:CGRect(x: Device.width + 37, y: 145 * 1.15 / 3, width: Device.width - 75, height: 623 * 1.15 / 3))
        //        lineScrollerView.isPagingEnabled = true
        lineScrollerView.backgroundColor = .white
        lineScrollerView.showsHorizontalScrollIndicator = false
        lineScrollerView.showsVerticalScrollIndicator = false
        lineScrollerView.contentOffset = CGPoint(x: 0, y: 0)
        lineScrollerView.delegate = self
        lineScrollerView.bounces = false
        //FIXME: - 下挪 高度变小
        dateScrollerView = UIScrollView(frame: CGRect(x: lineScrollerView.frame.minX, y: lineScrollerView.frame.maxY + 30, width: lineScrollerView.frame.width, height: 60 * ScaleScreen.scaleHeight))
        dateScrollerView.isPagingEnabled = true
        dateScrollerView.backgroundColor = .white
        dateScrollerView.showsHorizontalScrollIndicator = false
        dateScrollerView.showsVerticalScrollIndicator = false
        dateScrollerView.contentOffset = CGPoint(x: 0, y: 0)
        dateScrollerView.delegate = self
        dateScrollerView.bounces = false
        //FIXME: - 这两个宽度变窄
        slideBackView = UIView(frame: CGRect(x: lineScrollerView.frame.minX, y: lineScrollerView.frame.maxY + 17, width: lineScrollerView.frame.width, height: 8))
        slideBackView.backgroundColor = MyColor.ColorHex("#fff5c2")
        slideBackView.layer.cornerRadius = 4
        
        slideView = UIView(frame: CGRect(x: lineScrollerView.frame.minX , y: lineScrollerView.frame.maxY + 17, width: lineScrollerView.frame.width / 10, height: 8))
        slideView.backgroundColor = MyColor.ColorHex("#ffe043")
        slideView.layer.cornerRadius = 3.5
        
        self.scrollerview.addSubview(accountTableview)
        self.scrollerview.addSubview(cost)
        self.lineScrollerView.addSubview(lintView.AccountlineChartView)
        self.scrollerview.addSubview(lineScrollerView)
        self.scrollerview.addSubview(slideBackView)
        self.scrollerview.addSubview(slideView)
        self.dateScrollerView.addSubview(dateview)
        self.scrollerview.addSubview(dateScrollerView)
        addSubview(scrollerview)
    }
    
    func addOtherView() {
        pointView = UIImageView(frame: CGRect(x: Device.width / 2  - 40, y: scrollerview.frame.maxY + 30, width: 30 * ScaleScreen.scaleWidth, height: 30 * ScaleScreen.scaleWidth))
        pointView.image = UIImage.resizedImage(image: UIImage(named: "未标题-1")!, scaledToSize: CGSize(width: 30 * ScaleScreen.scaleWidth, height: 30 * ScaleScreen.scaleWidth))
        addSubview(pointView)
        
        lineView = UIImageView(frame: CGRect(x: pointView.frame.maxX + 10, y: pointView.frame.minY, width: 100 * ScaleScreen.scaleWidth, height: 30 * ScaleScreen.scaleWidth))
        lineView.image = UIImage.resizedImage(image: UIImage(named: "bottom2")!, scaledToSize: CGSize(width: 100 * ScaleScreen.scaleWidth, height: 30 * ScaleScreen.scaleWidth))
        addSubview(lineView)
        
        self.scrollerview.addSubview(self.scaleview.llabel)
        self.scrollerview.addSubview(self.scaleview.mlabel)
        self.scrollerview.addSubview(self.scaleview.rlabel)
        self.scrollerview.addSubview(costLabel)
        self.scrollerview.addSubview(rechargeLabel)
        self.scrollerview.addSubview(costsign)
        self.scrollerview.addSubview(otherCostFront)
        self.scrollerview.addSubview(marketCostFront)
        self.scrollerview.addSubview(messCostFront)
        self.scrollerview.addSubview(messCost)
        self.scrollerview.addSubview(marketCost)
        self.scrollerview.addSubview(otherCost)
    }
}

extension AccountView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if scrollView == lineScrollerView {
            UIView.animate(withDuration: 0, animations: {
                
                let offset: CGPoint = scrollView.contentOffset
                
                var frame: CGRect = self.slideView.frame
                self.dateScrollerView.contentOffset = scrollView.contentOffset
                
                frame.origin.x = self.lineScrollerView.frame.minX + offset.x * (self.slideBackView.frame.size.width - self.slideView.frame.size.width) / (scrollView.contentSize.width - scrollView.frame.size.width)
                
                self.slideView.frame = frame
            })
        } else if scrollView == scrollerview {
            UIView.animate(withDuration: 0, animations: {
                
                let offset: CGPoint = scrollView.contentOffset
                
                var pointFrame: CGRect = self.pointView.frame
                var lineFrame: CGRect = self.lineView.frame
                
                pointFrame.origin.x = Device.width / 2 - 40 + 2 * offset.x * (90 * ScaleScreen.scaleWidth - self.pointView.frame.width) / (scrollView.contentSize.width - scrollView.frame.size.width)
                
                let temp = 20 * offset.x * (90 * ScaleScreen.scaleWidth - self.lineView.frame.width) / (scrollView.contentSize.width - scrollView.frame.size.width)
                
                lineFrame.origin.x = self.pointView.frame.maxX + 20 + temp
                self.pointView.frame = pointFrame
                self.lineView.frame = lineFrame
            })
            //        } else if scrollView == dateScrollerView {
            //
            //            UIView.animate(withDuration: 0, animations: {
            //                let offset: CGPoint = scrollView.contentOffset
            //
            //                for i in 0..<tempx.count {
            //                    if offset.x + 20 == self.dateArray[i].frame.minX {
            //                        self.dateScrollViewLeftLabel.text = "\(self.lintchart.data2[self.lintchart.data2.count - Figure.term - 1 + i].date.suffix(4).prefix(2))月"
            //                    }
            //                }
            //            })
        }
    }
}

extension AccountView: UITableViewDelegate {
}
extension AccountView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tuenover == nil {return FirstPageCell()}
        return FirstPageCell(byModel: tuenover, withIndex: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tuenover == nil { return 0 }
        return tuenover.data.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
