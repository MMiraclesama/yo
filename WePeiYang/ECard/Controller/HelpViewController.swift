//
//  HelpViewController.swift
//  WePeiYang
//
//  Created by 安宇 on 06/04/2019.
//  Copyright © 2019 twtstudio. All rights reserved.
//

import UIKit

class HelpViewController: UIViewController {
    var question = ["校园卡的照片可以更换吗?","有什么方法能查询圈存已扣钱但校园卡没到账的情况？","银行圈存时，银行卡扣钱但是一卡通未到账怎么办?","绑定银行卡提示用户已签约怎么处理?","怎么更换校园卡绑定的交通银行卡？","补卡后门禁刷不进去怎么办？","补办新卡后原来卡上的钱怎么办？","校园卡遗失或损坏了怎么办？","网上查询系统的登录名和密码是什么？"]
    var answer = ["校园卡上的照片可以换更换，但需要同时满足以下条件:\r\n1.更换的照片必须为近期的电子证件照，需要忠于本人目前的面貌，不能进行过度修饰。\r\n2.补办卡时换照片的，需要在打印卡片之前提出换照片的要求。\r\n3.如在用的卡片需要换照片，按照补办卡处理，需要缴纳卡成本费。\r\n4.电子照片要求大小不超过100KB，纵横比4:3，以蓝色背景为佳。","这种情况需要分析校园卡余额来判定。\r\n在校园卡自助终端主界面右上角点击“卡余额”，记下查询到的金额。  在没有新增充值和消费的情况下，登陆本网站，查看“用户信息”下的“卡余额”。\r\n 比较两个余额是否一致，如果长时间（超过一个月）不一致并且两者金额相差较大，请持卡到卡中心处理。卡中心会在详细分析原因后进行相应的处理。\r\n注：上述两个余额不一致的成因很多，圈存写卡失败是一个方面，还包括消费流水延迟等多方面，需要卡中心分析后才能处理。","这种情况多是由于在圈存转账的过程中操作过快，中途拔卡或有进行其他操作导致的。出现此类问题，请本人持卡到卡中心处理（同样适用于支付宝领取）。\r\n注：严格按照本网站“操作指南”栏目中“银行卡转账充值操作指南”的程序操作，是避免出现此类问题的有效途径。","如果绑定银行卡时提示“用户已签约”，但是圈存时提示“未绑定银行卡”或总是返回“交易失败”，请持卡到卡中心处理。","第一步：需要解除原来的银行卡绑定。在校园卡自助终端主界面点击“银行卡务”，登录后点击左侧菜单“绑定/解绑”。如果页面显示银行卡号信息，说明已绑定了该银行，点击“解绑”即可。\r\n第二步：绑定新的交通银行卡。同第一步“绑定/解绑”菜单，输入银行卡号，点击“绑定”即可。\r\n注：绑定的交通银行卡开户名和本人身份证件信息必须一致。","补办新卡后，一卡通会将原卡上的门禁权限自动同步给门禁服务器。由于各个品牌的门禁下发权限的时间不一样，所以正常情况下，有的门禁需要等到第二天才能通行，有的门禁约半小时后就可通行。\r\n如补卡后门禁功能长时间无法正常使用（约3天后），进出图书馆闸机的权限可到卡中心处理，宿舍门禁到宿管中心处理，各学院或实验室门禁找各专门负责的老师处理。","补办新卡后，原来卡上的余额自卡挂失之日起3日后可转移到新卡上。  转移方法：在校园卡服务终端主界面点击“校园卡务”，登录后在左侧菜单点击“余额转移”，按提示操作。\r\n注：原卡小钱包的余额会在转移时退回到主钱包，需要使用小钱包功能的，请重新向小钱包转账。","首先应尽快挂失。（操作：在校园卡自助终端主界面右侧点击“挂失”，输入学号、卡密码即可挂失。)\r\n如果确定找不回来了，需要携带有效证件和补卡费15元现金到卡中心补办。\r\n如果挂失后没有补办前找到了卡，可以在校园卡自助终端上进行卡解挂。（操作：持卡在校园卡自助终端主界面点击“校园卡务”，登陆后在左侧菜单点击“卡解挂”。） "," 本系统的登录名和密码与自助服务终端上操作时使用的登录名和密码是一致的。登录名为学号或工资号，临时卡一般为身份证号；登录密码为校园卡密码，初始密码为身份证号第12位-第17位（即后7位去掉最后一位）。"]
//    var DynamicInformation: DynamicInformation!
    let QATableView = UITableView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height), style: .grouped)
    let WPYLabel = UILabel()
    var QAInformation: QAInformation!
    override func viewDidLoad() {
        super.viewDidLoad()

        WPYLabel.frame = CGRect(x: UIScreen.main.bounds.width / 2 - 100, y: 10, width: 200, height: 20)
        WPYLabel.text = "微北洋 - 校园卡"
        WPYLabel.font = UIFont.flexibleSystemFont(ofSize: 13)
        WPYLabel.textAlignment = NSTextAlignment.center
//        WPYLabel.textColor = MyColor.ColorHex("#b9b9b9")
//        WPYLabel.backgroundColor = .blue
        QATableView.delegate = self
        QATableView.dataSource = self
        navigationItem.title = "校园卡"
        UINavigationBar.appearance().backgroundColor = UIColor.blue
     navigationController?.setNavigationBarHidden(false, animated: true)
        view.addSubview(WPYLabel)
        view.addSubview(QATableView)
        
    }
}


extension HelpViewController: UITableViewDelegate {
    
}
extension HelpViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 9
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = DetailInformationElementCell()
        if indexPath.row == 3 {
            cell.qLabel.frame = CGRect(x: 40, y: 35, width: UIScreen.main.bounds.width - 80, height: 100)
            cell.qLabel.reloadInputViews()
        }
        if indexPath.row == 8 {
            cell.qLabel.frame = CGRect(x: 40, y: 25, width: UIScreen.main.bounds.width - 80, height: 200)
            cell.qLabel.reloadInputViews()
        }
        if indexPath.row == 1 {
            cell.qLabel.frame = CGRect(x: 40, y: 55, width: UIScreen.main.bounds.width - 80, height: 200)
        }
        cell.aLabel.text = question[indexPath.row]
        cell.aLabel.font = UIFont.flexibleSystemFont(ofSize: 17)
//        cell.aLabel.textColor = MyColor.ColorHex("#222222")
        cell.qLabel.text = answer[indexPath.row]
//        cell.qLabel.textColor = MyColor.ColorHex("#888888")
        cell.qImage.frame = CGRect(x: cell.qLabel.frame.minX, y: cell.aLabel.frame.minY + 5, width: cell.aLabel.frame.minX -  cell.qLabel.frame.minX, height: cell.aLabel.frame.minX -  cell.qLabel.frame.minX)
        cell.qImage.reloadInputViews()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 280
        case 1:
            return 270
        case 2:
            return 220
        case 3:
            return 160
        case 4:
            return 280
        case 5:
            return 280
        case 6:
            return 260
        case 7:
            return 280
        default:
            return 260
        }
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UILabel()
        view.backgroundColor = .white
        view.text = "补办校园卡常见问题"
        view.font = UIFont.flexibleSystemFont(ofSize: 19)
//                noticeLabel.textColor = MyColor.ColorHex("#222222")
        view.textAlignment = .center
        return view
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        view.addSubview(WPYLabel)
        return view
    }
    
    
}
