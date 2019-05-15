//
//  DynamicModel.swift
//  WePeiYang
//
//  Created by 安宇 on 06/04/2019.
//  Copyright © 2019 twtstudio. All rights reserved.
//

import Foundation
import Alamofire

struct DynamicHelper {
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
struct GetDynamicHelper {
    static func getDynamic(success: @escaping (DynamicInformation)->(), failure: @escaping (Error)->()) {
        SolaSessionManager.solaSession(type: .get, url: "/ecard/dynamic", parameters: nil, success: { dic in
            if let data = try? JSONSerialization.data(withJSONObject: dic, options: JSONSerialization.WritingOptions.init(rawValue: 0)), let detail = try? DynamicInformation(data: data) {
                success(detail)
            }
        }, failure: { _ in
            
        })
    }
}

import Foundation

struct DynamicInformation: Codable {
    let errorCode: Int
    let message: String
    let data: [Dynamic]
    
    enum CodingKeys: String, CodingKey {
        case errorCode = "error_code"
        case message, data
    }
}

struct Dynamic: Codable {
    let id: Int
    let date, title, content: String
}

// MARK: Convenience initializers and mutators

extension DynamicInformation {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(DynamicInformation.self, from: data)
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
        data: [Dynamic]? = nil
        ) -> DynamicInformation {
        return DynamicInformation(
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

extension Dynamic {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Dynamic.self, from: data)
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
        id: Int? = nil,
        date: String? = nil,
        title: String? = nil,
        content: String? = nil
        ) -> Dynamic {
        return Dynamic(
            id: id ?? self.id,
            date: date ?? self.date,
            title: title ?? self.title,
            content: content ?? self.content
        )
    }
    
    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}
