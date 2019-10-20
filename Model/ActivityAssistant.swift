//
//  ActivityAssistant.swift
//  WePeiYang
//
//  Created by 安宇 on 20/08/2019.
//  Copyright © 2019 twtstudio. All rights reserved.
//

//import Foundation
//
//typealias ActivityTopModel = BaseResponse<[ActivityModel]>
//class ActivityAssistant {
//    static var activities: [ActivityModel] = []
//
//    private init() {}
////    FIXME:等后台接口改好了再改
//    static func getIt(success: @escaping () -> (), failure: @escaping (Error) -> ()) {
//        SolaSessionManager.solaSession(type: .get, url: "/examtable", token: nil, parameters: nil, success: { dic in
//            if let data = try? JSONSerialization.data(withJSONObject: dic, options: JSONSerialization.WritingOptions.init(rawValue: 0)),
//                let res = try? ExamTopModel(data: data) {
//                ExamAssistant.exams = res.data.sorted { a, b in
//                    return (a.date + a.arrange) < (b.date + b.arrange)
//                }
//                saveCache()
//                success()
//            } else {
//                failure(WPYCustomError.custom("数据解析错误"))
//            }
//        }, failure: { err in
//            failure(err)
//        })
//    }
//
//    /// <#Description#>
//    ///
//    /// - Parameters:
//    ///   - success: <#success description#>
//    ///   - failure: <#failure description#>
//    static func loadCache(success: @escaping () -> (), failure: @escaping (String) -> ()) {
//        CacheManager.retreive("examtable/exam.json", from: .group, as: [ExamModel].self, success: { exams in
//            ExamAssistant.exams = exams
//            success()
//        }, failure: {
//            failure("缓存加载失败")
//        })
//    }
//
//    static func saveCache() {
//        CacheManager.store(object: ExamAssistant.exams, in: .group, as: "examtable/exam.json")
//    }
//}
