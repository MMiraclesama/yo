//
//  QACell.swift
//  WePeiYang
//
//  Created by 安宇 on 06/04/2019.
//  Copyright © 2019 twtstudio. All rights reserved.
//

import UIKit
import SnapKit

class DetailInformationElementCell: UITableViewCell {
    let myTextLabel = UILabel()
    let myDetailTextLabel = UILabel()
    let myImageView = UIImageView()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    convenience init() {
        self.init(style: .default, reuseIdentifier: "QATableViewCell")
        
        contentView.addSubview(myTextLabel)
        contentView.addSubview(myDetailTextLabel)
        contentView.addSubview(myImageView)
        myImageView.snp.makeConstraints { (make) in
            make.top.equalTo(20)
            make.left.equalTo(10)
            make.width.equalTo(20)
            make.height.equalTo(20)
        }
        myTextLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.myImageView.snp.right).offset(10)
            make.top.equalTo(self.myImageView.snp.top)
            make.right.equalToSuperview().offset(-20)
        }
        myDetailTextLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.myTextLabel.snp.bottom).offset(10)
            make.left.equalTo(self.myImageView.snp.left).offset(10)
            make.right.equalToSuperview().offset(-20)
        }

        myTextLabel.lineBreakMode = .byWordWrapping
        myTextLabel.numberOfLines = 0
        //        myTextLabel.sizeToFit()
        
        myDetailTextLabel.lineBreakMode = .byWordWrapping
        myDetailTextLabel.numberOfLines = 0
        //        myDetailTextLabel.sizeToFit()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

