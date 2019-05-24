//
//  ECardHelper.swift
//  WePeiYang
//
//  Created by 王申宇 on 2019/3/24.
//  Copyright © 2019 twtstudio. All rights reserved.
//

import Foundation
import Alamofire

let TurnoverUrl = "/ecard/turnover"
let LintChartUrl = "/ecard/lineChart"



struct ECardHelper {
    static func dataCard(url: String, success: (([String: Any])->())? = nil, failure: ((Error)->())? = nil) {
        Alamofire.request(url).responseJSON { response in
            switch response.result {
            case .success:
                if let data = response.result.value  {
                    if let dict = data as? [String: Any] {
                        success?(dict)
                    }
                }
            case .failure(let error):
                failure?(error)
                if let data = response.result.value  {
                    if let dict = data as? [String: Any],
                        let errmsg = dict["music"] as? String {
                        print(errmsg)
                    }
                } else {
                    print(error)
                }
            }
        }
    }
}

struct GetConsumeHelper {
    static func GetConsume(success: @escaping (ConsumeDetail) -> Void, failure: @escaping (Error) -> Void) {
        var error: Error?
        guard let username = TWTKeychain.username(for: .ecard),
            let password = TWTKeychain.password(for: .ecard) else {
                error = WPYCustomError.custom("请先绑定校园卡")
//                callback([], error)
                return
        }
        SolaSessionManager.solaSession(type: .get, url: TurnoverUrl, parameters: ["cardnum": username, "password": password, "term": "\(Figure.term)"], success: { dic in
            if let data = try? JSONSerialization.data(withJSONObject: dic, options: JSONSerialization.WritingOptions.init(rawValue: 0)),
                let tuenover = try? ConsumeDetail(data: data) {
                success(tuenover)
            }
        }, failure: { error in
            failure(error)
        })
    }
}

struct LintChartHelper {
    static func getLintChart(success: @escaping (LintChart) -> Void, failure: @escaping (Error) -> Void) {
        SolaSessionManager.solaSession(type: .get, url: LintChartUrl, parameters: ["cardnum": TWTKeychain.username(for: .ecard)!, "password": TWTKeychain.password(for: .ecard)!], success: { dic in
            if let data = try? JSONSerialization.data(withJSONObject: dic, options: JSONSerialization.WritingOptions.init(rawValue: 0)),
                let lintchart = try? LintChart(data: data) {
                success(lintchart)
            }
        }, failure: { error in
            failure(error)
        })
    }
}


struct Figure {
    static var cardnum = 0
    static var pwd = 0
    static var term = 0
}



