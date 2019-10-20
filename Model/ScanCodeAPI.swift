//
//  ScanCodeAPI.swift
//  WePeiYang
//
//  Created by 安宇 on 24/08/2019.
//  Copyright © 2019 twtstudio. All rights reserved.
//

import Foundation
import Alamofire

struct ScanCodeAPI {
    
    static let root = " https://activity.twtstudio.com"
    
    static let activityDetail = "/api/activity/index"
//    ?method=0&page=0&limit=0&user_id=3018216126
//    method传入0表示正在进行的活动，传入1表示已完成活动，传入2如果是管理员返回我管理的活动
//    page页数，从1开始
//    limit每页最大活动数
//    static let found = "/found"
//
//    static let search = "/search"
//
//    static let user = "/user"
    
}
struct DetailHelper {
    static func dataManager(url: String, success: (([String: Any])->())? = nil, failure: ((Error)->())? = nil) {
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
                        let errmsg = dict["message"] as? String {
                        print(errmsg)
                    }
                } else {
                    print(error)
                }
            }
        }
    }
}

struct ActivityDetailHelper {
    static func getActivities(success: @escaping (ActivityDeatilModel)->(), failure: @escaping (Error)->()) {
        DetailHelper.dataManager(url: ScanCodeAPI.root + ScanCodeAPI.activityDetail + "?method=0&page=0&limit=999&user_id=\(TwTUser.shared.schoolID!)", success: { dic in
            if let data = try? JSONSerialization.data(withJSONObject: dic, options: JSONSerialization.WritingOptions.init(rawValue: 0)), let acDetail = try? ActivityDeatilModel(data: data) {
                success(acDetail)
            }
        }, failure: { _ in
            
        })
    }
}
