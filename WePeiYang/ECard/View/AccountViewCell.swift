//
//  AccountViewCell.swift
//  WePeiYang
//
//  Created by 王申宇 on 2019/3/24.
//  Copyright © 2019 twtstudio. All rights reserved.
//

import UIKit

struct Scale {
    let sc = 1.15 / 3
}

class AccountViewCell: UITableViewCell {
    
    //var turnover: Tuenover!
    let Date = UILabel()
    let Time = UILabel()
    let Location = UILabel()
    let Amount = UILabel()
    let Balance = UILabel()
    var type = 0
    let Subtype = UILabel()
    let LocalView = UIView()
    
    convenience init() {
        self.init(style: .default, reuseIdentifier: "SongsDetailTableViewCell")
        Date.frame = CGRect(x: 200, y: 40, width: 100, height: 30)
        contentView.addSubview(Date)
        Time.frame = CGRect(x: 300, y: 40, width: 100, height: 30)
        contentView.addSubview(Time)
        Location.frame = CGRect(x: 200, y: 10, width: 100, height: 50)
        contentView.addSubview(LocalView)
        Amount.frame = CGRect(x: 1000, y: 20, width: 100, height: 30)
        contentView.addSubview(Amount)
        LocalView.frame = CGRect(x: 10, y: 10, width: 50, height: 50)
        contentView.addSubview(LocalView)
    }
    
    convenience init(byModel turnover: ConsumeDetail, withIndex index: Int) {
        self.init(style: .default, reuseIdentifier: "SongsDetailTableViewCell")
        Date.frame = CGRect(x: 200, y: 40, width: 100, height: 30)
        Date.text = "POS机消费|" + turnover.data[index].date
        contentView.addSubview(Date)
        Time.frame = CGRect(x: 300, y: 40, width: 100, height: 30)
        Time.text = turnover.data[index].time
        contentView.addSubview(Time)
        Location.frame = CGRect(x: 200, y: 10, width: 100, height: 50)
        Location.text = turnover.data[index].location
        contentView.addSubview(LocalView)
        Amount.frame = CGRect(x: 1000, y: 20, width: 100, height: 30)
        if turnover.data[index].type == 1 {
            Amount.text = "+" + turnover.data[index].amount
        }
        Amount.text = "-" + turnover.data[index].amount
        contentView.addSubview(Amount)
        LocalView.frame = CGRect(x: 10, y: 10, width: 50, height: 50)
        //
        contentView.addSubview(LocalView)
    }
}
