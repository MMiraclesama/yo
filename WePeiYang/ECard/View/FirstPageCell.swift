//
//  FirstPageCell.swift
//  WePeiYang
//
//  Created by 安宇 on 24/03/2019.
//  Copyright © 2019 twtstudio. All rights reserved.
//

import UIKit

class FirstPageCell: UITableViewCell {
    let PosLabel = UILabel()
    let Detail = UILabel()
    let Amount = UILabel()
    let WaysImage = UIImageView()
    
    func GetOneLine(str: String) -> Int {
        for i in 0..<str.count {
            if str.prefix(i).suffix(1) == "-" {
                return i - 1;
            }
        }
        return -1;
        
    }
    func GetTwoLine(str: String) -> Int {
        //
        var i = str.count
        while ( i != 0 ) {
            if str.suffix(str.count - i).prefix(1) == "-" {
                return i;
            }
            i = i - 1;
        }
        return -1;
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    convenience init() {
        self.init(style: .default, reuseIdentifier: "FirstPageTableViewCell")
        PosLabel.frame = CGRect(x: 70, y: 10, width: 200, height: 15)
        Detail.frame = CGRect(x: 70, y: 45, width: 200, height: 5)
        Amount.frame = CGRect(x: UIScreen.main.bounds.width / 2 + 50, y: 10, width: 60, height: 30)
        WaysImage.frame = CGRect(x: 40, y: 0, width: 40, height: 90)
        contentView.addSubview(PosLabel)
        contentView.addSubview(Detail)
        contentView.addSubview(Amount)
        contentView.addSubview(WaysImage)
    }
    
    convenience init(byModel DailyFee: ConsumeDetail, withIndex index: Int) {
        self.init(style: .default, reuseIdentifier: "FirstPageTableViewCell")
        PosLabel.frame = CGRect(x: 80, y: 18, width: 200, height: 15)
//        PosLabel.sizeToFit()
        var temptext: String = DailyFee.data[index].location
        if temptext.suffix(1) == "#" {
            temptext = String(temptext.prefix(temptext.count - 2))
        }
        let i = GetOneLine(str: temptext)
        if i == -1 {
            
        } else {
            let j = GetTwoLine(str: temptext)
            if GetTwoLine(str: temptext) == GetOneLine(str: temptext) {
                if temptext.prefix(j).suffix(1) == "区" {
                    temptext = String(temptext.suffix(temptext.count - j - 1))
                } else {
                    temptext = String(temptext.prefix(i))
                }
                
            } else {
                temptext = String(temptext.prefix(j).suffix(temptext.count - i))
            }
        }
        PosLabel.text = temptext
        PosLabel.font = UIFont.flexibleSystemFont(ofSize: 15)
        PosLabel.textColor = MyColor.ColorHex("#444444")
        Detail.frame = CGRect(x: 80, y: 55, width: 200, height: 5)
//        Detail.sizeToFit()
        let sub1 = (DailyFee.data[index].time as NSString).substring(with: NSMakeRange(0, 2))
        let sub2 = (DailyFee.data[index].time as NSString).substring(with: NSMakeRange(2, 2))
        if DailyFee.data[index].type == 2 {
            Detail.text = "POS机消费|" + sub1 + ":" + sub2
        } else {
            Detail.text = "充值|" + sub1 + ":" + sub2
        }
        Detail.font = UIFont.flexibleSystemFont(ofSize: 13)
        Detail.textColor = MyColor.ColorHex("#444444")
        
        Amount.frame = CGRect(x: UIScreen.main.bounds.width / 2 + 90, y: 20, width: 60, height: 30)
        if DailyFee.data[index].type == 2 {
            Amount.text = "-" + DailyFee.data[index].amount
        } else {
            Amount.text = "+" + DailyFee.data[index].amount
        }
        Amount.font = UIFont.flexibleSystemFont(ofSize: 17)
        Amount.textColor = .black
        if DailyFee.data[index].subtype == "食堂" {
            WaysImage.image = UIImage(named: "92")
            WaysImage.frame = CGRect(x: 23, y: PosLabel.frame.minY, width: 40, height: 42)
        } else if DailyFee.data[index].subtype == "超市" {
            WaysImage.image = UIImage(named: "购物车")
            WaysImage.frame = CGRect(x: 20, y: PosLabel.frame.minY - 10, width: 46, height: 49)
        } else {
            WaysImage.image = UIImage(named: "购物车")
            WaysImage.frame = CGRect(x: 20, y: PosLabel.frame.minY - 10, width: 46, height: 49)
        }
        
        contentView.addSubview(PosLabel)
        contentView.addSubview(Detail)
        contentView.addSubview(Amount)
        contentView.addSubview(WaysImage)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
}
//class SongsCell: UITableViewCell {
//    convenience init(byModel Songs: PlaylistDetail, withIndex index: Int) {
//        self.init(style: .default, reuseIdentifier: "SongsDetailTableViewCell")
//
//        TitleLabel.frame = CGRect(x: 20, y: 10, width: UIScreen.main.bounds.width - 20, height: 40)
//
//        contentView.addSubview(TitleLabel)
//
//
//        TitleLabel.text = Songs.tracks[index].name
//
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//}
