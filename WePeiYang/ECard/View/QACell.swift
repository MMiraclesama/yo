//
//  QACell.swift
//  WePeiYang
//
//  Created by 安宇 on 06/04/2019.
//  Copyright © 2019 twtstudio. All rights reserved.
//

import UIKit
class DetailInformationElementCell: UITableViewCell {
    let myTextLabel = UILabel()
    let myDetailTextLabel = UILabel()
    let myImageView = UIImageView()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    convenience init() {
        self.init(style: .default, reuseIdentifier: "QATableViewCell")
        
        
        myTextLabel.frame = CGRect(x: 122 * UIScreen.main.bounds.width / 1080, y: 25 * UIScreen.main.bounds.height / 1920, width: UIScreen.main.bounds.width - 244 * UIScreen.main.bounds.width / 1080, height: 37 * UIScreen.main.bounds.height / 1920)
        myDetailTextLabel.frame = CGRect(x: 85 * UIScreen.main.bounds.width / 1080, y: 55 * UIScreen.main.bounds.height / 1920, width: UIScreen.main.bounds.width - 244 * UIScreen.main.bounds.width / 1080, height: 250)
        myImageView.frame = CGRect(x: 78 * UIScreen.main.bounds.width / 1080, y: 25 * UIScreen.main.bounds.height / 1920, width: 37 * UIScreen.main.bounds.height / 1920, height: 37 * UIScreen.main.bounds.height / 1920)
        myTextLabel.lineBreakMode = .byWordWrapping
        myTextLabel.numberOfLines = 0
        //        myTextLabel.sizeToFit()
        
        myDetailTextLabel.lineBreakMode = .byWordWrapping
        myDetailTextLabel.numberOfLines = 0
        //        myDetailTextLabel.sizeToFit()
        contentView.addSubview(myTextLabel)
        contentView.addSubview(myDetailTextLabel)
        contentView.addSubview(myImageView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

