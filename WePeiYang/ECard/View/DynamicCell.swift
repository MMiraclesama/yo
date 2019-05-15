//
//  DynamicCell.swift
//  WePeiYang
//
//  Created by 安宇 on 06/04/2019.
//  Copyright © 2019 twtstudio. All rights reserved.
//

import UIKit

class DynamicCell: UITableViewCell {
    let aLabel = UILabel()
    let qLabel = UILabel()
    let qImage = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    convenience init() {
        self.init(style: .default, reuseIdentifier: "DynamicCell")
        aLabel.frame = CGRect(x: 45, y: 10, width: 100, height: 20)
        qLabel.frame = CGRect(x: 40, y: 35, width: UIScreen.main.bounds.width - 10, height: 80)
        qImage.frame = CGRect(x: 40, y: 10, width: 5, height: 20)
        contentView.addSubview(aLabel)
        contentView.addSubview(qLabel)
        contentView.addSubview(qImage)
    }
    
    convenience init(byModel DynamicInformation: DynamicInformation, withIndex index: Int) {
        self.init(style: .default, reuseIdentifier: "DynamicCell")
        aLabel.frame = CGRect(x: 45, y: 10, width: 100, height: 20)
        qLabel.frame = CGRect(x: 40, y: 35, width: UIScreen.main.bounds.width - 10, height: 80)
        qImage.frame = CGRect(x: 40, y: 10, width: 5, height: 20)
        aLabel.text = DynamicInformation.data[index].content
        qLabel.text = DynamicInformation.data[index].title
        qImage.image = UIImage(named: "?")
        contentView.addSubview(aLabel)
        contentView.addSubview(qLabel)
        contentView.addSubview(qImage)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
