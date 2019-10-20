//
//  ProgramViewController.swift
//  WePeiYang
//
//  Created by 安宇 on 06/04/2019.
//  Copyright © 2019 twtstudio. All rights reserved.
//

import UIKit

struct ScaleScreen {
    static let scaleWidth = UIScreen.main.bounds.width / 1080
    static let scaleHeight = UIScreen.main.bounds.height / 1920
}
class ProgramViewController: UIViewController {
    let programLabel = UILabel(frame: CGRect(x: UIScreen.main.bounds.width / 2 - 90, y: 255 * UIScreen.main.bounds.height / 1920, width: 180, height: 50 * UIScreen.main.bounds.height / 1920))
    let WPYLabel = UILabel()
    let firstLabel = UILabel()
    let proLabel = UILabel()
    let detailLabel = UILabel()
    let servicePoint = UILabel()
    let signs0 = UILabel()
    let signs1 = UILabel()
    let signs2 = UILabel()
    let signs3 = UILabel()
    let signs4 = UILabel()
    let signs5 = UILabel()
    let signs6 = UILabel()
    let signs7 = UILabel()
    let signs8 = UILabel()
    let signs9 = UILabel()
    let signs10 = UILabel()
    let signs11 = UILabel()
    let signs12 = UILabel()
    let image0 = UIImage.resizedImage(image: UIImage(named: "注意")!, scaledToSize: CGSize(width: 20, height: 20))
    let imageView0 = UIImageView()
    let image1 = UIImage.resizedImage(image: UIImage(named: "地点")!, scaledToSize: CGSize(width: 20, height: 20))
    let imageView1 = UIImageView()
    let image2 = UIImage.resizedImage(image: UIImage(named: "校园卡")!, scaledToSize: CGSize(width: 20, height: 20))
    let imageView2 = UIImageView()
    override func viewDidLoad() {
        super.viewDidLoad()
        let leftButton = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(pop))
        leftButton.image = UIImage.resizedImage(image: UIImage(named:"返回-1")!, scaledToSize: CGSize(width: 20, height: 20))
        navigationItem.leftBarButtonItem = leftButton
        firstLabel.frame = CGRect(x: 122 * UIScreen.main.bounds.width / 1080 + 10, y: programLabel.frame.maxY + 30 * UIScreen.main.bounds.height / 1920, width: 180, height: 40 * UIScreen.main.bounds.height / 1920)
        imageView0.image = image0
        proLabel.frame = CGRect(x: 83 * UIScreen.main.bounds.width / 1080, y: firstLabel.frame.maxY + 20 * UIScreen.main.bounds.height / 1920, width: UIScreen.main.bounds.width - 166 * UIScreen.main.bounds.width / 1080, height: 100 * UIScreen.main.bounds.height / 1920)
        imageView0.frame = CGRect(x: proLabel.frame.minX, y: firstLabel.frame.minY, width: image0.size.width, height: image0.size.height)
        detailLabel.frame = CGRect(x: proLabel.frame.minX, y: proLabel.frame.maxY + 10 * UIScreen.main.bounds.height / 1920, width: proLabel.frame.width, height: 3.5 * proLabel.frame.height)
        servicePoint.frame = CGRect(x: firstLabel.frame.minX, y: detailLabel.frame.maxY + 10 * UIScreen.main.bounds.height / 1920, width: programLabel.frame.minX, height: programLabel.frame.height)
        imageView1.image = image1
        imageView1.frame = CGRect(x: proLabel.frame.minX, y: servicePoint.frame.minY, width: image1.size.width, height: image1.size.height)
        signs0.frame = CGRect(x: 140 * UIScreen.main.bounds.width / 1080, y: servicePoint.frame.maxY + 10 * UIScreen.main.bounds.height / 1920, width: UIScreen.main.bounds.width / 2 - 140 * UIScreen.main.bounds.width / 1080, height: 59 * UIScreen.main.bounds.height / 1920)
        signs1.frame = CGRect(x: signs0.frame.maxX + CGFloat(UIScreen.main.bounds.width / 108), y: servicePoint.frame.maxY + 10 * UIScreen.main.bounds.height / 1920, width: UIScreen.main.bounds.width / 2 - 140 * UIScreen.main.bounds.width / 1080, height: 59 * UIScreen.main.bounds.height / 1920)
        signs2.frame = CGRect(x: proLabel.frame.minX, y: signs0.frame.maxY, width: 55 * UIScreen.main.bounds.width / 1080, height: 150 * UIScreen.main.bounds.height / 1920)
        signs3.frame = CGRect(x: signs2.frame.minX, y: signs2.frame.maxY, width: 55 * UIScreen.main.bounds.width / 1080, height: 450 * UIScreen.main.bounds.height / 1920)
        imageView2.image = image2
        imageView2.frame = CGRect(x: signs3.frame.minX, y: signs0.frame.minY, width: signs3.width, height: signs0.height)
        signs4.frame = CGRect(x: signs2.frame.maxX, y: signs2.frame.minY + 5 * UIScreen.main.bounds.height / 1920, width: signs0.frame.width, height: signs2.frame.height)
        signs5.frame = CGRect(x: signs4.frame.maxX + CGFloat(UIScreen.main.bounds.width / 108), y: signs1.frame.maxY + 8 * UIScreen.main.bounds.height / 1920, width: signs1.frame.width + 100 * UIScreen.main.bounds.width / 1080, height: signs2.frame.height)
        signs6.frame = CGRect(x: signs4.frame.minX, y: signs5.frame.maxY + 5 * UIScreen.main.bounds.height / 1920, width: 145 * UIScreen.main.bounds.width / 1080, height: 97 * UIScreen.main.bounds.height / 1920)
        signs7.frame = CGRect(x: signs6.frame.maxX, y: signs6.frame.minY, width: signs1.frame.maxX - signs6.frame.maxX, height: signs6.frame.height)
        signs8.frame = CGRect(x: signs4.frame.minX, y: signs7.frame.maxY, width: signs6.frame.width, height: 160 * UIScreen.main.bounds.height / 1920)
        signs9.frame = CGRect(x: signs8.frame.maxX, y: signs8.frame.minY, width: 20 * UIScreen.main.bounds.width / 1080 +  signs4.frame.maxX - signs8.frame.maxX, height: 160 * UIScreen.main.bounds.height / 1920)
        signs10.frame = CGRect(x: signs5.frame.minX + CGFloat(UIScreen.main.bounds.width / 108), y: signs8.frame.minY, width: 410 * UIScreen.main.bounds.width / 1080, height: signs9.frame.height)
        signs11.frame = CGRect(x: signs3.frame.maxX, y: signs8.frame.maxY, width: signs4.frame.width, height: signs3.frame.maxY - signs8.frame.maxY)
        signs12.frame = CGRect(x: signs4.frame.maxX + CGFloat(UIScreen.main.bounds.width / 108), y: signs8.frame.maxY, width: signs5.frame.maxX - signs9.frame.maxX, height: signs3.frame.maxY - signs8.frame.maxY)
        WPYLabel.frame = CGRect(x: UIScreen.main.bounds.width / 2 - 90, y: signs12.frame.maxY + 110 * UIScreen.main.bounds.width / 1080, width: 180, height: 20)
        programLabel.text = "补办校园卡流程说明"
        programLabel.textColor = UIColor(hex6: 0x222222)
        programLabel.textAlignment = NSTextAlignment.center
        view.backgroundColor = .white
        WPYLabel.text = "微北洋 - 校园卡"
        WPYLabel.textColor =  UIColor(hex6: 0xb9b9b9)
        WPYLabel.textAlignment = NSTextAlignment.center
//        WPYLabel.textColor = .white
        firstLabel.text = "首先应尽快挂失"
        firstLabel.textColor =  UIColor(hex6: 0x222222)
        proLabel.text = "操作：在校园卡自助终端总界面右侧点击“挂失”，输入学号、卡密码即可挂失"
        proLabel.textColor =  UIColor(hex6: 0x222222)
        detailLabel.text = "如果挂失后没有补办前找到了卡， 可以在校园卡自助终端上进行卡解挂。(操作:持卡在校园卡自助终端主界面点击“校园卡务”， 登陆后在左侧菜单点击“卡解挂”。)\r\n如果确定找不回来了，需要携带有效证件(工作证、学生证或身份证)和补卡 费15元现金到卡中心补办。补办新卡后原卡立即失效，即便找回亦不能使用。"
        detailLabel.textColor =  UIColor(hex6: 0x888888)
        servicePoint.text = "服务网点"
        servicePoint.textColor =  UIColor(hex6: 0x222222)
        detailLabel.lineBreakMode = .byWordWrapping
        detailLabel.numberOfLines = 0
        proLabel.lineBreakMode = .byWordWrapping
        proLabel.numberOfLines = 0
        signs0.text = "北洋园校区卡中心"
        signs0.textAlignment = NSTextAlignment.center
        signs1.text = "卫津路校区卡中心"
        signs1.textAlignment = NSTextAlignment.center
        signs2.text = "地点"
        signs2.numberOfLines = 2
        signs3.text = "对外服务时间"
        signs3.numberOfLines = 6
        signs4.text = "1895行政服务中心\r\n综合服务大厅\r\n1-4号服务窗口"
        signs4.numberOfLines = 3
        signs4.textAlignment = NSTextAlignment.center
        signs5.text = "会议室综合服务大厅\r\n11号窗口"
        signs5.numberOfLines = 2
        signs5.sizeToFit()
        signs5.textAlignment = NSTextAlignment.center
        signs6.text = "周一至\r\n周四"
        signs6.numberOfLines = 2
        signs6.textAlignment = NSTextAlignment.center
//        signs2.textAlignment = NSTextAlignment.
        signs7.text = "8:30--12:00，13:00--16:00"
        signs7.textAlignment = NSTextAlignment.center
        signs8.text = "周五"
        signs8.textAlignment = NSTextAlignment.center
        signs9.text = "8:30--12:00\r\n13:00--14:00"
        signs9.numberOfLines = 2
        signs9.textAlignment = NSTextAlignment.center
        signs10.text = "8:30--12:00"
        signs10.textAlignment = NSTextAlignment.center
        signs11.text = "其中办卡、补卡、充值等涉及现金的业务截止16:00"
        signs11.numberOfLines = 3
        signs11.textAlignment = NSTextAlignment.center
        signs12.text = "其中办卡、补卡、\r\n充值等涉及现金\r\n的业务截止11:30"
        signs12.numberOfLines = 3
        signs12.textAlignment = NSTextAlignment.center
        
