//
//  ConsumeModel.swift
//  WePeiYang
//
//  Created by 安宇 on 24/03/2019.
//  Copyright © 2019 twtstudio. All rights reserved.
//

import Foundation
import Alamofire

struct DailyDetailHelper {
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
struct GetDailyDetailHelper {
    static func GetThat(success: @escaping (Consume)->(), failure: @escaping (Error)->()) {
        //        Mark:url有两个没有改
        SolaSessionManager.solaSession(type: .get, url: "/ecard/total", parameters: ["cardnum": TWTKeychain.username(for: .ecard)!, "password": TWTKeychain.password(for: .ecard)!], success: { dic in
    if let data = try? JSONSerialization.data(withJSONObject: dic, options: JSONSerialization.WritingOptions.init(rawValue: 0)), let detail = try? Consume(data: data) {
        success(detail)
    }
    }, failure: { _ in
    
    })
  }
}

struct Consume: Codable {
    let errorCode: Int
    let message: String
    let data: TotalConsume
    
    enum CodingKeys: String, CodingKey {
        case errorCode = "error_code"
        case message, data
    }
}

struct TotalConsume: Codable {
    let totalDay: Double
    let totalMonth: Double
    
    enum CodingKeys: String, CodingKey {
        case totalDay = "total_day"
        case totalMonth = "total_month"
    }
}

// MARK: Convenience initializers and mutators

extension Consume {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Consume.self, from: data)
    }
    
    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }
    
    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }
    
    func with(
        errorCode: Int? = nil,
        message: String? = nil,
        data: TotalConsume? = nil
        ) -> Consume {
        return Consume(
            errorCode: errorCode ?? self.errorCode,
            message: message ?? self.message,
            data: data ?? self.data
        )
    }
    
    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

extension TotalConsume {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(TotalConsume.self, from: data)
    }
    
    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }
    
    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }
    
    func with(
        totalDay: Double? = nil,
        totalMonth: Double? = nil
        ) -> TotalConsume {
        return TotalConsume(
            totalDay: totalDay ?? self.totalDay,
            totalMonth: totalMonth ?? self.totalMonth
        )
    }
    
    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}
