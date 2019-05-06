//
//  AccountController.swift
//  WePeiYang
//
//  Created by 王申宇 on 2019/3/24.
//  Copyright © 2019 twtstudio. All rights reserved.
//
//MARK: -1.15/3
import UIKit
import Charts

struct Device {
    static let width = UIScreen.main.bounds.width
    static let height = UIScreen.main.bounds.height
}

class AccountViewController: UIViewController {
    
    private var isRefreshing: Bool = false
    
    var llabel = UILabel()
    var DayLabel = UILabel()
    var accountTableview = UITableView(frame: .zero, style: .grouped)
    var leftButton = UIButton()
    var rightButton = UIButton()
    var tuenover: ConsumeDetail!
    var lintchart: LintChart!
    var InitialNum: Int = 1 //用来设置term的变量
    var scrollerview: UIScrollView!
    var lineScrollerView: UIScrollView!
    var dateScrollerView: UIScrollView!
    var shapeLayer: CAShapeLayer!
    let cornerRadius: CGFloat = 0.1
    var lastSelect: Int = 0
    var costLabel = UILabel() //消费
    var rechargeLabel = UILabel() // 充值
    //MARK: - 此时term=6
    var lineScrollerLength: CGFloat = 76 * 7 //折线图长度（可变）
    var cost = UILabel() //
    
    var dateScrollViewLeftLabel = UILabel()
    var dateScrollViewRightLabel = UILabel()

