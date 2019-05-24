//
//  SaveSearchingModel.swift
//  WePeiYang
//
//  Created by 安宇 on 24/03/2019.
//  Copyright © 2019 twtstudio. All rights reserved.
//

import Foundation
import Alamofire

struct SaveHelper {
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
struct GetSaveHelper {
    static func GetIt(success: @escaping (DetailInformation)->(), failure: @escaping (Error)->()) {
//        https://open.twtstudio.com/api/v1/ecard/profile?cardnum=3010000000&password=666666
        SolaSessionManager.solaSession(type: .get, url: "/ecard/profile", parameters: ["cardnum": TWTKeychain.username(for: .ecard)!, "password": TWTKeychain.password(for: .ecard)!], success: {
        dic in
        if let data = try? JSONSerialization.data(withJSONObject: dic, options: JSONSerialization.WritingOptions.init(rawValue: 0)), let detail = try? DetailInformation(data: data) {
            
            success(detail)
        }
    }, failure: { _ in
        
    })
}
}

struct DetailInformation: Codable {
    let errorCode: Int
    let message: String
    let data: DataClass
    
    enum CodingKeys: String, CodingKey {
        case errorCode = "error_code"
        case message, data
    }
}

struct DataClass: Codable {
    let name, cardnum, cardstatus, balance: String
    let expiry, subsidy, amount: String
}

// MARK: Convenience initializers and mutators

extension DetailInformation {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(DetailInformation.self, from: data)
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
        data: DataClass? = nil
        ) -> DetailInformation {
        return DetailInformation(
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

extension DataClass {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(DataClass.self, from: data)
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
        name: String? = nil,
        cardnum: String? = nil,
        cardstatus: String? = nil,
        balance: String? = nil,
        expiry: String? = nil,
        subsidy: String? = nil,
        amount: String? = nil
        ) -> DataClass {
        return DataClass(
            name: name ?? self.name,
            cardnum: cardnum ?? self.cardnum,
            cardstatus: cardstatus ?? self.cardstatus,
            balance: balance ?? self.balance,
            expiry: expiry ?? self.expiry,
            subsidy: subsidy ?? self.subsidy,
            amount: amount ?? self.amount
        )
    }
    
    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}
