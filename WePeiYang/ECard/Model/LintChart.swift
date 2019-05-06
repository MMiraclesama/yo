//
//  LintChart.swift
//  WePeiYang
//
//  Created by 王申宇 on 2019/3/24.
//  Copyright © 2019 twtstudio. All rights reserved.
//

import Foundation

struct LintChart: Codable {
    let errorcode: Int
    let message: String
    let data2: [Data2]
    
    enum CodingKeys: String, CodingKey {
        case errorcode = "error_code"
        case message
        case data2 = "data"
    }
}

struct Data2: Codable {
    let date: String
    let count: String
    
    enum CodingKeys: String, CodingKey {
        case date, count
    }
}

extension LintChart {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(LintChart.self, from: data)
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
        data2: [Data2]? = nil
        ) -> LintChart {
        return LintChart(
            errorcode: errorcode ?? self.errorcode,
            message: message ?? self.message,
            data2: data2 ?? self.data2
        )
    }
    
    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}


extension Data2 {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Data2.self, from: data)
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
        count: String? = nil
        ) -> Data2 {
        return Data2(
            date: date ?? self.date,
            count: count ?? self.count
        )
    }
    
    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}
