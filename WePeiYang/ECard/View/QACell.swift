//
//  QACell.swift
//  WePeiYang
//
//  Created by 安宇 on 06/04/2019.
//  Copyright © 2019 twtstudio. All rights reserved.
//

import UIKit
class DetailInformationElementCell: UITableViewCell {
    let aLabel = UILabel()
    let qLabel = UILabel()
    let qImage = UIImageView()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    convenience init() {
        self.init(style: .default, reuseIdentifier: "QATableViewCell")
        aLabel.frame = CGRect(x: 80, y: 5, width: UIScreen.main.bounds.width - 80, height: 60)
        qLabel.frame = CGRect(x: 40, y: 45, width: UIScreen.main.bounds.width - 80, height: 200)
        qImage.frame = CGRect(x: 20, y: 5, width: 20, height: 20)
        aLabel.lineBreakMode = .byWordWrapping
        aLabel.numberOfLines = 0
//        aLabel.sizeToFit()
        qLabel.lineBreakMode = .byWordWrapping
        qLabel.numberOfLines = 0
//        qLabel.sizeToFit()
        //        aLabel.font = UIFont.systemFontSize(10)
        //        qLabel.font = UIFont.systemFontSize(10)
        contentView.addSubview(aLabel)
        contentView.addSubview(qLabel)
        contentView.addSubview(qImage)
    }
    
    convenience init(withIndex index: Int) {
        self.init(style: .default, reuseIdentifier: "QATableViewCell")
        if index == 3 {
             qLabel.frame = CGRect(x: 40, y: 20, width: UIScreen.main.bounds.width - 80, height: 100)
        } else {
            qLabel.frame = CGRect(x: 40, y: 45, width: UIScreen.main.bounds.width - 80, height: 200)
        }
        aLabel.frame = CGRect(x: 80, y: 5, width: UIScreen.main.bounds.width - 120, height: 60)
        
        qImage.frame = CGRect(x: 40, y: 10, width: 5, height: 100)
//        aLabel.text = question[index]
//        aLabel.sizeToFit()
        aLabel.lineBreakMode = .byWordWrapping
        aLabel.numberOfLines = 0
//        qLabel.text = answer[index]
//                qLabel.sizeToFit()
        qLabel.lineBreakMode = .byWordWrapping
        qLabel.numberOfLines = 0
        qImage.image = UIImage(named: "?")
                aLabel.font = UIFont.flexibleSystemFont(ofSize: 10)
                qLabel.font = UIFont.flexibleSystemFont(ofSize: 10)
        contentView.addSubview(aLabel)
        contentView.addSubview(qLabel)
        contentView.addSubview(qImage)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
