//
//  DLFLoginStruct.swift
//  Skeleton
//
//  Created by Harsh Tiwari on 09/06/23.
//

import Foundation

struct DLFLoginStruct :Decodable{
    let m_system_status_code: String
    let m_system_status_message: String
    let m_app_response: [MResponseData]
}
struct MResponseData :Decodable{
    let m_response_data: String?
    let m_app_status_code: Int
    let m_app_status_msg: String?
}
