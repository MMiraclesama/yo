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
    
    
    var ecardTableView = UITableView(frame: CGRect(x: 17, y: UINavigationController.accessibilityFrame().maxY, width: UIScreen.main.bounds.width - 35, height: UIScreen.main.bounds.height - 110), style: .grouped)
    let emptyView = UIView(frame: CGRect(x: 17, y: 0, width: UIScreen.main.bounds.width - 35, height: 30 * UIScreen.main.bounds.height / 1920))
    let ECardLabel = UILabel(frame: CGRect(x: 0, y: 30 * UIScreen.main.bounds.height / 1920, width: UIScreen.main.bounds.width - 35, height: 200))
    let Signs1 = UILabel(frame: CGRect(x: 0, y: 20, width: 10, height: 40))
    let DailyfeeLabel = UILabel(frame: CGRect(x: 15, y: 20, width: 100, height: 40))
    let DailyfeeButton = UIButton(frame: CGRect(x: UIScreen.main.bounds.width - 150, y: 400, width: 100, height: 40))
    var Date = UILabel(frame: CGRect(x: 20, y: 53, width: 60, height: 30))
    //    Mark:tableview高度要改
    var FoldMessage = UILabel(frame: CGRect(x: UIScreen.main.bounds.width / 2 - 120, y: 50 * UIScreen.main.bounds.height / 1920, width: 140, height: 20))
    var MoreMessageButton = UIButton(frame: CGRect(x: UIScreen.main.bounds.width - 125, y: 20, width: 80, height: 40))
    private let Signs2 = UILabel(frame: CGRect(x: 0, y: 15, width: 10, height: 40))
    private let Help = UILabel(frame: CGRect(x: 15, y: 15, width: 50, height: 40))
    var HelpButton1 = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 30))
    var HelpButton2 = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 30))
    var TodayCosume = UILabel(frame: CGRect(x: 20, y: 100, width: 150, height: 40))
    var MonthConsume = UILabel(frame: CGRect(x: 20, y: 130, width: 200, height: 40))
    var Id = UILabel(frame: CGRect(x: 280, y: 130, width: 300, height: 40))
    var Notice = UILabel(frame: CGRect(x: 80 + 50 * UIScreen.main.bounds.width / 1080, y: 20, width: 200, height: 30))
    var Balance = UILabel(frame: CGRect(x: 20, y: 50, width: 300, height: 55))
    var CardNum = UILabel(frame: CGRect(x: 20, y: 20, width: 60, height: 30))
    var scanButton = UIButton(frame: CGRect(x: UIScreen.main.bounds.width / 2 , y: 50 * UIScreen.main.bounds.height / 1920, width: 100, height: 20))
    var HeadView1 = UIView()
    var HeadView2 = UIView()
    var FootView = UIView()
    var headerView0 = UIView()
    var Consume: Consume!
    var ConsumeDetail: ConsumeDetail!
    var DetailInformation: DetailInformation!
    var moneyOfYours: MoneyTest = MoneyTest()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let leftButton = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(pop))
        leftButton.image = UIImage.resizedImage(image: UIImage(named:"返回-1")!, scaledToSize: CGSize(width: 20, height: 20))
        navigationItem.leftBarButtonItem = leftButton
        headerView0.frame = CGRect(x: 17, y: 0, width: UIScreen.main.bounds.width - 35, height: 200 + 20 * UIScreen.main.bounds.height / 1920)
        ecardTableView.tableHeaderView = headerView0
        ecardTableView.backgroundColor = .white
        let nowDate = NSDate()
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/ dd "
        let dateString = formatter.string(from: nowDate as Date)
        Date.text = dateString
        emptyView.backgroundColor = .white
        view.backgroundColor = .white
        navigationItem.title = "校园卡"
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.barTintColor = MyColor.ColorHex("#ffeb86")
        UINavigationBar.appearance().backgroundColor = UIColor.black
        navigationController?.setNavigationBarHidden(false, animated: true)
        let limage = UIImage.resizedImage(image: UIImage(named: "刷新")!, scaledToSize: CGSize(width: 25, height: 25))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: limage, style: .plain, target: self, action: #selector(refresh))
        loadData()
        ECardLabel.backgroundColor = MyColor.ColorHex("#ffeb86")
        ECardLabel.layer.masksToBounds = true
        ECardLabel.layer.cornerRadius = 20
        let ecardImage = UIImage.resizedImage(image: UIImage(named: "ecard")!, scaledToSize: CGSize(width: 200, height: 190))
        let ecardImageView = UIImageView(image: ecardImage)
        ecardImageView.frame = CGRect(x: ECardLabel.frame.minX + ECardLabel.frame.width / 2 - 30, y: ECardLabel.frame.minY - 10, width: 215, height: 200)
        ECardLabel.addSubview(ecardImageView)
        
        ecardTableView.delegate = self
        ecardTableView.dataSource = self
        //MARK: - look me
        //        ecardTableView.frame = view.bounds
        ecardTableView.showsVerticalScrollIndicator = false
        ecardTableView.allowsSelection = false
        Date.textColor = MyColor.ColorHex("#666666")
        Balance.textColor = MyColor.ColorHex("#444444")
        CardNum.textColor = MyColor.ColorHex("#555555")
        Notice.textColor = MyColor.ColorHex("#a84b4b")
        DailyfeeLabel.text = "今日流水"
        DailyfeeLabel.font = UIFont.flexibleSystemFont(ofSize: 19)
        Help.text = "帮助"
        Help.textColor = MyColor.ColorHex("#222222")
        Help.font = UIFont.flexibleSystemFont(ofSize: 19)
        FoldMessage.font = UIFont.flexibleSystemFont(ofSize: 15)
        scanButton.titleLabel?.font = UIFont.flexibleSystemFont(ofSize: 15)
        Signs1.backgroundColor = MyColor.ColorHex("#fbe98e")
        Signs2.backgroundColor = MyColor.ColorHex("#fbe98e")
        Balance.font = UIFont.boldSystemFont(ofSize: 40)
        Date.font = UIFont.flexibleSystemFont(ofSize: 17)
        
        scanButton.setTitle("点击显示", for: .normal)
        scanButton.setTitleColor(MyColor.ColorHex("#5e8dc5"), for: .normal)
        scanButton.titleLabel?.adjustsFontSizeToFitWidth = true
        scanButton.addTarget(self, action: #selector(More), for: .touchUpInside)
        HelpButton1.addTarget(self, action: #selector(Announcement), for: .touchUpInside)
        HelpButton2.addTarget(self, action: #selector(Question), for: .touchUpInside)
        MoreMessageButton.setTitle("更多流水 >", for: .normal)
        MoreMessageButton.sizeToFit()
        
        MoreMessageButton.setTitleColor(.gray, for: .normal)
        MoreMessageButton.titleLabel?.adjustsFontSizeToFitWidth = true
        //        FoldMessage.textAlignment = NSTextAlignment.center
        MoreMessageButton.addTarget(self, action: #selector(MoreMessage), for: .touchUpInside)
        HelpButton1.setTitle("补办校园卡流程说明", for: .normal)
        HelpButton1.setTitleColor(MyColor.ColorHex("#5e8dc5"), for: .normal)
        HelpButton2.setTitle("补办校园卡常见问题", for: .normal)
        HelpButton2.setTitleColor(MyColor.ColorHex("#5e8dc5"), for: .normal)
        HeadView1.addSubview(Signs1)
        HeadView1.addSubview(DailyfeeLabel)
        HeadView1.addSubview(DailyfeeButton)
        HeadView1.addSubview(Date)
        HeadView1.addSubview(MoreMessageButton)
        HeadView2.addSubview(Signs2)
        HeadView2.addSubview(Help)
        FootView.addSubview(FoldMessage)
        FootView.addSubview(scanButton)
        ECardLabel.addSubview(TodayCosume)
        ECardLabel.addSubview(MonthConsume)
        ECardLabel.addSubview(Id)
        ECardLabel.addSubview(Balance)
        ECardLabel.addSubview(CardNum)
        ECardLabel.addSubview(Notice)
        headerView0.addSubview(emptyView)
        headerView0.addSubview(ECardLabel)
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
            self.FoldMessage.text = ConsumeDetail.data.count > 4 ? "\(ConsumeDetail.data.count - 4)条记录被折叠" : "0条记录被折叠"
            self.FoldMessage.textColor = MyColor.ColorHex("#b2b2b2")
            if(ConsumeDetail.data.count - 4 <= 0) {
                self.scanButton.isHidden = true
            }
            if(ConsumeDetail.data.count - 4 > 0) {
                self.scanButton.titleLabel?.textColor = MyColor.ColorHex("#5e8dc5")
                self.scanButton.addTarget(self, action: #selector(self.More), for: .touchUpInside)
            }
            self.ecardTableView.reloadData()
        }, failure: { _ in
            
        })
        GetDailyDetailHelper.GetThat(success: { Consume in
            self.Consume = Consume
            let temptext = String(Consume.data.totalMonth).prefix(6)
            self.TodayCosume.text = "今日消费 ￥\(Consume.data.totalDay)"
            self.MonthConsume.text = "本月消费 ￥\(temptext)"
            self.ecardTableView.reloadData()
        }, failure: { _ in
            
        })
        
        GetSaveHelper.GetIt(success: { DetailInformation in
            self.DetailInformation = DetailInformation
            self.Balance.text = "￥\(self.DetailInformation.data.balance)"
            let balanceData = (self.DetailInformation.data.balance as NSString).substring(with: NSMakeRange(0, self.DetailInformation.data.balance.count - 1))
            self.Balance.text = "￥\(balanceData)"
            if Double(balanceData)! < 20 {
                self.Notice.text = "余额快不够吃饭啦！"
            }
            self.CardNum.text = self.DetailInformation.data.cardnum
            self.Id.text = self.DetailInformation.data.name
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
            self.FoldMessage.text = ConsumeDetail.data.count > 4 ? "\(ConsumeDetail.data.count - 4)条记录被折叠" : "0条记录被折叠"
            self.FoldMessage.textColor = MyColor.ColorHex("#b2b2b2")
            if(ConsumeDetail.data.count - 4 <= 0) {
                self.scanButton.isHidden = true
                self.FoldMessage.isHidden = true
                footerViewHeight = 0
            }
            if(ConsumeDetail.data.count - 4 > 0) {
                self.scanButton.titleLabel?.textColor = MyColor.ColorHex("#5e8dc5")
                self.scanButton.addTarget(self, action: #selector(self.More), for: .touchUpInside)
            }
            self.ecardTableView.reloadData()
        }, failure: { _ in
            
        })
        GetDailyDetailHelper.GetThat(success: { Consume in
            self.Consume = Consume
            let temptext = String(Consume.data.totalMonth).prefix(6)
            self.TodayCosume.text = "今日消费 ￥\(Consume.data.totalDay)"
            self.MonthConsume.text = "本月消费 ￥\(temptext)"
            self.ecardTableView.reloadData()
        }, failure: { _ in
            
        })
        
        GetSaveHelper.GetIt(success: { DetailInformation in
            self.DetailInformation = DetailInformation
            self.Balance.text = "￥\(self.DetailInformation.data.balance)"
            let balanceData = (self.DetailInformation.data.balance as NSString).substring(with: NSMakeRange(0, self.DetailInformation.data.balance.count - 1))
            self.Balance.text = "￥\(balanceData)"
            if Double(balanceData)! < 20 {
                self.Notice.text = "余额快不够吃饭啦！"
            }
            self.CardNum.text = self.DetailInformation.data.cardnum
            self.Id.text = self.DetailInformation.data.name
            self.ecardTableView.reloadData()
        }, failure: { _ in
            
        })
    }
    @objc func Announcement() {
        navigationController?.pushViewController(ProgramViewController(), animated: true)
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
        self.scanButton.isHidden = true
        self.FoldMessage.isHidden = true
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
            
            return HeadView1
        } else {
            return HeadView2
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 85
        } else {
            return 65
        }
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == 0 {
            return FootView
        } else {
            return nil
        }
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat(footerViewHeight)
    }
    
}

