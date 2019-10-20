//
//  ECardFirstPageView.swift
//  WePeiYang
//
//  Created by 王申宇 on 2019/7/3.
//  Copyright © 2019 twtstudio. All rights reserved.
//

import UIKit
import SnapKit

class ECardCardView: UIView {
    let ecardLabel = UILabel()
    let todayCosume = UILabel()
    let monthConsume = UILabel()
    let userName = UILabel()
    let balance = UILabel()
    let cardId = UILabel()
    let notice = UILabel()
    let ecardImage = UIImageView()
    
    func AddView() {
        ecardLabel.backgroundColor = UIColor(hex6: 0xffeb86)
        ecardLabel.layer.masksToBounds = true
        ecardLabel.layer.cornerRadius = 20
        
        balance.textColor = UIColor(hex6: 0x444444)
        cardId.textColor = UIColor(hex6: 0x555555)
        notice.textColor = UIColor(hex6: 0xa84b4b)
        
        cardId.font = UIFont.flexibleSystemFont(ofSize: 12)
        balance.font = UIFont.flexibleSystemFont(ofSize: 33)
        todayCosume.font = UIFont.flexibleSystemFont(ofSize: 14)
        monthConsume.font = UIFont.flexibleSystemFont(ofSize: 14)
        userName.font = UIFont.flexibleSystemFont(ofSize: 12)
        
        ecardImage.image = UIImage.resizedImage(image: UIImage(named: "ecard")!, scaledToSize: CGSize(width: 215, height: 200))
        
        self.addSubview(ecardLabel)
        ecardLabel.snp.makeConstraints { make in
            make.center.equalTo(self.snp.center)
            make.edges.equalTo(self).inset(UIEdgeInsets(top: 15, left: 20, bottom: -20, right: 20))
        }
        
        ecardLabel.addSubview(cardId)
        cardId.snp.makeConstraints { make in
            make.top.equalTo(ecardLabel.snp.top).inset(15)
            make.left.equalTo(ecardLabel.snp.left).inset(20)
            make.width.equalTo(self.width / 2)
            make.height.equalTo(self.height / 5)
        }
        
        ecardLabel.addSubview(balance)
        balance.snp.makeConstraints { make in
            make.top.equalTo(cardId.snp.bottom)
            make.left.equalTo(ecardLabel.snp.left).inset(20)
            make.width.equalTo(self.width / 3)
            make.height.equalTo(self.height / 4)
        }
        
        ecardLabel.addSubview(todayCosume)
        todayCosume.snp.makeConstraints { make in
            make.top.equalTo(balance.snp.bottom)
            make.left.equalTo(ecardLabel.snp.left).inset(20)
            make.width.equalTo(self.width / 3)
            make.height.equalTo(self.height / 5)
        }
        
        ecardLabel.addSubview(monthConsume)
        monthConsume.snp.makeConstraints { make in
            make.top.equalTo(todayCosume.snp.bottom)
            make.left.equalTo(ecardLabel.snp.left).inset(20)
            make.width.equalTo(self.width / 3)
            make.height.equalTo(self.height / 5)
        }
        
        ecardLabel.addSubview(ecardImage)
        ecardImage.snp.makeConstraints { make in
            make.top.equalTo(ecardLabel.snp.top)
            make.right.equalTo(ecardLabel.snp.right)
        }
        
        ecardLabel.addSubview(userName)
        userName.snp.makeConstraints { make in
            make.top.equalTo(monthConsume.snp.top)
            make.right.equalTo(ecardLabel.snp.right)
            make.width.equalTo(self.width / 3)
            make.height.equalTo(self.height / 5)
        }
        
    }
}

class ECardHomePageFirstHeaderView: UIView {
    let sign = UILabel()
    let dailyFeeLabel = UILabel()
    let date = UILabel()
    let moreMessageButton = UIButton()
    let formatter = DateFormatter()
    
