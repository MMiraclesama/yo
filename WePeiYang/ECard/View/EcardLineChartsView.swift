//
//  EcardLineChartsView.swift
//  WePeiYang
//
//  Created by 王申宇 on 2019/5/9.
//  Copyright © 2019 twtstudio. All rights reserved.
//

import UIKit
import Charts

class EcardLineChartsView: UIView {
    var labels = [String]()
    var lastSelect: Int = 0
    var lintchart: LintChart!
    var tuenover: ConsumeDetail!
    var myentrys = [ChartDataEntry]()
    
    let AccountlineChartView: LineChartView = {
        let accountLineChartView = LineChartView()
        accountLineChartView.dragEnabled = false
        for gesture in accountLineChartView.gestureRecognizers ?? [] where gesture is UIPinchGestureRecognizer {
            accountLineChartView.removeGestureRecognizer(gesture)
        }
        accountLineChartView.pinchZoomEnabled = false
        accountLineChartView.doubleTapToZoomEnabled = false
        accountLineChartView.drawGridBackgroundEnabled = false
        accountLineChartView.leftAxis.drawGridLinesEnabled = false
        //MARK: - MAYBE
        accountLineChartView.xAxis.drawLabelsEnabled = true
        accountLineChartView.leftAxis.drawLabelsEnabled = false
        accountLineChartView.rightAxis.enabled = false
        accountLineChartView.xAxis.drawGridLinesEnabled = false
        // -1 for the fucking top border
        accountLineChartView.setViewPortOffsets(left: 0, top: -1, right: 0, bottom: 0)
        accountLineChartView.setExtraOffsets(left: 0, top: -1, right: 0, bottom: 0)
        accountLineChartView.chartDescription = nil
        accountLineChartView.drawBordersEnabled = true 
        accountLineChartView.borderLineWidth = 0
        accountLineChartView.borderColor = .white
        accountLineChartView.legend.enabled = false
        accountLineChartView.noDataTextColor = .white
        accountLineChartView.noDataText = "暂无数据"
        accountLineChartView.noDataFont = NSUIFont.boldSystemFont(ofSize: 16)
        return accountLineChartView
    }()
    
    func setupLineChartView() {
        var entrys = [ChartDataEntry]()
        //MARK: -测试的
        //FIXME: - 改大一些
        let image = UIImage.resizedImage(image: UIImage(named: "锚点")!, scaledToSize: CGSize(width: 20, height: 20))
        for index in 0...Figure.term  {
            let entry = ChartDataEntry(x: Double(index), y: Double(lintchart.data2[lintchart.data2.count - Figure.term - 1 + index].count) as! Double, icon: image )
            entrys.append(entry)
            
            myentrys.append(entry)
        }
        
        if !entrys.isEmpty {
            let fakeLastEntry = ChartDataEntry(x: Double(entrys.count+1), y: entrys[entrys.count-1].y)
            entrys.append(fakeLastEntry)
//            myentrys.append(fakeLastEntry)
            let fakeFirstEntry = ChartDataEntry(x: -2, y: entrys[0].y)
            entrys.insert(fakeFirstEntry, at: 0)
            myentrys.insert(fakeFirstEntry, at: 0)
        }
        let dataSet = LineChartDataSet(values: entrys, label: nil)
        dataSet.mode = .cubicBezier
        dataSet.drawCirclesEnabled = true
        dataSet.drawValuesEnabled = false
        dataSet.drawCircleHoleEnabled = false
        dataSet.drawFilledEnabled = true
        dataSet.setDrawHighlightIndicators(false)
        dataSet.fillColor = UIColor(hex6: 0xffeb86)
        dataSet.fillAlpha = 1
        dataSet.lineWidth = 2
        dataSet.setColor(UIColor(hex6: 0xffe043))
        AccountlineChartView.data = LineChartData(dataSet: dataSet)
//        AccountlineChartView.zoomOut()
        AccountlineChartView.zoomToCenter(scaleX: 1.2, scaleY: 1)
    }
    func initCharts() {
        let xAxis = AccountlineChartView.xAxis
        xAxis.labelPosition = XAxis.LabelPosition.bottom 
        xAxis.labelFont = UIFont.flexibleSystemFont(ofSize: 12)
        xAxis.labelTextColor = UIColor(hex6: 0xffd942)
//        IndexAxisValueFormatter(values: T##[String])
        xAxis.valueFormatter = ArrayIndexValueFormatter(labels: labels)
        xAxis.axisMinimum = -1
        xAxis.setLabelCount(labels.count, force: true)
        xAxis.labelCount = labels.count
//        xAxis.axisMaximum = Double(labels.count)
    }
}

extension EcardLineChartsView: ChartViewDelegate {
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
            let dataSetSelected = LineChartDataSet(values: [entry], label: labels[Int(entry.x)])
            dataSetSelected.circleRadius = 11
            dataSetSelected.drawValuesEnabled = false
            dataSetSelected.circleHoleColor = UIColor(hex6: 0xfff9da)
            dataSetSelected.drawCircleHoleEnabled = true
            dataSetSelected.circleHoleRadius = 8
            dataSetSelected.drawValuesEnabled = false
            dataSetSelected.circleHoleColor = UIColor(hex6: 0xffe043)
            dataSetSelected.drawCircleHoleEnabled = true
            chartView.data?.dataSets.append(dataSetSelected)
        }
        
        for view in chartView.subviews {
            view.removeFromSuperview()
        }
        
        let point = AccountlineChartView.getTransformer(forAxis: AccountlineChartView.data!.dataSets[0].axisDependency).pixelForValues(x: entry.x, y: entry.y)
        let image = UIImage(named: "bubble")!
        let bubbleView = UIImageView(image: image)
        bubbleView.width = 100
        bubbleView.height = 70
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
        moneyLabel.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.thin)
        moneyLabel.frame = CGRect(x: 22.5, y: 32.5 + upsidedownOffset, width: 125, height: 20)
        bubbleView.addSubview(moneyLabel)
        
        bubbleView.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
        UIView.animate(withDuration: 0.2, delay: 0.1, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: [], animations: {
            bubbleView.transform = CGAffineTransform(scaleX: 1, y: 1)
            chartView.addSubview(bubbleView)
        }, completion: nil)
    }
}

class ArrayIndexValueFormatter: IAxisValueFormatter {
    var labels = [String]()
    init(labels: [String]) {
        self.labels = labels
    }
    
    func stringForValue(_ value: Double,
                        axis: AxisBase?) -> String {
        let x = Int(value)
        return labels.count <= x ? "" : labels[x]
    }
}