        signs0.textColor =  UIColor(hex6: 0x444444)
        signs1.textColor = UIColor(hex6: 0x444444)
        signs2.textColor = UIColor(hex6: 0x444444)
        signs3.textColor = UIColor(hex6: 0x444444)
        signs4.textColor = UIColor(hex6: 0x444444)
        signs5.textColor = UIColor(hex6: 0x444444)
        signs6.textColor = UIColor(hex6: 0x444444)
        signs7.textColor = UIColor(hex6: 0x444444)
        signs8.textColor = UIColor(hex6: 0x444444)
        signs9.textColor = UIColor(hex6: 0x444444)
        signs10.textColor = UIColor(hex6: 0x444444)
        signs11.textColor = UIColor(hex6: 0xa94b4b)
        signs12.textColor = UIColor(hex6: 0xa94b4b)
        
        signs0.backgroundColor = UIColor(hex6: 0xffeb86)
        signs1.backgroundColor = UIColor(hex6: 0xffeb86)
        signs2.backgroundColor = UIColor(hex6: 0xffeb86)
        signs3.backgroundColor = UIColor(hex6: 0xffeb86)

        
        view.addSubview(signs0)
        view.addSubview(signs1)
        view.addSubview(signs2)
        view.addSubview(signs3)
        view.addSubview(signs4)
        view.addSubview(signs5)
        view.addSubview(signs6)
        view.addSubview(signs7)
        view.addSubview(signs8)
        view.addSubview(signs9)
        view.addSubview(signs10)
        view.addSubview(signs11)
        view.addSubview(signs12)
        view.addSubview(servicePoint)
        view.addSubview(detailLabel)
        view.addSubview(proLabel)
        view.addSubview(firstLabel)
        view.addSubview(programLabel)
        view.addSubview(WPYLabel)
        view.addSubview(imageView0)
        view.addSubview(imageView1)
        view.addSubview(imageView2)


    }
    @objc func pop() {
        navigationController?.popViewController(animated: true)
    }
}
