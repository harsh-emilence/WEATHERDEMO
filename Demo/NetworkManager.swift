//
//  NetworkManager.swift
//  Demo
//
//  Created by Zimble on 21/07/21.
//

import Foundation
import UIKit

enum HTTPMethod:String {
    case post = "POST"
    case get = "GET"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
    
    
    func getRawValue() -> String {
        return self.rawValue
    }
}

enum ApiName : String {
   case weatherApi = "https://api.openweathermap.org/data/2.5/weather?q=mohali&units=metric&appid=a5ff2f88f19156b8645663382d340687"
}

class NetworkManager:NSObject {
    static let shared = NetworkManager()
    
    
   
    var hudView:UIView!
    
    
    func sendAsyncRequestWith(withUrl url:String, withParam param: [String:Any]?, httpMethod requestType: HTTPMethod,showHud show:Bool?, fromController controller:UIViewController?, completionHandler:@escaping (_ status : Bool,_ data: [String : Any]?, _ message: String?) -> Void )  {
        
            
            let url = URL(string: "\(ApiName.weatherApi.rawValue)")
            
            guard let requestUrl = url else { fatalError() }
            
            
            var request = URLRequest(url: requestUrl, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 20)
            
            
           // request.allHTTPHeaderFields = Headers.headers()
            
            request.httpMethod = requestType.rawValue
            
            switch requestType {
            case .post, .patch, .put, .delete:
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: param ?? [String:Any](), options: [.prettyPrinted])
                    request.httpBody = jsonData
                } catch {
                    print(error.localizedDescription)
                }
                
            default:
                break
            }
            
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                DispatchQueue.main.async {
                    
                    
                    if let httpResponse = response as? HTTPURLResponse {
                        
                        if let str = httpResponse.allHeaderFields["Authorization"] as? String{
                            UserDefaults.standard.set(str, forKey: "token")
                        }
                        
                        let statucCode = httpResponse.statusCode
                        if httpResponse.statusCode == 200 {
                            guard let jsonData = data else {return}
                            do {
                                let userDict =  try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any]
                                
                                var title = ""
                                var message = ""
                                
                                if let message = userDict?["message"] as? String {
                                    title = message
                                }
                                if let data = userDict?["main"] as? [String:Any] {
                                    if let value = data["message"] as? String {
                                        message = value
                                    }
                                    completionHandler(true,data, message)
                                }
                                else if let dict = userDict?["data"] as? [[String : Any]] {
                                    
                                    completionHandler(true,userDict, message)
                                    
                                }
                                
                            }
                            catch {
                                
                            }
                            
                        } else {
                            switch statucCode {
                            case 401,403:
                                print("Session Expired")
                                
                                
                                
                            // .setRootViewController(vc: RegistrationStoryBoard.Login.getViewController())
                            // emptyUserDetails()
                            default:
                                guard let jsonData = data else {return}
                                do {
                                    let userDict =  try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any]
                                    DispatchQueue.main.async {
                                        var title = ""
                                        var message = ""
                                        
                                        if let message = userDict?["message"] as? String {
                                            title = message
                                        }
                                        if let data = userDict?["data"] as? [String:Any] {
                                            if let value = data["message"] as? String {
                                                message = value
                                            }
                                            
                                        }
                                        completionHandler(false , userDict, message)
                                        //  controller?.showlAlet(title: title, message: message)
                                    }
                                }catch {
                                    
                                }
                            }
                        }
                    }
                    if show == true {
                      //  self.stopIndicator()
                    }
                }
            }
            task.resume()
        }
    }
    
    
    
    
   
