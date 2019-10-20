//
//  FirstPageView.swift
//  WePeiYang
//
//  Created by 安宇 on 08/05/2019.
//  Copyright © 2019 twtstudio. All rights reserved.
//
import UIKit
var cnt = 4
var sum0 = 0.0
var num1 = 0.0
var num2 = 0.0
var num3 = 0.0
var num4 = 0.0
var sum1 = 0.0
var sum2 = 0.0
var sum3 = 0.0
var sum4 = 0.0
var rate1 = 0.0
var rate2 = 0.0
var rate3 = 0.0
var footerViewHeight = 50
class NewFirstPageViewController: UIViewController {
    
    private var refreshButton: UIView? {
        let button = navigationItem.rightBarButtonItem?.value(forKey: "view") as? UIView
        button?.layer.anchorPoint = CGPoint(x: 0.54, y: 0.54)
        return button
    }
    
    private var isRefreshing: Bool = false
    
    private func startRotating() {
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAnimation.toValue = CGFloat.pi
        rotationAnimation.duration = 0.5
        rotationAnimation.isCumulative = true
        rotationAnimation.repeatCount = 1000
        refreshButton?.layer.add(rotationAnimation, forKey: "rotationAnimation")
    }
    
    private func stopRotating() {
        refreshButton?.layer.removeAllAnimations()
    }
    
    
    var ecardTableView = UITableView(frame: CGRect(x: 17, y: UINavigationController.accessibilityFrame().maxY, width: UIScreen.main.bounds.width - 35, height: UIScreen.main.bounds.height), style: .grouped)
    //    Mark:tableview高度要改
    var HelpButton1 = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 30))
    var HelpButton2 = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 30))
    var Consume: Consume!
    var ConsumeDetail: ConsumeDetail!
    var DetailInformation: DetailInformation!
    var moneyOfYours: MoneyTest = MoneyTest()
    
    let ecardCardView = ECardCardView()
    let ecardFirstHeaderView = ECardHomePageFirstHeaderView()
    let ecardFirstFooterView = ECardHomePageFirstFooterView()
    let ecardSecondHeaderView = ECardHomePageSecondHeaderView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let leftButton = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(pop))
        leftButton.image = UIImage.resizedImage(image: UIImage(named:"返回-1")!, scaledToSize: CGSize(width: 20, height: 20))
        navigationItem.leftBarButtonItem = leftButton
        
        ecardCardView.snp.makeConstraints { make in
            make.width.equalTo(view.width)
            make.height.equalTo(view.height / 5)
        }
        ecardTableView.tableHeaderView = ecardCardView
        ecardTableView.bounces = true
        ecardTableView.backgroundColor = .white
        ecardTableView.delegate = self
        ecardTableView.dataSource = self
        
        self.ecardFirstHeaderView.AddView()
        self.ecardSecondHeaderView.AddView()
        navigationItem.title = "校园卡"
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.barTintColor = UIColor(hex6: 0xffeb86)
        UINavigationBar.appearance().backgroundColor = UIColor.black
        navigationController?.setNavigationBarHidden(false, animated: true)
        let limage = UIImage.resizedImage(image: UIImage(named: "刷新")!, scaledToSize: CGSize(width: 25, height: 25))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: limage, style: .plain, target: self, action: #selector(refresh))
        loadData()
        
        
        //MARK: - look me
        ecardTableView.frame = view.bounds
        ecardTableView.showsVerticalScrollIndicator = false
        ecardTableView.allowsSelection = false
        ecardTableView.separatorStyle = UITableViewCell.SeparatorStyle.singleLine
        ecardTableView.separatorInset = UIEdgeInsets(top: 0, left: 40, bottom: 0, right: 40)
        
        ecardFirstHeaderView.moreMessageButton.addTarget(self, action: #selector(MoreMessage), for: .touchUpInside)
        ecardFirstFooterView.scanButton.addTarget(self, action: #selector(More), for: .touchUpInside)
        HelpButton1.addTarget(self, action: #selector(Announcement), for: .touchUpInside)
        HelpButton2.addTarget(self, action: #selector(Question), for: .touchUpInside)
        
        HelpButton1.setTitle("补办校园卡流程说明", for: .normal)
        HelpButton1.setTitleColor(UIColor(hex6: 0x5e8dc5), for: .normal)
        HelpButton2.setTitle("补办校园卡常见问题", for: .normal)
        HelpButton2.setTitleColor(UIColor(hex6: 0x5e8dc5), for: .normal)
        view.addSubview(ecardTableView)
        //        GetTotal()
    }
    
    func refreshData() {
        Figure.term = 0
        self.isRefreshing = true
        startRotating()
        GetConsumeHelper.GetConsume(success: { ConsumeDetail in
            self.isRefreshing = false
            self.stopRotating()
            
            SwiftMessages.hideLoading()
            self.ConsumeDetail = ConsumeDetail
            self.moneyOfYours.GetTotal()
           
            
            if(ConsumeDetail.data.count - 4 <= 0) {
                self.ecardFirstFooterView.scanButton.isHidden = true
                self.ecardFirstFooterView.foldMessage.isHidden = true
            }
            if(ConsumeDetail.data.count - 4 > 0) {
                self.ecardFirstFooterView.scanButton.addTarget(self, action: #selector(self.More), for: .touchUpInside)
            }
            self.ecardTableView.reloadData()
        }, failure: { _ in
            
        })
        GetDailyDetailHelper.GetThat(success: { Consume in
            self.Consume = Consume
            self.ecardCardView.todayCosume.text = "今日消费 ￥\(Consume.data.totalDay)"
            self.ecardCardView.monthConsume.text = "本月消费 ￥\(String(Consume.data.totalMonth).prefix(6))"
            self.ecardTableView.reloadData()
        }, failure: { _ in
            
        })
        
        GetSaveHelper.GetIt(success: { DetailInformation in
            self.DetailInformation = DetailInformation
            let balanceData = (self.DetailInformation.data.balance as NSString).substring(with: NSMakeRange(0, self.DetailInformation.data.balance.count - 1))
            if Double(balanceData)! < 20 {
                self.ecardCardView.notice.text = "余额快不够吃饭啦！"
            }
            
            self.ecardCardView.balance.text = "￥\(balanceData)"
            self.ecardCardView.cardId.text = self.DetailInformation.data.cardnum
            self.ecardCardView.userName.text = self.DetailInformation.data.name
            self.ecardCardView.AddView()
            
            self.ecardTableView.reloadData()
        }, failure: { _ in
            
        })
    }
    
    func loadData() {
        Figure.term = 0
        GetConsumeHelper.GetConsume(success: { ConsumeDetail in
            self.ConsumeDetail = ConsumeDetail
            Figure.term = 6
            self.moneyOfYours.GetTotal()

            self.ecardFirstFooterView.foldMessage.text = ConsumeDetail.data.count > 4 ? "\(ConsumeDetail.data.count - 4)条记录被折叠" : "0条记录被折叠"
            if(ConsumeDetail.data.count - 4 <= 0) {
                self.ecardFirstFooterView.scanButton.isHidden = true
                self.ecardFirstFooterView.foldMessage.isHidden = true
                footerViewHeight = 0
            }
            if(ConsumeDetail.data.count - 4 > 0) {
                self.ecardFirstFooterView.scanButton.addTarget(self, action: #selector(self.More), for: .touchUpInside)
            }
            self.ecardTableView.reloadData()
        }, failure: { _ in
            
        })
        GetDailyDetailHelper.GetThat(success: { Consume in
            self.Consume = Consume
            self.ecardCardView.todayCosume.text = "今日消费 ￥\(Consume.data.totalDay)"
            self.ecardCardView.monthConsume.text = "本月消费 ￥\(String(Consume.data.totalMonth).prefix(6))"
            self.ecardTableView.reloadData()
        }, failure: { _ in
            
        })
        
        GetSaveHelper.GetIt(success: { DetailInformation in
            self.DetailInformation = DetailInformation
            
            let balanceData = (self.DetailInformation.data.balance as NSString).substring(with: NSMakeRange(0, self.DetailInformation.data.balance.count - 1))
            if Double(balanceData)! < 20 {
                self.ecardCardView.notice.text = "余额快不够吃饭啦！"
            }
            
            self.ecardCardView.balance.text = "￥\(balanceData)"
            self.ecardCardView.cardId.text = self.DetailInformation.data.cardnum
            self.ecardCardView.userName.text = self.DetailInformation.data.name
            self.ecardCardView.AddView()
            self.ecardFirstHeaderView.AddView()
            self.ecardTableView.reloadData()
        }, failure: { _ in
            
        })
    }
    @objc func Announcement() {
        navigationController?.pushViewController(ProgramViewController1(), animated: true)
    }
    @objc func Question() {
        navigationController?.pushViewController(HelpViewController(), animated: true)
    }
    @objc func MoreMessage() {
        Figure.term = 6
        navigationController?.pushViewController(AccountViewController(), animated: true)
    }
    @objc func More() {
        cnt = ConsumeDetail.data.count
        self.ecardTableView.reloadData()
        self.ecardFirstFooterView.scanButton.isHidden = true
        self.ecardFirstFooterView.foldMessage.isHidden = true
    }
    @objc func refresh() {
        refreshData()
    }
    @objc func pop() {
        navigationController?.popViewController(animated: true)
    }
    //    override func viewWillDisappear(_ animated: Bool) {
    //        navigationController?.isToolbarHidden = true
    //        navigationController?.isNavigationBarHidden = true
    //    }
}
extension NewFirstPageViewController: UITableViewDelegate {
    
}
extension NewFirstPageViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            if ConsumeDetail == nil {
                return 0;
            } else if ConsumeDetail.data.count <= 4 {
                return ConsumeDetail.data.count
            } else { return cnt }
        } else {
            return 2
        }
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 80
        } else {
            return 40
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if ConsumeDetail == nil {return UITableViewCell()}
            return FirstPageCell(byModel: ConsumeDetail, withIndex: indexPath.row)
        } else {
            let cell = UITableViewCell()
            if indexPath.row == 0 {
                cell.addSubview(HelpButton1)
            } else {
                cell.addSubview(HelpButton2)
            }
            return cell
        }
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if (section == 0) {
            return ecardFirstHeaderView
        } else {
            return ecardSecondHeaderView
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 65
        } else {
            return 65
        }
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == 0 {
            ecardFirstFooterView.AddView()
            return ecardFirstFooterView
        } else {
            return nil
        }
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat(footerViewHeight)
    }
    
}

