//
//  AccountView.swift
//  WePeiYang
//
//  Created by 王申宇 on 2019/5/23.
//  Copyright © 2019 twtstudio. All rights reserved.
//

import UIKit
import SnapKit

class LastedDay: UIView {
    let dayLabel = UILabel()
    let leftTriangle = UIButton()
    let rightTriangle = UIButton()

    func AddView() {
        dayLabel.backgroundColor = UIColor(hex6: 0xffeb86)
        dayLabel.text = "最近7天"
        dayLabel.textAlignment = NSTextAlignment.center
        dayLabel.layer.masksToBounds = true
        dayLabel.layer.cornerRadius = 15
        
        leftTriangle.setImage(UIImage.resizedImage(image: UIImage(named: "选择三角左")!, scaledToSize: CGSize(width: 27, height: 27)), for: .normal)
        
        rightTriangle.setImage(UIImage.resizedImage(image: UIImage(named: "选择三角右")!, scaledToSize: CGSize(width: 27, height: 27)), for: .normal)
        
        self.addSubview(dayLabel)
        self.addSubview(leftTriangle)
        self.addSubview(rightTriangle)

        dayLabel.snp.makeConstraints { make in
            make.width.equalTo(90)
            make.height.equalTo(27)
            make.centerX.equalTo(self.snp.centerX)
            make.centerY.equalTo(self.snp.centerY)
        }

        leftTriangle.snp.makeConstraints { make in
            make.width.height.equalTo(27)
            make.right.equalTo(dayLabel.snp.left)
            make.top.equalTo(dayLabel.snp.top)
        }

        rightTriangle.snp.makeConstraints { make in
            make.width.height.equalTo(27)
            make.left.equalTo(dayLabel.snp.right)
            make.top.equalTo(dayLabel.snp.top)
        }
    }
}

class AccountTableView: UITableView {
    var tuenover: ConsumeDetail!

    func AddView() {
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
        self.allowsSelection = false
        self.bounces = false
        self.backgroundColor = .white
        self.delegate = self
        self.dataSource = self
    }
}
extension AccountTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
extension AccountTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tuenover == nil {return FirstPageCell()}
        return FirstPageCell(byModel: tuenover, withIndex: indexPath.row)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tuenover == nil { return 0 }
        return tuenover.data.count
    }
}

class LineTableView: UITableView {
    let lineScroll = UIScrollView()
    var linecharts: LintChart!
    let ecardLineView = EcardLineChartsView()
    let scaleview: ScaleLabelView = ScaleLabelView()
    let lineHeaderView = UIView()
    let ecardHeaderView = ECardHomePageSecondHeaderView()
    let scaleLabelView = ScaleLabelView()

    func AddView() {
        self.showsHorizontalScrollIndicator = false
        self.showsVerticalScrollIndicator = false
        self.allowsSelection = false
        self.bounces = false
        self.backgroundColor = .white
        self.delegate = self
        self.dataSource = self
    }
}
extension LineTableView: UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 0
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return Device.height / 4
        } else if section == 1{
            return 65
        } else {
            return 30
        }
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            lineScroll.bounces = false
            lineScroll.showsHorizontalScrollIndicator = false
            lineScroll.showsVerticalScrollIndicator = false
            lineScroll.backgroundColor = .white
            lineScroll.contentOffset = CGPoint(x: 0, y: 0)
            
            lineHeaderView.addSubview(lineScroll)
            lineScroll.snp.makeConstraints { make in
                make.center.equalTo(lineHeaderView.snp.center)
                make.edges.equalTo(self.lineHeaderView).inset(UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20))
            }
            lineScroll.addSubview(ecardLineView.AccountlineChartView)
            
            return lineHeaderView
        } else if section == 1 {
            ecardHeaderView.AddView()
            ecardHeaderView.help.text = "消费占比"
            return ecardHeaderView
        } else if section == 2{
            scaleLabelView.LabelScale(num3, num2, num1)
            return scaleLabelView
        } else {
            return UIView()
        }
    }
}
extension LineTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

class EcardAccountHeaderView: UIView {
    let costLabel = UILabel()
    let rechangLabel = UILabel()
    
    func AddView() {
        costLabel.backgroundColor = .white
        costLabel.font = UIFont.flexibleSystemFont(ofSize: 12)
        costLabel.textColor = UIColor(hex6: 0x444444)
        
        rechangLabel.backgroundColor = .white
        rechangLabel.font = UIFont.flexibleSystemFont(ofSize: 12)
        rechangLabel.textColor = UIColor(hex6: 0x444444)
        
        self.addSubview(costLabel)
        costLabel.snp.makeConstraints { make in
            make.left.equalTo(self.snp.left).inset(Device.width / 4 - 5)
            make.centerY.equalTo(self.snp.centerY)
            make.width.equalTo(Device.width / 4)
            make.height.equalTo(30)
        }
        
        self.addSubview(rechangLabel)
        rechangLabel.snp.makeConstraints { make in
            make.left.equalTo(self.snp.left).inset(Device.width / 2 + 10)
            make.centerY.equalTo(self.snp.centerY)
            make.width.equalTo(Device.width / 5)
            make.height.equalTo(30)
        }
    }
}

class ECardCostScaleHeaderView: UIView {
    let messCostFront = UILabel()
    let messCost = UILabel()
    let marketCostFront = UILabel()
    let marketCost = UILabel()
    let otherCostFront = UILabel()
    let otherCost = UILabel()
    let messScale = UIView()
    let marketScale = UIView()
    let otherScale = UIView()
    
    func AddView() {
        
    }
    
}

class AccountScrollView: UIScrollView {
    func AddView() {
        self.backgroundColor = .white
        self.isScrollEnabled = true
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
        self.contentSize = CGSize(width: 2 * Device.width, height: Device.height * 3 / 4)
        self.contentOffset = CGPoint(x: 0, y: 0)
        self.delegate = self
        self.bounces = false
    }
}
extension AccountScrollView: UIScrollViewDelegate {
    
}
