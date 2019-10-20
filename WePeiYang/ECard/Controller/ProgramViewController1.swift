//
//  ProgramViewController1.swift
//  WePeiYang
//
//  Created by 安宇 on 08/07/2019.
//  Copyright © 2019 twtstudio. All rights reserved.
//

import UIKit

class ProgramViewController1: UIViewController {
    private let programLabel = UILabel()
    private let WPYLabel = UILabel()
    private let firstLabel = UILabel()
    private let proLabel = UILabel()
    private let detailLabel = UILabel()
    private let servicePoint = UILabel()
    private var signs = [UILabel]()
    private var imageView = [UIImageView]()
    private var image = [UIImage]()
    //改变三张图片大小
    let image0 = UIImage.resizedImage(image: UIImage(named: "注意")!, scaledToSize: CGSize(width: 20, height: 20))
    let image1 = UIImage.resizedImage(image: UIImage(named: "地点")!, scaledToSize: CGSize(width: 20, height: 20))
    let image2 = UIImage.resizedImage(image: UIImage(named: "校园卡")!, scaledToSize: CGSize(width: 20, height: 20))
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        //左上角button格式
        let leftButton = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(pop))
        leftButton.image = UIImage.resizedImage(image: UIImage(named:"返回-1")!, scaledToSize: CGSize(width: 20, height: 20))
        navigationItem.leftBarButtonItem = leftButton
        
        //这个就没放进去，因为这写Label的位置在后面两个方法中要用
        view.addSubview(programLabel)
        programLabel.text = "补办校园卡流程说明"
        programLabel.textColor = UIColor(hex6: 0x222222)
        programLabel.textAlignment = NSTextAlignment.center
        programLabel.snp.makeConstraints { (make) in
            make.top.equalTo(220 * UIScreen.main.bounds.height / 1920)
            make.centerY.equalTo(self.programLabel.snp.top).offset(7)
            make.left.equalTo(UIScreen.main.bounds.width / 2 - 90)
            make.centerX.equalTo(UIScreen.main.bounds.width / 2)
        }
        
        //MARK:字体大小要改
        
        view.addSubview(firstLabel)
        firstLabel.text = "首先应尽快挂失"
        firstLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.programLabel.snp.bottom).offset(7)
            make.bottom.equalTo(self.programLabel.snp.bottom).offset(30)
            make.left.equalTo(30)
            make.right.equalTo(UIScreen.main.bounds.width / 2)
        }
        firstLabel.textColor =  UIColor(hex6: 0x222222)
        //MARK:字体大小要改
        view.addSubview(proLabel)
        proLabel.text = "操作：在校园卡自助终端总界面右侧点击“挂失”，输入学号、卡密码即可挂失"
        proLabel.textColor =  UIColor(hex6: 0x222222)
        proLabel.sizeToFit()
        proLabel.numberOfLines = 0
        proLabel.lineBreakMode = .byWordWrapping
        proLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.firstLabel.snp.bottom).offset(8)
            make.centerX.equalTo(UIScreen.main.bounds.width / 2)
            make.left.equalTo(20)
            make.centerY.equalTo(self.proLabel.snp.top).offset(27)
        }
        
        detailLabel.text = "如果挂失后没有补办前找到了卡， 可以在校园卡自助终端上进行卡解挂。(操作:持卡在校园卡自助终端主界面点击“校园卡务”， 登陆后在左侧菜单点击“卡解挂”。)\r\n如果确定找不回来了，需要携带有效证件(工作证、学生证或身份证)和补卡 费15元现金到卡中心补办。补办新卡后原卡立即失效，即便找回亦不能使用。"
        detailLabel.textColor =  UIColor(hex6: 0x888888)
        detailLabel.lineBreakMode = .byWordWrapping
        detailLabel.sizeToFit()
        detailLabel.numberOfLines = 0
        //为嘛不行呢        NSMutableParagraphStyle().lineSpacing = 20
        
        view.addSubview(detailLabel)
        detailLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.proLabel.snp.left)
            make.right.equalTo(self.proLabel.snp.right)
            make.top.equalTo(self.proLabel.snp.bottom)
            make.bottom.equalTo(self.detailLabel.snp.top).offset(180)
        }
        
        view.addSubview(servicePoint)
        servicePoint.text = "服务网点"
        servicePoint.textColor =  UIColor(hex6: 0x222222)
        servicePoint.snp.makeConstraints { (make) in
            make.top.equalTo(self.detailLabel.snp.bottom)
            make.bottom.equalTo(self.servicePoint.snp.top).offset(30)
            make.left.equalTo(self.firstLabel.snp.left)
            make.right.equalTo(self.firstLabel.snp.right)
        }
        addImage()
        addLabel()
        
    }
    @objc func pop() {
        navigationController?.popViewController(animated: true)
    }
    func addImage() {
        //按顺序分别是从上到下三张图片(起名就很随意)
        for _ in 0..<3 {
            image.append(UIImage())
        }
        image[0] = image0
        image[1] = image1
        image[2] = image2
        for i in 0..<3 {
            imageView.append(UIImageView())
            imageView[i].image = image[i]
            view.addSubview(imageView[i])
        }
        imageView[0].snp.makeConstraints { (make) in
            make.top.equalTo(self.firstLabel.snp.top)
            make.right.equalTo(self.firstLabel.snp.left)
            make.left.equalTo(10)
            make.bottom.equalTo(self.firstLabel.snp.bottom)
        }
    
        imageView[1].snp.makeConstraints { (make) in
            make.top.equalTo(self.servicePoint.snp.top)
            make.bottom.equalTo(self.servicePoint.snp.bottom)
            make.left.equalTo(self.imageView[0].snp.left)
            make.right.equalTo(self.servicePoint.snp.left)
        }
        
        imageView[2].snp.makeConstraints { (make) in
            make.left.equalTo(self.imageView[1].snp.left)
            make.right.equalTo(self.imageView[1].snp.right)
            make.top.equalTo(self.servicePoint.snp.bottom).offset(8)
            make.bottom.equalTo(self.imageView[2].snp.top).offset(30)
        }
    }
    
    func addLabel() {

        for i in 0..<13 {
            signs.append(UILabel())
            signs[i].textAlignment = NSTextAlignment.center
            signs[i].sizeToFit()
            if i < 11 {
                signs[i].textColor =  UIColor(hex6: 0x444444)
            }
            if i < 4 {
                signs[i].backgroundColor = UIColor(hex6: 0xffeb86)
            }
            if i > 10 {
                signs[i].textColor = UIColor(hex6: 0xa94b4b)
            }
            view.addSubview(signs[i])
        }
        signs[0].text = "北洋园校区卡中心"
        signs[0].snp.makeConstraints { (make) in
            make.left.equalTo(self.imageView[2].snp.right)
            make.right.equalTo( -UIScreen.main.bounds.width / 2)
            make.top.equalTo(self.imageView[2].snp.top)
            make.bottom.equalTo(self.imageView[2].snp.bottom)
        }
        
        signs[1].text = "卫津路校区卡中心"
        signs[1].snp.makeConstraints { (make) in
            make.left.equalTo(self.signs[0].snp.right).offset(2)
            make.right.equalTo(self.detailLabel.snp.right)
            make.top.equalTo(self.signs[0].snp.top)
            make.bottom.equalTo(self.signs[0].snp.bottom)
        }
        
        signs[2].text = "地点"
        signs[2].numberOfLines = 2
        signs[2].snp.makeConstraints { (make) in
            make.left.equalTo(self.imageView[0].snp.left)
            make.right.equalTo(self.imageView[2].snp.right)
            make.top.equalTo(self.imageView[2].snp.bottom)
            make.bottom.equalTo(-360)
        }
        
        signs[3].text = "对外服务时间"
        signs[3].numberOfLines = 6
        signs[3].snp.makeConstraints { (make) in
            make.top.equalTo(self.signs[2].snp.bottom).offset(2)
            make.bottom.equalTo(-150)
            make.left.equalTo(self.signs[2].snp.left)
            make.right.equalTo(self.signs[2].snp.right)
        }
        
        signs[4].text = "1895行政服务中心\r\n综合服务大厅\r\n1-4号服务窗口"
        signs[4].numberOfLines = 3

        signs[4].snp.makeConstraints { (make) in
            make.left.equalTo(self.signs[0].snp.left)
            make.right.equalTo(self.signs[0].snp.right)
            make.bottom.equalTo(self.signs[2].snp.bottom)
            make.top.equalTo(self.signs[2].snp.top)
        }
        
        signs[5].text = "会议室综合服务大厅\r\n11号窗口"
        signs[5].numberOfLines = 2

        signs[5].snp.makeConstraints { (make) in
            make.top.equalTo(self.signs[2].snp.top)
            make.bottom.equalTo(self.signs[2].snp.bottom)
            make.left.equalTo(self.signs[1].snp.left)
            make.right.equalTo(self.signs[1].snp.right)
        }
        
        signs[6].text = "周一至周四"
        signs[6].numberOfLines = 2
        signs[6].snp.makeConstraints { (make) in
            make.top.equalTo(self.signs[3].snp.top)
            make.height.equalTo(self.signs[3].snp.height).multipliedBy(0.3)
            make.left.equalTo(self.signs[3].snp.right)
            make.width.equalTo(self.signs[0].snp.width).multipliedBy(0.3)
        }
        
        signs[7].text = "8:30--12:00，13:00--16:00"
        signs[7].snp.makeConstraints { (make) in
            make.top.equalTo(self.signs[6].snp.top)
            make.bottom.equalTo(self.signs[6].snp.bottom)
            make.left.equalTo(self.signs[6].snp.right)
            make.right.equalTo(self.signs[1].snp.right)
        }
        
        signs[8].text = "周五"
        signs[8].textColor = UIColor(hex6: 0x444444)
        signs[8].textAlignment = NSTextAlignment.center
        signs[8].snp.makeConstraints { (make) in
            make.top.equalTo(self.signs[6].snp.bottom)
            make.left.equalTo(self.signs[6].snp.left)
            make.width.equalTo(self.signs[6].snp.width)
            make.height.equalTo(self.signs[6].snp.height)
        }
        
        signs[9].text = "8:30--12:00\r\n13:00--14:00"
        signs[9].numberOfLines = 2
        signs[9].snp.makeConstraints { (make) in
            make.left.equalTo(self.signs[8].snp.right)
            make.right.equalTo(self.signs[0].snp.right)
            make.top.equalTo(self.signs[8].snp.top)
            make.bottom.equalTo(self.signs[8].snp.bottom)
        }
    
        signs[10].text = "8:30--12:00"
        signs[10].snp.makeConstraints { (make) in
            make.left.equalTo(self.signs[1].snp.left)
            make.right.equalTo(self.signs[1].snp.right)
            make.top.equalTo(self.signs[8].snp.top)
            make.bottom.equalTo(self.signs[8].snp.bottom)
        }
        
        signs[11].text = "其中办卡、补卡、\r\n充值等涉及现金\r\n的业务截止16:00"
        signs[11].numberOfLines = 3
        signs[11].snp.makeConstraints { (make) in
            make.top.equalTo(self.signs[8].snp.bottom)
            make.bottom.equalTo(self.signs[3].snp.bottom)
            make.left.equalTo(self.signs[8].snp.left)
            make.right.equalTo(self.signs[0].snp.right)
        }
        
        signs[12].text = "其中办卡、补卡、\r\n充值等涉及现金\r\n的业务截止11:30"
        signs[12].numberOfLines = 3
        signs[12].snp.makeConstraints { (make) in
            make.left.equalTo(self.signs[1].snp.left)
            make.right.equalTo(self.signs[1].snp.right)
            make.top.equalTo(self.signs[8].snp.bottom)
            make.bottom.equalTo(self.signs[3].snp.bottom)
        }
        
        view.addSubview(WPYLabel)
        WPYLabel.text = "微北洋 - 校园卡"
        WPYLabel.textColor =  UIColor(hex6: 0xb9b9b9)
        WPYLabel.textAlignment = NSTextAlignment.center
        WPYLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.signs[3].snp.bottom).offset(40)
            make.bottom.equalTo(self.WPYLabel.snp.top).offset(7)
            make.centerX.equalTo(UIScreen.main.bounds.width / 2)
        }
    }
}

