//
//  ApiInteractor.swift
//  ApiInteractor
//
//  Created by Vansh Dubey on 08/06/23.
//

import Foundation
import UIKit
import Alamofire

enum ErrorHandling: Error {
    case ServerException
    case NoConnection
    case NotAuthorized
    case ConnectionFailed(statusCode: Int)
    case SerializationFailed
}

enum UrlPath: String{
    case resendOtp = "/auth/m_otplogin"
    case otpVerify = "/auth/m_otp_verify"
    case login = "/auth/m_login"
    case clubList = "/community_v2/m_get_dashboard_static_data"
    
}

enum Methods : String{
    case post = "POST"
    case get = "GET"
    case delete = "DELETE"
    case put = "PUT"
}

class ApiInteractor{
    
    let BaseUrl: String = "https://dlf-staging.apnacomplex.com"
    var headers: HTTPHeaders? = [:]
    var params: [String: NSObject]? = [:]
    
    private func getRequestUrl(urlPath: UrlPath)->URL{
        return URL(string: BaseUrl+urlPath.rawValue)!
    }
    
    func request(urlpath: UrlPath, method : Methods)->URLRequest{
        let requestedUrl = self.getRequestUrl(urlPath: urlpath)
        var request = URLRequest(url: requestedUrl)
        request.httpMethod = method.rawValue
        return request
    }
    
    func fetchData(_url: URLRequest, completion: @escaping(Result<NSDictionary, ErrorHandling>) -> Void) {
        AF.request(_url.url!, parameters: self.params, headers: self.headers).responseData { response in
            switch response.result {
            case .success(let data):
                if let statusCode = response.response?.statusCode {
                    switch statusCode {
                    case 200:
                        do{
                            let jsonObject = try JSONSerialization.jsonObject(with: data)
                            completion(.success(jsonObject as! NSDictionary))
                        } catch {
                            completion(.failure(.SerializationFailed))
                        }
                    case 401:
                        completion(.failure(.ConnectionFailed(statusCode: 401)))
                    case 500:
                        completion(.failure(.ConnectionFailed(statusCode: 500)))
                    default:
                        completion(.failure(.ConnectionFailed(statusCode: statusCode)))
                    }
                }
                else {
                    completion(.failure(.ConnectionFailed(statusCode: -1)))
                }
            case .failure(let error):
                let nsError = error as NSError
                switch nsError.code {
                case NSURLErrorBadServerResponse:
                    completion(.failure(.ServerException))
                case NSURLErrorNotConnectedToInternet:
                    completion(.failure(.NoConnection))
                case NSURLErrorUserAuthenticationRequired:
                    completion(.failure(.NotAuthorized))
                default:
                    completion(.failure(.ConnectionFailed(statusCode: -1)))
                }
            }
        }
    }
    
    
}