    func AddView() {
        sign.backgroundColor = UIColor(hex6: 0xfbe98e)
        
        dailyFeeLabel.text = "今日流水"
        dailyFeeLabel.backgroundColor = .white
        dailyFeeLabel.font = UIFont.flexibleSystemFont(ofSize: 15)
        dailyFeeLabel.textColor = UIColor(hex6: 0x333333)
        
        date.font = UIFont.flexibleSystemFont(ofSize: 12)
        date.backgroundColor = .white
        date.textColor = UIColor(hex6: 0x666666)
        formatter.dateFormat = "MM/ dd "
        date.text = formatter.string(from: NSDate() as Date)
        
        moreMessageButton.backgroundColor = .white
        moreMessageButton.setTitle("更多流水 >", for: .normal)
        moreMessageButton.setTitleColor(UIColor(hex6: 0x737373), for: .normal)
        moreMessageButton.titleLabel?.adjustsFontSizeToFitWidth = true

        self.addSubview(sign)
        sign.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).inset(10)
            make.left.equalTo(20)
            make.height.equalTo(17)
            make.width.equalTo(5)
        }
        
        self.addSubview(dailyFeeLabel)
        dailyFeeLabel.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).inset(10)
            make.left.equalTo(sign.snp.right).inset(-3)
            make.height.equalTo(17)
            make.width.equalTo(Device.width / 2)
        }
        
        self.addSubview(date)
        date.snp.makeConstraints { make in
            make.top.equalTo(dailyFeeLabel.snp.bottom).inset(-10)
            make.left.equalTo(sign.snp.right)
            make.height.equalTo(12)
            make.width.equalTo(Device.width / 2)
        }
        
        self.addSubview(moreMessageButton)
        moreMessageButton.snp.makeConstraints { make in
            make.right.equalTo(self.snp.right).inset(25)
            make.centerY.equalTo(self.snp.centerY).inset(5)
            make.width.equalTo(80)
            make.height.equalTo(40)
        }
    }
}

class ECardHomePageFirstFooterView: UIView {
    let foldMessage = UILabel()
    let scanButton = UIButton()
    
    func AddView() {
        foldMessage.backgroundColor = .white
        foldMessage.font = UIFont.flexibleSystemFont(ofSize: 12)
        foldMessage.textAlignment = .center
        foldMessage.textColor = UIColor(hex6: 0xB2B2B2)

        scanButton.setTitle("点击显示", for: .normal)
        scanButton.backgroundColor = .white
        scanButton.setTitleColor(UIColor(hex6: 0x5E8DC5), for: .normal)
        scanButton.titleLabel?.font = UIFont.flexibleSystemFont(ofSize: 12)
        
        self.addSubview(foldMessage)
        foldMessage.snp.makeConstraints { make in
            make.centerY.equalTo(self.snp.centerY)
            make.centerX.equalTo(self.snp.centerX).inset(-30)
            make.width.equalTo(90)
            make.height.equalTo(11)
        }
        
        self.addSubview(scanButton)
        scanButton.snp.makeConstraints { make in
            make.left.equalTo(foldMessage.snp.right).inset(-5)
            make.top.equalTo(foldMessage.snp.top)
            make.width.equalTo(76)
            make.height.equalTo(11)
        }
    }
}

class ECardHomePageSecondHeaderView: UIView {
    let sign = UILabel()
    let help = UILabel()
    
    func AddView() {
        sign.backgroundColor = UIColor(hex6: 0xfbe98e)
        
        help.backgroundColor = .white
        help.font = UIFont.flexibleSystemFont(ofSize: 15)
        help.text = "帮助"
        help.textColor = UIColor(hex6: 0x222222)
        
        self.addSubview(sign)
        sign.snp.makeConstraints { make in
            make.centerY.equalTo(self.snp.centerY)
            make.left.equalTo(20)
            make.height.equalTo(17)
            make.width.equalTo(5)
        }
        
        self.addSubview(help)
        help.snp.makeConstraints { make in
            make.left.equalTo(sign.snp.right).inset(-3)
            make.top.equalTo(sign.snp.top)
            make.width.equalTo(Device.width / 2)
            make.height.equalTo(sign.snp.height)
        }
    }
}
