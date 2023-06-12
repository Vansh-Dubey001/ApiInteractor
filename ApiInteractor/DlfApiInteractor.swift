//
//  DLFLoginStruct.swift
//  Skeleton
//
//  Created by Harsh Tiwari on 09/06/23.
//

import Foundation

struct DlfApiInteractor: Decodable {
    let mSystemStatusCode:String
    let mSystemStatusMessage: String
    let mAppResponse: MAppResponse
    enum CodingKeys: String, CodingKey {
        case mSystemStatusCode = "m_system_status_code"
        case mSystemStatusMessage = "m_system_status_message"
        case mAppResponse = "m_app_response"
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.mSystemStatusCode = try container.decode(String.self, forKey: .mSystemStatusCode)
        self.mSystemStatusMessage = try container.decode(String.setlf, forKey: .mSystemStatusMessage)
        self.mAppResponse = try container.decode(MAppResponse.self, forKey: .mAppResponse)
    }
}

struct MAppResponse: Decodable {
    let mResponseData: String?
    let mAppStatusCode: Int
    let mAppStatusMsg: String?
    enum CodingKeys: String, CodingKey {
        case mResponseData = "m_response_data"
        case mAppStatusCode = "m_app_status_code"
        case mAppStatusMsg = "m_app_status_msg"
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.mResponseData = try container.decode(String?.self, forKey: .mResponseData)
        self.mAppStatusCode = try container.decode(Int.self, forKey: .mAppStatusCode)
        self.mAppStatusMsg = try container.decode(String?.self, forKey: .mAppStatusMsg)
    }
    
}