    var messCostFront = UILabel()
    var marketCostFront = UILabel()
    var otherCostFront = UILabel()
    var messCost = UILabel() //食堂
    var marketCost = UILabel() //超市
    var otherCost = UILabel() //其他
    var messScale = UILabel()
    var marketScale = UILabel()
    var otherScale = UILabel()
    var dateview = UIView()
    var dateArray = [UILabel]() //折线图下的日期
    var slideBackView: UIView! // ScrollerView滚动条背景
    var slideView: UIView! //ScrollerView滚动块
    //构建三角形button
    var flinePath = UIGraphicsGetCurrentContext()
    var firstPoint: CGPoint = CGPoint()
    var secondPoint: CGPoint = CGPoint()
    var thirdPoint: CGPoint = CGPoint()
    var slinePath = UIGraphicsGetCurrentContext()
    var forthPoint: CGPoint = CGPoint()
    var fifthPoint: CGPoint = CGPoint()
    var sixthPoint: CGPoint = CGPoint()
    var datetext: [String] = []
    var sjsw: CGRect = CGRect(x: Device.width + 40, y: 400, width: 400, height: 56)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.backgroundColor = .white
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.tintColor = .blue
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = ColorHex("#ffeb86")
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "返回", style: .plain, target: self, action: nil)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(Refresh))
        
        self.accountTableview.frame = CGRect(x: 0, y: 0, width: Device.width, height: Device.height)
        self.accountTableview.delegate = self
        self.accountTableview.dataSource = self
        self.accountTableview.backgroundColor = .white
        loadData()

        AccountlineChartView.frame = CGRect(x:0, y: 0, width: lineScrollerLength, height: 623 * 1.15 / 3)
        AccountlineChartView.delegate = self
        self.addAllSubviews()
        self.addScrollerView()
        self.addDateLabel()
        LabelScale(&messScale, &marketScale, &otherScale, sum3, sum2, sum1, sjsw)
        self.scrollerview.addSubview(messScale)
        self.scrollerview.addSubview(marketScale)
        self.scrollerview.addSubview(otherScale)
        self.scrollerview.addSubview(llabel)
        scrollViewDidScroll(lineScrollerView)
    }
    
    func layoutSubviews() {
        flinePath?.move(to: firstPoint)
        flinePath?.addLine(to: secondPoint)
        flinePath?.addLine(to: thirdPoint)
        flinePath?.closePath()
        flinePath?.setStrokeColor(UIColor.green.cgColor)
        flinePath?.setFillColor(UIColor.yellow.cgColor)
        flinePath?.drawPath(using: .fillStroke)
        flinePath?.strokePath()
        
        slinePath?.move(to: forthPoint)
        slinePath?.addLine(to: fifthPoint)
        slinePath?.addLine(to: sixthPoint)
        slinePath?.closePath()
        slinePath?.setStrokeColor(UIColor.green.cgColor)
        slinePath?.setFillColor(UIColor.yellow.cgColor)
        slinePath?.drawPath(using: .fillStroke)
        slinePath?.strokePath()
    }
    
    func ColorHex(_ color: String) -> UIColor? {
        if color.count <= 0 || color.count != 7 || color == "(null)" || color == "<null>" {
            return nil
        }
        var red: UInt32 = 0x0
        var green: UInt32 = 0x0
        var blue: UInt32 = 0x0
        let redString = String(color[color.index(color.startIndex, offsetBy: 1)...color.index(color.startIndex, offsetBy: 2)])
        let greenString = String(color[color.index(color.startIndex, offsetBy: 3)...color.index(color.startIndex, offsetBy: 4)])
        let blueString = String(color[color.index(color.startIndex, offsetBy: 5)...color.index(color.startIndex, offsetBy: 6)])
        Scanner(string: redString).scanHexInt32(&red)
        Scanner(string: greenString).scanHexInt32(&green)
        Scanner(string: blueString).scanHexInt32(&blue)
        let hexColor = UIColor.init(red: CGFloat(red)/255.0, green: CGFloat(green)/255.0, blue: CGFloat(blue)/255.0, alpha: 1)
        return hexColor
    }
    //设置label和button
    func addAllSubviews(){
        leftButton.frame = CGRect(x: Device.width / 2 - 60, y: 25, width: 20, height: 20)
//        leftButton.imageView = #imageLiteral(resourceName: "选择.png")
        leftButton.addTarget(self, action: #selector(LessList), for: .touchUpInside)
        leftButton.backgroundColor = ColorHex("#ffeb86")
        self.view.addSubview(leftButton)
        rightButton.frame = CGRect(x: Device.width / 2 + 40, y: 25, width: 20, height: 20)
        rightButton.addTarget(self, action: #selector(MoreList), for: .touchUpInside)
        rightButton.backgroundColor = ColorHex("#ffeb86")
        self.view.addSubview(rightButton)
        DayLabel.frame = CGRect(x: Device.width / 2 - 35, y: 25, width: 70, height: 20)
        DayLabel.backgroundColor = ColorHex("#ffeb86")
        DayLabel.text = "今天"
        DayLabel.textAlignment = NSTextAlignment.center
        DayLabel.layer.masksToBounds = true
        DayLabel.layer.cornerRadius = 13
        self.view.addSubview(DayLabel)
        costLabel.text = "消费：";
        costLabel.frame = CGRect(x: Device.width + 254 * 1.15 / 3, y: 56 * 1.15 / 3, width: 50, height: 56 * 1.15 / 3)
        self.view.addSubview(costLabel)
        rechargeLabel.text = "充值：";
        rechargeLabel.frame = CGRect(x: Device.width + 400 * 1.15 / 3, y: 56 * 1.15 / 3, width: 50, height: 56 * 1.15 / 3)
        self.view.addSubview(rechargeLabel)
        
        cost = UILabel(frame:CGRect(x: Device.width + 30 * 1.15, y: 350, width: Device.width * 4 / 5, height: 20))
        cost.text = "消费占比"
        cost.font = UIFont.flexibleSystemFont(ofSize: 19)
        self.view.addSubview(cost)
    
        messCostFront.frame = CGRect(x: Device.width + 85 * 1.15 / 3, y: cost.frame.maxY + 49 * 1.15 / 3, width: 10, height: 10)
        messCostFront.backgroundColor = ColorHex("#f8d316")
        messCostFront.layer.cornerRadius = messCostFront.bounds.size.width / 2
        self.view.addSubview(messCostFront)
        
        messCost.frame = CGRect(x: messCostFront.frame.maxX + 2, y: messCostFront.frame.minY, width: 60, height: 10)
        messCost.backgroundColor = .white
        messCost.text = "食堂： "
        messCost.font = UIFont.flexibleSystemFont(ofSize: 10)
        self.view.addSubview(messCost)
        
        marketCostFront.frame = CGRect(x: messCost.frame.maxX + 63 * 1.15 / 3 , y: cost.frame.maxY + 49 * 1.15 / 3, width: 10, height: 10)
        marketCostFront.backgroundColor = ColorHex("#fff5c2")
        marketCostFront.layer.cornerRadius = messCostFront.bounds.size.width / 2
        self.view.addSubview(marketCostFront)
        
        marketCost.frame = CGRect(x: marketCostFront.frame.maxX + 2, y: cost.frame.maxY + 49 * 1.15 / 3, width: 60, height: 10)
        marketCost.backgroundColor = .white
        marketCost.text = "超市： "
        marketCost.font = UIFont.flexibleSystemFont(ofSize: 10)
        self.view.addSubview(marketCost)
        
        otherCostFront.frame = CGRect(x: marketCost.frame.maxX + 63 * 1.15 / 3 , y: cost.frame.maxY + 49 * 1.15 / 3, width: 10, height: 10)
        otherCostFront.backgroundColor = ColorHex("#ffeb86")
        otherCostFront.layer.cornerRadius = otherCostFront.bounds.size.width / 2
        self.view.addSubview(otherCostFront)
        
        otherCost.frame = CGRect(x: otherCostFront.frame.maxX + 2, y: cost.frame.maxY + 49 * 1.15 / 3, width: 60, height: 10)
        otherCost.backgroundColor = .white
        otherCost.text = "其他： "
        otherCost.font = UIFont.flexibleSystemFont(ofSize: 10)
        self.view.addSubview(otherCost)
        
//        dateScrollViewRightLabel.frame = CGRect(x: dateScrollerView.frame.maxX + 3, y: dateScrollerView.frame.minY, width: 10, height: dateScrollerView.frame.height)
//        dateScrollViewRightLabel.text = "日"
//        dateScrollViewRightLabel.backgroundColor = .white
//        self.view.addSubview(dateScrollViewRightLabel)
//        
//        dateScrollViewLeftLabel.frame = CGRect(x: dateScrollerView.frame.minX - 1, y: dateScrollerView.frame.minY, width: 10, height: dateScrollerView.frame.height)
//        dateScrollViewLeftLabel.text = "\(lintchart.data2[lintchart.data2.count - Figure.term - 1].date[String.Index(encodedOffset: 4)])\(lintchart.data2[lintchart.data2.count - Figure.term - 1].date[String.Index(encodedOffset: 5)])月"
    }
    func addDateLabel() {
        Figure.term = 6
        loadData()
        for i in 0...Figure.term {
            let dateLabel = UILabel(frame: CGRect(x: (CGFloat(i + 1) *   lineScrollerLength / CGFloat(Figure.term + 2)), y: 2, width: lineScrollerLength, height: 40))
//            dateLabel.text = self.datetext[i]
            //            dateLabel.text = "14"
            self.dateview.addSubview(dateLabel)
            dateArray.append(dateLabel)
        }
    }
    //很多scrollerview
    func addScrollerView() {
        scrollerview = UIScrollView(frame: CGRect(x: 0, y: 57, width: Device.width, height: Device.height * 2 / 3))
        scrollerview.isPagingEnabled = true
        scrollerview.backgroundColor = .white
        scrollerview.showsHorizontalScrollIndicator = true
        scrollerview.contentSize = CGSize(width: Device.width*2,height: Device.height )
        scrollerview.contentOffset = CGPoint(x: 0, y: 0.0)
        scrollerview.delegate = self
        scrollerview.bounces = true
        
        lineScrollerView = UIScrollView(frame:CGRect(x: Device.width + 85 * 1.15 / 3 + 10, y: 145 * 1.15 / 3, width: 797 * 1.15 / 3, height: 623 * 1.15 / 3))
        lineScrollerView.isPagingEnabled = true
        lineScrollerView.backgroundColor = .white
        lineScrollerView.showsHorizontalScrollIndicator = true
        lineScrollerView.showsVerticalScrollIndicator = false
        lineScrollerView.contentSize = CGSize(width: lineScrollerLength, height: 623 * 1.15 / 3)
        lineScrollerView.contentOffset = CGPoint(x: 0, y: 0)
        lineScrollerView.delegate = self
        lineScrollerView.bounces = true
        //FIXME: - 下挪 高度变小
        dateScrollerView = UIScrollView(frame: CGRect(x: Device.width + 85 * 1.15 / 3 + 10, y: AccountlineChartView.frame.maxY + 40, width: 797 * 1.15 / 3, height: 623 * 1.15 / 3))
        dateScrollerView.isPagingEnabled = true
        dateScrollerView.backgroundColor = .white
        dateScrollerView.contentSize = CGSize(width: lineScrollerLength, height: 40)
        dateScrollerView.contentOffset = CGPoint(x: 0, y: 0)
        dateScrollerView.delegate = self
        dateScrollerView.bounces = false
        //FIXME: - 这两个宽度变窄
        slideBackView = UIView(frame: CGRect(x: lineScrollerView.frame.minX, y: lineScrollerView.frame.maxY, width: AccountlineChartView.frame.width, height: 8))
        slideBackView.backgroundColor = UIColor.gray
        slideBackView.layer.cornerRadius = 4
        
        slideView = UIView(frame: CGRect(x: lineScrollerView.frame.minX, y: lineScrollerView.frame.maxY, width: AccountlineChartView.frame.width, height: 8))
        slideView.backgroundColor = UIColor.yellow
        slideView.layer.cornerRadius = 3.5
        
        self.scrollerview.addSubview(accountTableview)
        self.scrollerview.addSubview(cost)
        self.scrollerview.addSubview(slideView)
        self.scrollerview.addSubview(slideBackView)
        self.lineScrollerView.addSubview(AccountlineChartView)
        self.scrollerview.addSubview(lineScrollerView)
        self.dateScrollerView.addSubview(dateview)
        self.scrollerview.addSubview(dateScrollerView)
        self.view.addSubview(scrollerview)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        UIView.animate(withDuration: 0.5, animations: {
            
            let offset: CGPoint = scrollView.contentOffset
            
            var frame: CGRect = self.slideView.frame
            
            frame.origin.x = 15 + offset.x * (self.slideBackView.frame.size.width - self.slideView.frame.size.width) / (scrollView.contentSize.width - scrollView.frame.size.width)
            
            self.slideView.frame = frame
        })
    }

    func LabelScale(_ firstLabel: inout UILabel, _ secondLabel: inout UILabel, _ thirdLabel: inout UILabel, _ firstData: Double, _ secondData: Double, _ thirdData: Double, _ rect: CGRect) {
        let totalData: Double = firstData + secondData + thirdData
        let firstWidth = rect.size.width * CGFloat(firstData / totalData)
        let secondWidth = rect.size.width * CGFloat(secondData / totalData)
        let thirdWidth = rect.size.width * CGFloat(thirdData / totalData)
        let minx = rect.minX
        let miny = rect.minY
        
        firstLabel = UILabel(frame: CGRect(x: minx, y: miny, width: firstWidth, height: 56))
        firstLabel.text = String(firstData/totalData) + "%"
        firstLabel.textColor = .black
        firstLabel.textAlignment = NSTextAlignment.center
        firstLabel.backgroundColor = .white
        let leftbezierPath = UIBezierPath(roundedRect: firstLabel.bounds, byRoundingCorners: [.bottomLeft,.topLeft], cornerRadii: CGSize(width: 28, height: 28))
        let leftshape: CAShapeLayer = CAShapeLayer()
        firstLabel.layer.mask = leftshape
        leftshape.fillColor = ColorHex("#f8d316")?.cgColor
        leftshape.path = leftbezierPath.cgPath
        leftshape.frame = firstLabel.bounds
        firstLabel.layer.addSublayer(leftshape)
        llabel = UILabel(frame: CGRect(x: minx + firstWidth / 4, y: miny, width: 3 * firstWidth / 4, height: 56))
        let temptext: String = String(100 * firstData / totalData)
        llabel.text = temptext.prefix(4) + "%"
        llabel.textColor = UIColor.black
        llabel.layer.borderColor = ColorHex("#f8d316")?.cgColor
        llabel.backgroundColor = ColorHex("#f8d316")
        secondLabel = UILabel(frame: CGRect(x: firstLabel.frame.maxX, y: miny, width: secondWidth, height: 56))
        secondLabel.text = String(secondData/totalData) + "%"
        secondLabel.textAlignment = NSTextAlignment.center
        secondLabel.backgroundColor = ColorHex("#fff5c2")
        
        thirdLabel = UILabel(frame: CGRect(x: secondLabel.frame.maxX, y: miny, width: thirdWidth, height: 56))
        thirdLabel.text = String(thirdData/totalData) + "%"
        thirdLabel.textAlignment = NSTextAlignment.center
        thirdLabel.backgroundColor = ColorHex("ffeb86")
        let rightbezierPath = UIBezierPath(roundedRect: thirdLabel.bounds, byRoundingCorners: [.bottomRight,.topRight], cornerRadii: CGSize(width: 28, height: 28))
        let rightshape: CAShapeLayer = CAShapeLayer()
        rightshape.fillColor = firstLabel.backgroundColor?.cgColor
        rightshape.path = rightbezierPath.cgPath
        rightshape.frame = thirdLabel.bounds
        thirdLabel.layer.addSublayer(rightshape)
    }
    
    private let AccountlineChartView: LineChartView = {
        let accountLineChartView = LineChartView()
        accountLineChartView.dragEnabled = false
        for gesture in accountLineChartView.gestureRecognizers ?? [] where gesture is UIPinchGestureRecognizer {
            accountLineChartView.removeGestureRecognizer(gesture)
        }
        accountLineChartView.pinchZoomEnabled = false
        accountLineChartView.doubleTapToZoomEnabled = false
        accountLineChartView.drawGridBackgroundEnabled = false
        accountLineChartView.leftAxis.drawGridLinesEnabled = false
        accountLineChartView.xAxis.drawLabelsEnabled = false
        accountLineChartView.leftAxis.drawLabelsEnabled = false
        accountLineChartView.rightAxis.enabled = false
        accountLineChartView.xAxis.drawGridLinesEnabled = false
        // -1 for the fucking top border
        accountLineChartView.setViewPortOffsets(left: 0, top: -1, right: 0, bottom: 0)
        accountLineChartView.setExtraOffsets(left: 0, top: -1, right: 0, bottom: 0)
        accountLineChartView.chartDescription = nil
        accountLineChartView.drawBordersEnabled = false
        accountLineChartView.borderLineWidth = 0
        accountLineChartView.isUserInteractionEnabled = true
        accountLineChartView.borderColor = .white
        accountLineChartView.legend.enabled = false
        accountLineChartView.noDataTextColor = .white
        accountLineChartView.noDataText = "暂无数据"
        accountLineChartView.noDataFont = NSUIFont.boldSystemFont(ofSize: 16)
        return accountLineChartView
    }()
    
    private func setupLineChartView() {
        var entrys = [ChartDataEntry]()
        //MARK: -测试的
        Figure.term = 6
//        var image = UIImage(named: "锚点")
//        image!.size = CGSize(width: 12, height: 12)
//        image?.resizableImage(withCapInsets: <#T##UIEdgeInsets#>)
        //FIXME: - 改大一些
        let image = UIImage.resizedImage(image: UIImage(named: "锚点")!, scaledToSize: CGSize(width: 20, height: 20))
        for index in 0...Figure.term  {
            let entry = ChartDataEntry(x: Double(index), y: Double(lintchart.data2[lintchart.data2.count - Figure.term - 1 + index].count) as! Double , icon: image )
            entrys.append(entry)
        }
        
        if !entrys.isEmpty {
            let fakeLastEntry = ChartDataEntry(x: Double(entrys.count+1), y: entrys[entrys.count-1].y)
            entrys.append(fakeLastEntry)
            let fakeFirstEntry = ChartDataEntry(x: -2, y: entrys[0].y)
            entrys.insert(fakeFirstEntry, at: 0)
        }
        
        let dataSet = LineChartDataSet(values: entrys, label: nil)
        dataSet.mode = .cubicBezier
        dataSet.drawCirclesEnabled = true
//        dataSet.circleRadius = 10
//
////            dataSet.setCircleColor(ColorHex("#ffe043")!)
//        dataSet.setCircleColor(ColorHex("#ffe043")!)
        
//        dataSet.setCircleColors(<#T##colors: NSUIColor...##NSUIColor#>)
        dataSet.drawValuesEnabled = false
        dataSet.drawCircleHoleEnabled = false
        dataSet.drawFilledEnabled = true
        dataSet.setDrawHighlightIndicators(false)
        dataSet.fillColor = ColorHex("#ffeb86")!
        dataSet.fillAlpha = 1
        dataSet.lineWidth = 2
        dataSet.setColor(ColorHex("#ffe043")!)
        AccountlineChartView.data = LineChartData(dataSet: dataSet)
        AccountlineChartView.zoomOut()
        AccountlineChartView.zoomToCenter(scaleX: 1.2, scaleY: 1)
    }
    
    
    //刷新
    func refreshData() {
        guard isRefreshing == false else {
            return
        }

        isRefreshing = true
        GetConsumeHelper.GetConsume(success: { tuenover in
            self.isRefreshing = false
            self.tuenover = tuenover
            SwiftMessages.hideLoading()
            self.accountTableview.reloadData()
        }, failure: { _ in
            self.isRefreshing = false
            
        })
        
        LintChartHelper.getLintChart(success: { lintchart in
            self.isRefreshing = false
            self.lintchart = lintchart
            SwiftMessages.hideLoading()
            self.setupLineChartView()
        }, failure: { _ in
            
        })
    }
    
    func loadData() {
        GetConsumeHelper.GetConsume(success: { tuenover in
            self.tuenover = tuenover
            self.accountTableview.reloadData()
        }, failure: { _ in
            
        })
        
        LintChartHelper.getLintChart(success: { lintchart in
            self.lintchart = lintchart
            Figure.term = 6
            for i in 0...6 {
                log(i)
//                self.datetext[i] = String(lintchart.data2[lintchart.data2.count - Figure.term - 1 + i].date.suffix(2))
                log(i)
            }
            self.setupLineChartView()
        }, failure: { _ in
            
        })
    }
    // 三角形button的方法
    func TriangleButtun() {
        switch InitialNum {
        case 0:
            Figure.term = 6
            refreshData()
            DayLabel.text = "最近7天"
            leftButton.backgroundColor = UIColor.gray
            leftButton.isEnabled = false
            rightButton.backgroundColor = ColorHex("#ffeb86")
            rightButton.isEnabled = true
            break
        case 1:
            Figure.term = 14
            refreshData()
            DayLabel.text = "最近15天"
            leftButton.backgroundColor = ColorHex("#ffeb86")
            leftButton.isEnabled = true
            rightButton.backgroundColor = ColorHex("#ffeb86")
            rightButton.isEnabled = true
            break
        case 2:
            Figure.term = 29
            refreshData()
            DayLabel.text = "最近30天"
            leftButton.backgroundColor = ColorHex("#ffeb86")
            leftButton.isEnabled = true
            rightButton.backgroundColor = ColorHex("#ffeb86")
            rightButton.isEnabled = true
            break
        default:
            Figure.term = 59
            refreshData()
            DayLabel.text = "最近60天"
            leftButton.backgroundColor = ColorHex("#ffeb86")
            leftButton.isEnabled = true
            rightButton.backgroundColor = UIColor.gray
            rightButton.isEnabled = false
            break
        }
    }
}

extension AccountViewController {
    @objc func Refresh() {
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

extension AccountViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tuenover == nil {return AccountViewCell()}
        return AccountViewCell(byModel: tuenover, withIndex: indexPath.row)
    }
}

extension AccountViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tuenover == nil { return 0 }
        return tuenover.data.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

extension AccountViewController: ChartViewDelegate {
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        guard entry.x > -1 && entry.x < Double(lintchart.data2.count) else {
            return
        }
        
        lastSelect = Int(entry.x)
        
        let moneynum = tuenover.data[lastSelect].amount
        
        if let dataSets = chartView.data?.dataSets, dataSets.count > 1 {
            _ = dataSets[1].removeFirst()
            _ = dataSets[1].addEntry(entry)
        } else {
            // add another dataSet for the only selected entry
            let dataSetSelected = LineChartDataSet(values: [entry], label: nil)
//            dataSetSelected.circleRadius = 16
//            dataSetSelected.drawValuesEnabled = false
//            dataSetSelected.circleHoleColor = ColorHex("#ffe043")
//            dataSetSelected.drawCircleHoleEnabled = true
            dataSetSelected.circleRadius = 11
            dataSetSelected.drawValuesEnabled = false
            dataSetSelected.circleHoleColor = ColorHex("#fff9da")
            dataSetSelected.drawCircleHoleEnabled = true
            dataSetSelected.circleHoleRadius = 8
            dataSetSelected.drawValuesEnabled = false
            dataSetSelected.circleHoleColor = ColorHex("#ffe043")
            dataSetSelected.drawCircleHoleEnabled = true
            chartView.data?.dataSets.append(dataSetSelected)
        }
        
        for view in chartView.subviews {
            view.removeFromSuperview()
        }
        
        let point = AccountlineChartView.getTransformer(forAxis: AccountlineChartView.data!.dataSets[0].axisDependency).pixelForValues(x: entry.x, y: entry.y)
        let image = UIImage(named: "bubble")!
        let bubbleView = UIImageView(image: image)
        bubbleView.width = 115
        bubbleView.height = 115
        bubbleView.y = point.y + 10
        bubbleView.center.x = point.x
        bubbleView.contentMode = .scaleToFill
        var upsidedownOffset: CGFloat = 0
        
        if bubbleView.y + bubbleView.height > 200 {
            let revertedImage = UIImage(cgImage: image.cgImage!, scale: 1, orientation: UIImageOrientation.downMirrored)
            bubbleView.image = revertedImage
            bubbleView.y -= bubbleView.height + 10 + 10
            upsidedownOffset = -10
        }
        
        let moneyLabel = UILabel(text: moneynum, color: .black, fontSize: 12)
        moneyLabel.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.thin)
        moneyLabel.frame = CGRect(x: 21.5, y: 32.5 + upsidedownOffset, width: 125, height: 20)
        bubbleView.addSubview(moneyLabel)
        
        bubbleView.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
        UIView.animate(withDuration: 0.2, delay: 0.1, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: [], animations: {
            bubbleView.transform = CGAffineTransform(scaleX: 1, y: 1)
            chartView.addSubview(bubbleView)
        }, completion: nil)
    }
}
