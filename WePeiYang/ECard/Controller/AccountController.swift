//
//  AccountController.swift
//  WePeiYang
//
//  Created by 王申宇 on 2019/3/24.
//  Copyright © 2019 twtstudio. All rights reserved.
//
//MARK: -1.15/3
import UIKit
import SnapKit
import Charts

struct Device {
    static let width = UIScreen.main.bounds.width
    static let height = UIScreen.main.bounds.height
}

class AccountViewController: UIViewController {
    
    var tempx = [Int]()
    var accountTableview = UITableView(frame: .zero, style: .grouped)
    var tuenover: ConsumeDetail!
    var lintchart: LintChart!
    var InitialNum: Int = 0 //用来设置term的变量
    var scrollerview: UIScrollView!
    var lineScrollerView: UIScrollView!
    var dateScrollerView: UIScrollView!
    var shapeLayer: CAShapeLayer!
    let cornerRadius: CGFloat = 0.1
    var lastSelect: Int = 0
    var costLabel = UILabel() //消费
    var rechargeLabel = UILabel() // 充值
    var lineScrollerLength: CGFloat = ScaleScreen.scaleWidth * CGFloat(215 * (Figure.term + 1))
    //折线图长度（可变）
    var cost = UILabel() //
    var costsign = UILabel()
    var dateScrollViewLeftLabel = UILabel()
    var dateScrollViewRightLabel = UILabel()

    var messCostFront = UILabel()
    var marketCostFront = UILabel()
    var otherCostFront = UILabel()
    var messCost = UILabel() //食堂
    var marketCost = UILabel() //超市
    var otherCost = UILabel() //其他
    var messScale = UIView()
    var marketScale = UIView()
    var otherScale = UIView()
    var dateview = UIView()
    var dateArray = [UILabel]() //折线图下的日期
    var slideBackView: UIView! // ScrollerView滚动条背景
    var slideView: UIView! //ScrollerView滚动块
    var pointView: UIImageView!
    var lineView: UIImageView!
    //构建三角形button
    var datetext = [String]()
    var point = [CGPoint]()
    var scaleview: ScaleLabelView = ScaleLabelView()
    var lintView: EcardLineChartsView = EcardLineChartsView()
    var sjsw: CGRect = CGRect(x: Device.width + 30, y: 470, width: 360, height: 26)
    var moneyOfYours: MoneyTest = MoneyTest()
    let lastestDay: LastedDay = LastedDay()
    let acTableView: AccountTableView = AccountTableView()
    let accountScrollView: AccountScrollView = AccountScrollView()
    let lineTableView: LineTableView = LineTableView()
    let ecardAccountHeaderView = EcardAccountHeaderView()
    
    private var refreshButton: UIView? {
        let button = navigationItem.rightBarButtonItem?.value(forKey: "view") as? UIView
        button?.layer.anchorPoint = CGPoint(x: 0.54, y: 0.54)
        return button
    }
    
    private var isRefreshing: Bool = false
    private var loadImage: UIImageView = UIImageView()
    private var loadLabel: UILabel = UILabel()
    
    private func startRotating() {
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAnimation.toValue = CGFloat.pi
        rotationAnimation.duration = 0.5
        rotationAnimation.isCumulative = true
        rotationAnimation.repeatCount = 1000
        refreshButton?.layer.add(rotationAnimation, forKey: "rotationAnimation")
//        loadImage.frame = CGRect(x: lineScrollerView.width / 2 - 77 * ScaleScreen.scaleWidth, y: lineScrollerView.height / 2 - 25 * ScaleScreen.scaleHeight, width: 154 * ScaleScreen.scaleWidth, height: 50 * ScaleScreen.scaleHeight)
//        self.lineScrollerView.addSubview(loadImage)
        loadLabel = UILabel(frame: CGRect(x: loadImage.frame.minX - 25, y: loadImage.frame.maxY + 16, width: loadImage.width + 50, height: loadImage.height))
        loadLabel.text = "跪着加载中..."
        loadLabel.textColor = UIColor(hex6: 0xb4a972)
        loadLabel.font = UIFont.flexibleSystemFont(ofSize: 16)
//        self.lineScrollerView.addSubview(loadLabel)
    }
    
