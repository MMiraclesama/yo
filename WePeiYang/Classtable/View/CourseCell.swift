//
//  CourseCell.swift
//  WePeiYang
//
//  Created by Halcao on 2017/11/24.
//  Copyright © 2017年 twtstudio. All rights reserved.
//

import UIKit

class CourseCell: UITableViewCell {
    var titleLabel = UILabel()
    var roomLabel = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(roomLabel)
        titleLabel.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.medium)
        titleLabel.numberOfLines = 0
        titleLabel.textColor = .white
        titleLabel.sizeToFit()
        
        roomLabel.font = UIFont.systemFont(ofSize: 12)
        roomLabel.numberOfLines = 0
        roomLabel.textColor = .white
        roomLabel.sizeToFit()

        contentView.layer.cornerRadius = 4
        contentView.layer.masksToBounds = true

        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(3)
            make.left.equalToSuperview().offset(3)
            make.right.equalToSuperview().offset(-3)
        }
        
        roomLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.bottom.lessThanOrEqualTo(contentView.snp.bottom)
//            make.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(3)
            make.right.equalToSuperview().offset(-3)
        }
        
        contentView.snp.makeConstraints { make in
            make.top.left.equalToSuperview().offset(1)
            make.bottom.right.equalToSuperview().offset(-1)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setIdle() {
        contentView.backgroundColor = UIColor(red:0.91, green:0.93, blue:0.96, alpha:1.00)
        titleLabel.textColor = .lightGray
        titleLabel.text = "无"
        titleLabel.sizeToFit()
        roomLabel.text = ""
        titleLabel.snp.remakeConstraints { make in
            make.centerX.equalTo(contentView.snp.centerX)
            make.centerY.equalTo(contentView.snp.centerY)
        }
        contentView.setNeedsUpdateConstraints()
        contentView.layoutIfNeeded()
    }

    // TODO: 必要性
    func dismissIdle() {
        // 还原
        titleLabel.textColor = .white
        titleLabel.snp.remakeConstraints { make in
            make.top.equalToSuperview().offset(3)
            make.left.equalToSuperview().offset(3)
            make.right.equalToSuperview().offset(-3)
        }
        contentView.setNeedsUpdateConstraints()
        contentView.layoutIfNeeded()
    }

    func load(course: ClassModel) {
        if course.classID == "" {
            self.alpha = 0
        } else {
            self.alpha = 1
            let colors = Metadata.Color.fluentColors

            let index = Int(arc4random()) % colors.count
            contentView.backgroundColor = colors[index]
            contentView.alpha = 0.7

            // FIXME: 体育课之类的课
            if course.arrange[0].room != "" {
                roomLabel.text = "@" + course.arrange[0].room
                roomLabel.sizeToFit()
            }

            var name = course.courseName
            // FIXME: 会不会不安全噢 看一下调用关系
            if course.courseName.count > 14 && course.arrange.first!.length <= 2 {
                // 好像已经够安全了噢
                name = (name as NSString).substring(to: 14) + "..."
            }
//            titleLabel.text = course.courseName
            titleLabel.text = name
            titleLabel.sizeToFit()
        }
    }
}
