//
//  turnover.swift
//  WePeiYang
//
//  Created by 王申宇 on 2019/3/24.
//  Copyright © 2019 twtstudio. All rights reserved.
//

import Foundation

struct ConsumeDetail: Codable {
    let errorcode: Int
    let message: String
    let data: [Data1]
    
    enum CodingKeys: String, CodingKey {
        case errorcode = "error_code"
        case message
        case data = "data"
    }
}

struct Data1: Codable {
    let date: String
    let time: String
    let location: String
    let amount: String
    let balance: String
    let type: Int
    let subtype: String
    
    enum CodingKeys: String, CodingKey {
        case date, time, location, amount, balance, type
        case subtype = "sub_type"
    }
}

extension ConsumeDetail {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(ConsumeDetail.self, from: data)
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
        errorcode: Int? = nil,
        message: String? = nil,
        data: [Data1]? = nil
        ) -> ConsumeDetail {
        return ConsumeDetail(
            errorcode: errorcode ?? self.errorcode,
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

extension Data1 {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Data1.self, from: data)
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
        date: String? = nil,
        time: String? = nil,
        location: String? = nil,
        amount: String? = nil,
        balance: String? = nil,
        type: Int? = nil,
        subtype: String? = nil
        ) -> Data1 {
        return Data1(
            date: date ?? self.date,
            time: time ?? self.time,
            location: location ?? self.location,
            amount: amount ?? self.amount,
            balance: balance ?? self.balance,
            type: type ?? self.type,
            subtype: subtype ?? self.subtype
        )
    }
    
    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}
