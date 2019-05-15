//
//  MoneyTest.swift
//  WePeiYang
//
//  Created by 王申宇 on 2019/5/9.
//  Copyright © 2019 twtstudio. All rights reserved.
//

import Foundation

var t = 0
class MoneyTest {
    var ConsumeDetail: ConsumeDetail!
    var sum1 = 0.0
    var sum2 = 0.0
    var sum3 = 0.0
    var sum4 = 0.0
    
    func GetTotal() -> Int {
        GetConsumeHelper.GetConsume(success: { ConsumeDetail in
            self.ConsumeDetail = ConsumeDetail
            //            Mark:30为term对应的具体数目
            for i in 0..<ConsumeDetail.data.count {
                if(ConsumeDetail.data[i].subtype == "其他") {
                    self.sum1 += Double(ConsumeDetail.data[i].amount)!
                } else if(ConsumeDetail.data[i].subtype == "超市") {
                    self.sum2 += Double(ConsumeDetail.data[i].amount)!
                } else if(ConsumeDetail.data[i].subtype == "食堂"){
                    self.sum3 += Double(ConsumeDetail.data[i].amount)!
                } else {
                    self.sum4 += Double(ConsumeDetail.data[i].amount)!
                }
            }
            num1 = self.sum1
            num2 = self.sum2
            num3 = self.sum3
            num4 = self.sum4
            self.sum1 = 0.0
            self.sum2 = 0.0
            self.sum3 = 0.0
            self.sum4 = 0.0
            t = 1
        }, failure: { _ in
            
        })
        return 1
    }
}
