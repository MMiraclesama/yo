//
//  ActivityDetailModel.swift
//  WePeiYang
//
//  Created by 安宇 on 24/08/2019.
//  Copyright © 2019 twtstudio. All rights reserved.
//

import Foundation

// MARK: - ActivityDeatilModel
struct ActivityDeatilModel: Codable {
    let message: String
    let errorCode: Int
    let data: [ActivityDetail]
    
    enum CodingKeys: String, CodingKey {
        case message
        case errorCode = "error_code"
        case data
    }
}

// MARK: ActivityDeatilModel convenience initializers and mutators

extension ActivityDeatilModel {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(ActivityDeatilModel.self, from: data)
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
        message: String? = nil,
        errorCode: Int? = nil,
        data: [ActivityDetail]? = nil
        ) -> ActivityDeatilModel {
        return ActivityDeatilModel(
            message: message ?? self.message,
            errorCode: errorCode ?? self.errorCode,
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

// MARK: - Datum
struct ActivityDetail: Codable {
    let activityID: Int
    let title, content, start, end: String
    let position, teacher: String
    let manager: [String]
//    let numberOfManager: Int
//    let currentPage, lastPage, numberOfCurrentPage: Int?
    
    enum CodingKeys: String, CodingKey {
        case activityID = "activity_id"
        case title, content, start, end, position, teacher, manager
    }
}

// MARK: Datum convenience initializers and mutators

extension ActivityDetail {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(ActivityDetail.self, from: data)
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
        activityID: Int? = nil,
        title: String? = nil,
        content: String? = nil,
        start: String? = nil,
        end: String? = nil,
        position: String? = nil,
        teacher: String? = nil,
        manager: [String]? = nil
        ) -> ActivityDetail {
        return ActivityDetail(
            activityID: activityID ?? self.activityID,
            title: title ?? self.title,
            content: content ?? self.content,
            start: start ?? self.start,
            end: end ?? self.end,
            position: position ?? self.position,
            teacher: teacher ?? self.teacher,
            manager: manager ?? self.manager
        )
    }
    
    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}
