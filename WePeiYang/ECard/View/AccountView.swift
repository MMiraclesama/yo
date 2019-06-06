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
        let lchangeimage = UIImage.resizedImage(image: UIImage(named: "选择三角左")!, scaledToSize: CGSize(width: 27, height: 27))
        leftTriangle.setImage(lchangeimage, for: .normal)
        
        rightTriangle.setImage(UIImage.resizedImage(image: UIImage(named: "选择三角右")!, scaledToSize: CGSize(width: 27, height: 27)), for: .highlighted)
        
        self.addSubview(dayLabel)
        self.addSubview(leftTriangle)
        self.addSubview(rightTriangle)

        dayLabel.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.height.equalTo(27)
            make.centerX.equalTo(self.snp.centerX)
            make.centerY.equalTo(self.snp.centerY)
        }

        leftTriangle.snp.makeConstraints { (make) -> Void in
            make.width.height.equalTo(27)
            make.edges.equalTo(dayLabel).inset(UIEdgeInsets(top: 0, left: 42, bottom: 0, right: 115))
        }

        rightTriangle.snp.makeConstraints { (make) -> Void in
            make.width.height.equalTo(27)
            make.edges.equalTo(dayLabel).inset(UIEdgeInsets(top: 0, left: -115, bottom: 0, right: -42))
        }
    }
}

class AccountTableView: UIView {
    let accTableView = UITableView()
    var tuenover: ConsumeDetail!

    func AddView() {
        accTableView.showsVerticalScrollIndicator = false
        accTableView.showsHorizontalScrollIndicator = false
        accTableView.allowsSelection = false
        accTableView.bounces = false
        accTableView.backgroundColor = .white
        accTableView.delegate = self
        accTableView.dataSource = self
        self.addSubview(accTableView)

        accTableView.snp.makeConstraints{ (make) -> Void in
            make.edges.equalTo(self)
        }
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

//class LineTableView: UIView {
//    let lineTableView = UITableView()
//    var linecharts: LintChart!
//    let ecardLineView = EcardLineChartsView()
//
//    func AddView() {
//        lineTableView.showsHorizontalScrollIndicator = false
//        lineTableView.showsVerticalScrollIndicator = false
//        lineTableView.allowsSelection = false
//        lineTableView.bounces = false
//        lineTableView.backgroundColor = .white
//        lineTableView.delegate = self
//        lineTableView.dataSource = self
//    }
//}
//extension LineTableView: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let lineScroll = UIScrollView()
//        lineScroll.bounces = false
//        lineScroll.showsHorizontalScrollIndicator = false
//        lineScroll.showsVerticalScrollIndicator = false
//        lineScroll.backgroundColor = .white
//        lineScroll.contentOffset = CGPoint(x: 0, y: 0)
//        lineScroll.addSubview(ecardLineView.AccountlineChartView)
//
//        lineScroll.snp.makeConstraints { (make) -> Void in
//
//        }
//
//    }
//    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
//
//    }
//}
//extension LineTableView: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        <#code#>
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        <#code#>
//    }
//
//
//}

class AccountScrollView: UIView {
    let accScroll = UIScrollView()

    func AddView() {
        accScroll.backgroundColor = .white
        accScroll.showsVerticalScrollIndicator = false
        accScroll.showsHorizontalScrollIndicator = false
        accScroll.contentSize = CGSize(width: 2 * Device.width, height: Device.height * 3 / 4)
        accScroll.contentOffset = CGPoint(x: 0, y: 0)
        accScroll.delegate = self
        accScroll.bounces = false
        self.addSubview(accScroll)

        accScroll.snp.makeConstraints{ (make) -> Void in
            make.edges.equalTo(self)
        }
    }
}
extension AccountScrollView: UIScrollViewDelegate {

}
