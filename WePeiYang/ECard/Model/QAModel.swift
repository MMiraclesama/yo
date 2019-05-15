//
//  QAModel.swift
//  WePeiYang
//
//  Created by 安宇 on 06/04/2019.
//  Copyright © 2019 twtstudio. All rights reserved.
//

import Foundation
import Alamofire

struct QAHelper {
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
struct GetQAHelper {
    static func getQA(success: @escaping (QAInformation)->(), failure: @escaping (Error)->()) {
        SolaSessionManager.solaSession(type: .get, url: "/ecard/QA", parameters: nil, success: { dic in
            if let data = try? JSONSerialization.data(withJSONObject: dic, options: JSONSerialization.WritingOptions.init(rawValue: 0)), let detail = try? QAInformation(data: data) {
                success(detail)
            }
        }, failure: { _ in
            
        })
    }
}

struct QAInformation: Codable {
    let errorCode: Int
    let message: String
    let data: [QAElement]
    
    enum CodingKeys: String, CodingKey {
        case errorCode = "error_code"
        case message, data
    }
}

struct QAElement: Codable {
    let id: Int
    let date, title, content: String
}

// MARK: Convenience initializers and mutators

extension QAInformation {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(QAInformation.self, from: data)
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
        data: [QAElement]? = nil
        ) -> QAInformation {
        return QAInformation(
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

extension QAElement {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(QAElement.self, from: data)
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
        ) -> QAElement {
        return QAElement(
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