    private func stopRotating() {
        refreshButton?.layer.removeAllAnimations()
        self.loadLabel.removeFromSuperview()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.backgroundColor = .white
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.barTintColor = UIColor(hex6: 0xffeb86)
        navigationItem.title = "流水查询"
        let limage = UIImage.resizedImage(image: UIImage(named: "刷新")!, scaledToSize: CGSize(width: 25, height: 25))
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: limage, style: .plain, target: self, action: #selector(refresh))
        
        let leftButton = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(pop))
        leftButton.image = UIImage.resizedImage(image: UIImage(named:"返回-1")!, scaledToSize: CGSize(width: 20, height: 20))
        navigationItem.leftBarButtonItem = leftButton
        
//        self.accountTableview.frame = CGRect(x: 0, y: -40 , width: Device.width, height: Device.height * 3 / 4)
//        self.accountTableview.delegate = self
//        self.accountTableview.dataSource = self
//        self.accountTableview.showsVerticalScrollIndicator = false
//        self.accountTableview.bounces = false
//        self.accountTableview.backgroundColor = .white
        loadData()
        accountTableview.allowsSelection = false
        lineTableView.ecardLineView.AccountlineChartView.delegate = lineTableView.ecardLineView.self
        lintView.AccountlineChartView.delegate = lintView.self
        lineTableView.tableHeaderView?.height = 40
        lineTableView.tableHeaderView = ecardAccountHeaderView
        addThem()
        self.addAllSubviews()
//        self.addScrollerView()
//        self.addDateLabel()
//        self.scaleview.myrect = sjsw
//        self.addOtherView()
    }
    
    func addThem() {
        lastestDay.backgroundColor = .white
        view.addSubview(lastestDay)
        lastestDay.snp.makeConstraints { make in
            make.width.equalTo(view.snp.width)
            make.height.equalTo(50)
            make.top.equalTo(100)
        }
        lastestDay.AddView()
        
        accountScrollView.backgroundColor = .white
        view.addSubview(accountScrollView)
        accountScrollView.snp.makeConstraints { make in
            make.width.equalTo(view.snp.width)
            make.top.equalTo(lastestDay.snp.bottom)
            make.height.equalTo(Device.height*3/4)
        }
        accountScrollView.AddView()
        
        acTableView.backgroundColor = .white
        accountScrollView.addSubview(acTableView)
        acTableView.snp.makeConstraints { make in
            make.width.equalTo(view.snp.width)
            make.height.equalTo(accountScrollView.snp.height)
            make.left.equalTo(accountScrollView.snp.left)
        }
        acTableView.AddView()
        
        lineTableView.backgroundColor = .white
        accountScrollView.addSubview(lineTableView)
        lineTableView.snp.makeConstraints { make in
            make.width.equalTo(view.snp.width)
            make.height.equalTo(accountScrollView.snp.height)
            make.left.equalTo(acTableView.snp.right)
        }
        lineTableView.AddView()
        
        ecardAccountHeaderView.costLabel.text = "消费：\(String(num1 + num2 + num3).prefix(5))元"
        ecardAccountHeaderView.rechangLabel.text = "充值：\(String(num4).prefix(5))元"
        ecardAccountHeaderView.snp.makeConstraints { make in
            make.width.equalTo(view.width)
            make.height.equalTo(60)
        }
        ecardAccountHeaderView.AddView()
    }
    
    //设置label和button
    func addAllSubviews(){
        costLabel.text = "消费：\(String(num1 + num2 + num3).prefix(5))元"
        costLabel.frame = CGRect(x: Device.width + 230 * 1.15 / 3, y: 10, width: 200, height: 56 * 1.15 / 3)
        rechargeLabel.text = "充值：\(String(num4).prefix(5))元"
        rechargeLabel.frame = CGRect(x: Device.width + 650 * 1.15 / 3, y: 10, width: 150, height: 56 * 1.15 / 3)
        
        cost = UILabel(frame:CGRect(x: Device.width + 30 * 1.15, y: 430, width: Device.width * 4 / 5, height: 20))
        cost.text = "消费占比"
        cost.font = UIFont.flexibleSystemFont(ofSize: 19)
        self.view.addSubview(cost)
        
        costsign = UILabel(frame: CGRect(x: cost.frame.minX - 14, y: cost.frame.minY - 10, width: 10, height: 30))
        costsign.backgroundColor = UIColor(hex6: 0xffeb86)
    
        messCostFront.frame = CGRect(x: Device.width + 85 * 1.15 / 3, y: cost.frame.maxY + 52, width: 10, height: 10)
        messCostFront.backgroundColor = UIColor(hex6: 0xf8d316)
        messCostFront.layer.masksToBounds = true
        messCostFront.layer.cornerRadius = messCostFront.bounds.size.width / 2
        
        messCost.frame = CGRect(x: messCostFront.frame.maxX + 2, y: messCostFront.frame.minY, width: 105, height: 10)
        messCost.backgroundColor = .white
        messCost.text = "食堂:\(num3)元"
        messCost.font = UIFont.flexibleSystemFont(ofSize: 13)
        
        marketCostFront.frame = CGRect(x: messCost.frame.maxX + 12 , y: cost.frame.maxY + 52, width: 10, height: 10)
        marketCostFront.backgroundColor = UIColor(hex6: 0xfff5c2)
        marketCostFront.layer.masksToBounds = true
        marketCostFront.layer.cornerRadius = messCostFront.bounds.size.width / 2
        
        marketCost.frame = CGRect(x: marketCostFront.frame.maxX + 2, y: cost.frame.maxY + 52, width: 105, height: 10)
        marketCost.backgroundColor = .white
        marketCost.text = "超市:\(num2)元"
        marketCost.font = UIFont.flexibleSystemFont(ofSize: 13)
        
        otherCostFront.frame = CGRect(x: marketCost.frame.maxX + 2 , y: cost.frame.maxY + 52 , width: 10, height: 10)
        otherCostFront.backgroundColor = UIColor(hex6: 0xffeb86)
        otherCostFront.layer.masksToBounds = true
        otherCostFront.layer.cornerRadius = otherCostFront.bounds.size.width / 2
        
        otherCost.frame = CGRect(x: otherCostFront.frame.maxX + 2, y: cost.frame.maxY + 52 , width: 120, height: 10)
        otherCost.backgroundColor = .white
        otherCost.text = "其他:\(num1)元"
        otherCost.font = UIFont.flexibleSystemFont(ofSize: 13)
    }
    
    func addDateLabel() {
        dateScrollViewRightLabel.frame = CGRect(x: dateScrollerView.frame.maxX + 5, y: dateScrollerView.frame.minY + 7, width: 30, height: dateScrollerView.frame.height)
        dateScrollViewRightLabel.text = "日"
        dateScrollViewRightLabel.textColor = UIColor(hex6: 0xe3cca1)
        dateScrollViewRightLabel.backgroundColor = .white
        self.scrollerview.addSubview(dateScrollViewRightLabel)
        
        dateScrollViewLeftLabel.frame = CGRect(x: dateScrollerView.frame.minX - 30, y: dateScrollerView.frame.minY + 7, width: 40, height: dateScrollerView.frame.height)
        dateScrollViewLeftLabel.textColor = UIColor(hex6: 0xe3cca1)
        dateScrollViewLeftLabel.backgroundColor = .white
        self.scrollerview.addSubview(dateScrollViewLeftLabel)
    }
    //很多scrollerview
    func addScrollerView() {
        scrollerview = UIScrollView(frame: CGRect(x: 0, y: 157, width: Device.width, height: Device.height * 3 / 4))
        scrollerview.backgroundColor = .white
        scrollerview.showsHorizontalScrollIndicator = false
        scrollerview.showsVerticalScrollIndicator = false
        scrollerview.contentSize = CGSize(width: Device.width*2,height: 0)
        scrollerview.contentOffset = CGPoint(x: 0, y: 0.0)
//        scrollerview.delegate = self
        scrollerview.bounces = false
        
        lineScrollerView = UIScrollView(frame:CGRect(x: Device.width + 37, y: 145 * 1.15 / 3, width: Device.width - 75, height: 623 * 1.15 / 3))
//        lineScrollerView.isPagingEnabled = true
        lineScrollerView.backgroundColor = .white
        lineScrollerView.showsHorizontalScrollIndicator = false
        lineScrollerView.showsVerticalScrollIndicator = false
        lineScrollerView.contentOffset = CGPoint(x: 0, y: 0)
//        lineScrollerView.delegate = self
        lineScrollerView.bounces = false
        //FIXME: - 下挪 高度变小
        dateScrollerView = UIScrollView(frame: CGRect(x: lineScrollerView.frame.minX, y: lineScrollerView.frame.maxY + 30, width: lineScrollerView.frame.width, height: 60 * ScaleScreen.scaleHeight))
        dateScrollerView.isPagingEnabled = true
        dateScrollerView.backgroundColor = .white
        dateScrollerView.showsHorizontalScrollIndicator = false
        dateScrollerView.showsVerticalScrollIndicator = false
        dateScrollerView.contentOffset = CGPoint(x: 0, y: 0)
//        dateScrollerView.delegate = self
        dateScrollerView.bounces = false
        //FIXME: - 这两个宽度变窄
        slideBackView = UIView(frame: CGRect(x: lineScrollerView.frame.minX, y: lineScrollerView.frame.maxY + 17, width: lineScrollerView.frame.width, height: 8))
        slideBackView.backgroundColor = UIColor(hex6: 0xfff5c2)
        slideBackView.layer.cornerRadius = 4
        
        slideView = UIView(frame: CGRect(x: lineScrollerView.frame.minX , y: lineScrollerView.frame.maxY + 17, width: lineScrollerView.frame.width / 10, height: 8))
        slideView.backgroundColor = UIColor(hex6: 0xffe043)
        slideView.layer.cornerRadius = 3.5
        
        self.scrollerview.addSubview(accountTableview)
        self.scrollerview.addSubview(cost)
        self.lineScrollerView.addSubview(lintView.AccountlineChartView)
        self.scrollerview.addSubview(lineScrollerView)
        self.scrollerview.addSubview(slideBackView)
        self.scrollerview.addSubview(slideView)
        self.dateScrollerView.addSubview(dateview)
        self.scrollerview.addSubview(dateScrollerView)
        self.view.addSubview(scrollerview)
    }
    
    func addOtherView() {
        pointView = UIImageView(frame: CGRect(x: Device.width / 2  - 40, y: scrollerview.frame.maxY + 10, width: 30 * ScaleScreen.scaleWidth, height: 30 * ScaleScreen.scaleWidth))
        pointView.image = UIImage.resizedImage(image: UIImage(named: "未标题-1")!, scaledToSize: CGSize(width: 30 * ScaleScreen.scaleWidth, height: 30 * ScaleScreen.scaleWidth))
        self.view.addSubview(pointView)
        
        lineView = UIImageView(frame: CGRect(x: pointView.frame.maxX + 15, y: pointView.frame.minY, width: 100 * ScaleScreen.scaleWidth, height: 30 * ScaleScreen.scaleWidth))
        lineView.image = UIImage.resizedImage(image: UIImage(named: "bottom2")!, scaledToSize: CGSize(width: 100 * ScaleScreen.scaleWidth, height: 30 * ScaleScreen.scaleWidth))
        self.view.addSubview(lineView)
        
        self.scrollerview.addSubview(self.scaleview.llabel)
        self.scrollerview.addSubview(self.scaleview.mlabel)
        self.scrollerview.addSubview(self.scaleview.rlabel)
        self.scrollerview.addSubview(costLabel)
        self.scrollerview.addSubview(rechargeLabel)
        self.scrollerview.addSubview(costsign)
        self.scrollerview.addSubview(otherCostFront)
        self.scrollerview.addSubview(marketCostFront)
        self.scrollerview.addSubview(messCostFront)
        self.scrollerview.addSubview(messCost)
        self.scrollerview.addSubview(marketCost)
        self.scrollerview.addSubview(otherCost)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        if scrollView == lineScrollerView {
            UIView.animate(withDuration: 0, animations: {
                
                let offset: CGPoint = scrollView.contentOffset
                
                var frame: CGRect = self.slideView.frame
                self.dateScrollerView.contentOffset = scrollView.contentOffset
                
                frame.origin.x = self.lineScrollerView.frame.minX + offset.x * (self.slideBackView.frame.size.width - self.slideView.frame.size.width) / (scrollView.contentSize.width - scrollView.frame.size.width)
                
                self.slideView.frame = frame
            })
        } else if scrollView == scrollerview {
            self.accountTableview.isScrollEnabled = false
            
            UIView.animate(withDuration: 0, animations: {
                let offset: CGPoint = scrollView.contentOffset
                
                var pointFrame: CGRect = self.pointView.frame
                var lineFrame: CGRect = self.lineView.frame
                
                pointFrame.origin.x = Device.width / 2 - 40 + 2 * offset.x * (80 * ScaleScreen.scaleWidth - self.pointView.frame.width) / (scrollView.contentSize.width - scrollView.frame.size.width)
                
                let temp = 20 * offset.x * (90 * ScaleScreen.scaleWidth - self.lineView.frame.width) / (scrollView.contentSize.width - scrollView.frame.size.width)
                
                lineFrame.origin.x = self.pointView.frame.maxX + 15 + temp
                self.pointView.frame = pointFrame
                self.lineView.frame = lineFrame
            })
//        } else if scrollView == dateScrollerView {
//
//            UIView.animate(withDuration: 0, animations: {
//                let offset: CGPoint = scrollView.contentOffset
//
//                for i in 0..<tempx.count {
//                    if offset.x + 20 == self.dateArray[i].frame.minX {
//                        self.dateScrollViewLeftLabel.text = "\(self.lintchart.data2[self.lintchart.data2.count - Figure.term - 1 + i].date.suffix(4).prefix(2))月"
//                    }
//                }
//            })
        }
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView == scrollerview {
            self.accountTableview.isScrollEnabled = true
        }
    }
    //刷新
    func refreshData() {
        guard isRefreshing == false else {
            return
        }
        isRefreshing = true
        for i in 0..<self.dateArray.count {
            self.dateArray[i].removeFromSuperview()
        }
        self.lintView.AccountlineChartView.removeFromSuperview()
        self.dateArray.removeAll()
        self.datetext.removeAll()
        self.point.removeAll()
        self.messScale.removeFromSuperview()
        self.marketScale.removeFromSuperview()
        self.otherScale.removeFromSuperview()
        self.scaleview.llabel.removeFromSuperview()
        self.scaleview.mlabel.removeFromSuperview()
        self.scaleview.rlabel.removeFromSuperview()

        startRotating()
        GetConsumeHelper.GetConsume(success: { tuenover in
            self.isRefreshing = false
            self.tuenover = tuenover
            self.lintView.tuenover = tuenover
            for i in 0..<tuenover.data.count {
                if(tuenover.data[i].subtype == "其他") {
                    sum1 += Double(tuenover.data[i].amount)!
                } else if(tuenover.data[i].subtype == "超市") {
                    sum2 += Double(tuenover.data[i].amount)!
                } else if(tuenover.data[i].subtype == "食堂"){
                    sum3 += Double(tuenover.data[i].amount)!
                } else {
                    sum4 += Double(tuenover.data[i].amount)!
                }
            }
            num1 = sum1
            num2 = sum2
            num3 = sum3
            num4 = sum4
            sum1 = 0.0
            sum2 = 0.0
            sum3 = 0.0
            sum4 = 0.0
            var temp = "\(num3)"
            self.messCost.text = "食堂:\(temp.prefix(5))元"
            temp = "\(num2)"
            self.marketCost.text = "超市:\(temp.prefix(5))元"
            temp = "\(num1)"
            self.otherCost.text = "其他:\(temp.prefix(5))元"
            if num4 < 1000.0 {
                self.rechargeLabel.text = "充值：\(String(num4).prefix(5))元"
            } else {
                self.rechargeLabel.text = "充值：\(String(num4).prefix(6))元"
            }
            if num1 + num2 + num3 < 1000.0 {
                self.costLabel.text = "消费：\(String(num1 + num2 + num3).prefix(5))元"
            } else {
                self.costLabel.text = "消费：\(String(num1 + num2 + num3).prefix(6))元"
            }
//                self.scaleview.LabelScale(&self.messScale, &self.marketScale, &self.otherScale, num3, num2, num1, self.scaleview.myrect)
                self.scrollerview.addSubview(self.messScale)
                self.scrollerview.addSubview(self.marketScale)
                self.scrollerview.addSubview(self.otherScale)
                self.scrollerview.addSubview(self.scaleview.llabel)
                self.scrollerview.addSubview(self.scaleview.mlabel)
                self.scrollerview.addSubview(self.scaleview.rlabel)
            
            t = 0
            self.accountTableview.reloadData()
        }, failure: { _ in
            self.isRefreshing = false
            self.stopRotating()
        })
        
        LintChartHelper.getLintChart(success: { lintchart in
            self.isRefreshing = false
            self.lintView.lintchart = lintchart
            SwiftMessages.hideLoading()
            self.stopRotating()

            self.lineScrollerView.contentSize = CGSize(width: self.lineScrollerLength, height: 623 * 1.15 / 3)
            self.lintView.AccountlineChartView.frame = CGRect(x:0, y: 0, width: self.lineScrollerLength, height: 623 * 1.15 / 3)
            self.dateScrollerView.contentSize = CGSize(width: self.lineScrollerLength, height: 40)
            self.dateScrollViewLeftLabel.text = String(lintchart.data2[lintchart.data2.count - Figure.term - 1].date).suffix(4).prefix(2) + "月"
            self.lintView.setupLineChartView()
            self.scrollerview.addSubview(self.lineScrollerView)
            self.lineScrollerView.addSubview(self.lintView.AccountlineChartView)
            self.scrollerview.addSubview(self.dateScrollerView)
            self.addDateLabel()
            for i in 0...Figure.term {
            self.point.append(self.lintView.AccountlineChartView.getTransformer(forAxis: self.lintView.AccountlineChartView.data!.dataSets[0].axisDependency).pixelForValues(x: self.lintView.myentrys[i].x, y: self.lintView.myentrys[i].y))
                let dateLabel = UILabel(frame: CGRect(x: self.point[i].x - 8, y: 0, width: 40, height: 40))
                self.dateScrollerView.addSubview(dateLabel)
                self.dateArray.append(dateLabel)
                self.datetext.append(String(lintchart.data2[lintchart.data2.count - Figure.term - 1 + i].date.suffix(2)))
                self.dateArray[i].text = self.datetext[i]
                self.dateArray[i].textColor = UIColor(hex6: 0xffd942)
            }
            
        }, failure: { _ in
            
        })
        
    }
    
    func loadData() {
        GetConsumeHelper.GetConsume(success: { tuenover in
//            self.tuenover = tuenover
            self.acTableView.tuenover = tuenover
            self.lintView.tuenover = tuenover
            self.lineTableView.ecardLineView.tuenover = tuenover

            self.acTableView.reloadData()
        }, failure: { _ in
            
        })
        
        LintChartHelper.getLintChart(success: { lintchart in
            self.lineTableView.ecardLineView.lintchart = lintchart
            self.lineTableView.lineScroll.contentSize = CGSize(width: self.lineScrollerLength, height: Device.height / 4 - 40)
            self.lineTableView.ecardLineView.AccountlineChartView.snp.makeConstraints { make in
                make.width.equalTo(self.lineTableView.lineScroll.contentSize.width)
                make.height.equalTo(self.lineTableView.lineScroll.contentSize.height)
            }
            for i in 0...Figure.term {
            self.lineTableView.ecardLineView.labels.append(String(lintchart.data2[lintchart.data2.count - Figure.term - 1 + i].date.suffix(2)))
            }
            self.lineTableView.ecardLineView.setupLineChartView()
            self.lineTableView.ecardLineView.initCharts()
            self.lineTableView.reloadData()

        }, failure: { _ in
            
        })
    }
    // 三角形button的方法
    func TriangleButtun() {
        switch InitialNum {
        case 0:
            Figure.term = 6
            refreshData()
            lastestDay.dayLabel.text = "最近7天"
            lastestDay.leftTriangle.isEnabled = false
            lastestDay.leftTriangle.setImage(UIImage.resizedImage(image: UIImage(named: "选择三角左")!, scaledToSize: CGSize(width: 27, height: 27)), for: .normal)
            lastestDay.rightTriangle.backgroundColor = .white
            lastestDay.rightTriangle.isEnabled = true
            lastestDay.rightTriangle.setImage(UIImage.resizedImage(image: UIImage(named: "选择三角右")!, scaledToSize: CGSize(width: 27, height: 27)), for: .normal)
            lastestDay.rightTriangle.setImage(UIImage.resizedImage(image: UIImage(named: "选择三角右")!, scaledToSize: CGSize(width: 27, height: 27)), for: .highlighted)
            lastestDay.rightTriangle.showsTouchWhenHighlighted = false
            self.lineScrollerLength = CGFloat(76 * (Figure.term + 1))
            break
        case 1:
            Figure.term = 14
            refreshData()
            lastestDay.dayLabel.text = "最近15天"
            lastestDay.leftTriangle.backgroundColor = .white
            lastestDay.leftTriangle.setImage(UIImage.resizedImage(image: UIImage(named: "选择三角左黄")!, scaledToSize: CGSize(width: 27, height: 27)), for: .normal)
            lastestDay.leftTriangle.setImage(UIImage.resizedImage(image: UIImage(named: "选择三角左黄")!, scaledToSize: CGSize(width: 27, height: 27)), for: .highlighted)
            lastestDay.leftTriangle.isEnabled = true
            lastestDay.rightTriangle.backgroundColor = .white
            lastestDay.rightTriangle.isEnabled = true
            lastestDay.rightTriangle.showsTouchWhenHighlighted = false
            lastestDay.rightTriangle.setImage(UIImage.resizedImage(image: UIImage(named: "选择三角右")!, scaledToSize: CGSize(width: 27, height: 27)), for: .normal)
            lastestDay.rightTriangle.setImage(UIImage.resizedImage(image: UIImage(named: "选择三角右")!, scaledToSize: CGSize(width: 27, height: 27)), for: .highlighted)
            self.lineScrollerLength = CGFloat(76 * (Figure.term + 1))
            break
        case 2:
            Figure.term = 29
            refreshData()
            lastestDay.dayLabel.text = "最近30天"
            lastestDay.leftTriangle.backgroundColor = .white
            lastestDay.leftTriangle.isEnabled = true
            lastestDay.leftTriangle.setImage(UIImage.resizedImage(image: UIImage(named: "选择三角左黄")!, scaledToSize: CGSize(width: 27, height: 27)), for: .normal)
            lastestDay.leftTriangle.setImage(UIImage.resizedImage(image: UIImage(named: "选择三角左黄")!, scaledToSize: CGSize(width: 27, height: 27)), for: .highlighted)
            lastestDay.rightTriangle.backgroundColor = .white
            lastestDay.rightTriangle.showsTouchWhenHighlighted = false
            lastestDay.rightTriangle.isEnabled = true
            lastestDay.rightTriangle.setImage(UIImage.resizedImage(image: UIImage(named: "选择三角右")!, scaledToSize: CGSize(width: 27, height: 27)), for: .normal)
            lastestDay.rightTriangle.setImage(UIImage.resizedImage(image: UIImage(named: "选择三角右")!, scaledToSize: CGSize(width: 27, height: 27)), for: .highlighted)
            self.lineScrollerLength = CGFloat(76 * (Figure.term + 1))
            break
        default:
            Figure.term = 59
            refreshData()
            lastestDay.dayLabel.text = "最近60天"
            lastestDay.leftTriangle.backgroundColor = .white
            lastestDay.leftTriangle.isEnabled = true
            lastestDay.leftTriangle.setImage(UIImage.resizedImage(image: UIImage(named: "选择三角左黄")!, scaledToSize: CGSize(width: 27, height: 27)), for: .normal)
            lastestDay.leftTriangle.setImage(UIImage.resizedImage(image: UIImage(named: "选择三角左黄")!, scaledToSize: CGSize(width: 27, height: 27)), for: .highlighted)
            lastestDay.rightTriangle.isEnabled = false
            lastestDay.rightTriangle.setImage(UIImage.resizedImage(image: UIImage(named: "选择三角右灰")!, scaledToSize: CGSize(width: 27, height: 27)), for: .normal)
            self.lineScrollerLength = CGFloat(76 * (Figure.term + 1))
            break
        }
    }
}

extension AccountViewController {
    @objc func pop() {
        navigationController?.popViewController(animated: true)
    }
    @objc func refresh() {
        refreshData()
    }
    @objc func LessList() {
        self.InitialNum -= 1
        TriangleButtun()
    }
    
    @objc func MoreList() {
        self.InitialNum += 1
        TriangleButtun()
    }
}

extension AccountViewController {
    private func initCharts() {
        var labels = [String]()
        for i in 0..<Figure.term {
        labels.append(String(lintView.lintchart.data2[lintView.lintchart.data2.count - Figure.term - 1 + i].date.suffix(2)))
        }
        let xAxis = lintView.AccountlineChartView.xAxis
        
        xAxis.labelPosition = XAxis.LabelPosition.bottom
//        xAxis.axisLineColor = MyColor.ColorHex("#ffd942")!
        xAxis.labelTextColor = UIColor(hex6: 0xffd942)
        xAxis.valueFormatter = ArrayIndexValueFormatter(labels: labels)
        xAxis.axisMinimum = 0
        xAxis.setLabelCount(Figure.term, force: true)
        xAxis.axisMaximum = Double(Figure.term)
    }
}
