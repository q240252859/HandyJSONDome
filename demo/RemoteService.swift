////
////  RmoteService.swift
////  light_guide
////
////  Created by mqt on 15/8/28.
////  Copyright (c) 2015年 wetasty. All rights reserved.
////
//
import UIKit
import Alamofire
//import SwiftyJSON
import RealmSwift
//import SwiftyRSA
import Log

public enum APIServerEnvironmentType: Int {
    case dev = 0;
    case pro = 1;
//http://wthrcdn.etouch.cn/weather_mini?citykey=101010100
    var symbol: String {
        switch self {

        case .dev:
            return "dev"
        case .pro:
            return "pro"

        }
    }

    //域名
    var domain: String {

        switch self {
        case .dev:

            return "wthrcdn.etouch.cn"

        case .pro:
            return "wthrcdn.etouch.cn"

        }
    }

    var version: String {
        
        return SystemConfig.buildCode

        switch self {
        case .dev:
            return "1_0_0"
        case .pro:
            return "1_0_0"
        }
    }

    var apiUrl: String {
        switch self {
        case .dev:
               return "http://test.\(self.domain)/"
        case .pro:
           return "http://\(self.domain)/"
        }
    }


}



class RemoteService: NSObject {

    


    let RealmDB = RealmDBHelper.sharedInstance  //Realm数据库

    /// 全局唯一实例
    static let sharedInstance: RemoteService = {
        let instance = RemoteService()
        return instance
    }()
    override init() {
        super.init();

    }

    /**
     调用http接口

     - parameter url:        接口地址
     - parameter parameters: 传入参数
     - parameter response:   回调处理
     */
    fileprivate func sendJsonRequest(_ url: String,
                                     parameters: [String: Any],
                                     useCache: Bool = false,
                                     useWeb: Bool = true,
                                     method:HTTPMethod = .post,
                                     response:@escaping (_ json: String, _ isCache: Bool) -> Void) {


//        // 加密参数
//        let signParams = APIParamsManager.configAuthParams(params: parameters)

//        var signParams = parameters
//        signParams["sign"] = "x"

        //        Log.debug("传入参数: \(params)")
        var logUrl = url

        logUrl.append("?")
        for (index,data) in parameters.enumerated() {

            if index == parameters.count - 1{
                logUrl.append("\(data.key)=\(data.value)")
            }else{
                logUrl.append("\(data.key)=\(data.value)&")
            }
        }

//        Log.debug("接口地址: \(logUrl)")
//        Log.debug("传入参数: \(signParams)")

        print("接口地址: \(logUrl)")
        print("传入参数: \(parameters)")

        //读取本地缓存
        //            let jsonParams = JSON(parameters)
        if useCache {   //如果使用缓存才读取
            let caches: Results<WebserviceCache> = self.RealmDB.objects(WebserviceCache.self).filter(" url = '\(url)' ")
            if caches.count > 0 {
                let cache = caches[0]
                //                Log.debug("cache: \(cache.result)")
                if let dataFromString = cache.result.data(using: String.Encoding.utf8, allowLossyConversion: false) {
                    
                    

                    response(cache.result, true)
                    
                    
                    
                }

            }
        }

        if useWeb {
            let token = SystemConfig.token

            let header: HTTPHeaders = ["Authorization": token]

           Alamofire.request(url, method: method, parameters: parameters, headers: header)
                .responseJSON {
                    resp in
                    let result = resp.result
                    if result.isSuccess {
//                        let json = JSON(result.value!)  //二进制数据转JSON
                        
                        
                        
                        let json = String(data: resp.data!, encoding: String.Encoding.utf8)
                        print("接口返回: \(json)")
                        //返回json对象
                        response(json ?? "", false)



                        //如果使用缓存，就保存缓存
                        if useCache {
                            try! self.RealmDB.write {
                                let newCache = WebserviceCache()
                                newCache.url = url
                                newCache.result = json ?? ""
                                self.RealmDB.add(newCache, update: true)
                            }
                        }
                    } else {
                       let json = String(data: resp.data!, encoding: String.Encoding.utf8)

                        //返回json对象
                        response(json ?? "", false)
                    }
            }
        }

    }


    /**
     调用http接口

     - parameter url:        接口地址
     - parameter parameters: 传入参数
     - parameter response:   回调处理
     */
    fileprivate func sendJsonRequestJSON(_ url: String,
                                     parameters: [String: Any],
                                     useCache: Bool = false,
                                     useWeb: Bool = true,
                                     method:HTTPMethod = .post,
                                     response:@escaping (_ json: String, _ isCache: Bool) -> Void) {


        //        // 加密参数
//        let signParams = APIParamsManager.configAuthParams(params: parameters)

        //        var signParams = parameters
        //        signParams["sign"] = "x"

        //        Log.debug("传入参数: \(params)")
        var logUrl = url

        logUrl.append("?")
        for (index,data) in parameters.enumerated() {

            if !(data.value is [Any]){
            if index == parameters.count - 1{
                logUrl.append("\(data.key)=\(data.value)")
            }else{
                logUrl.append("\(data.key)=\(data.value)&")
                }

            }
        }

        //        Log.debug("接口地址: \(logUrl)")
        //        Log.debug("传入参数: \(signParams)")

        print("接口地址: \(logUrl)")
        print("传入参数: \(parameters)")

        //读取本地缓存
        //            let jsonParams = JSON(parameters)
        if useCache {   //如果使用缓存才读取
            let caches: Results<WebserviceCache> = self.RealmDB.objects(WebserviceCache.self).filter(" url = '\(url)' ")
            if caches.count > 0 {
                let cache = caches[0]
                //                Log.debug("cache: \(cache.result)")
                if let dataFromString = cache.result.data(using: String.Encoding.utf8, allowLossyConversion: false) {

                   response(cache.result, true)
                }

            }
        }

        if useWeb {
            let token = SystemConfig.token
            let userId = SystemConfig.userId
            let header: HTTPHeaders = ["Authorization": token,"token":token,"userId":userId]
            //处理URL 参数带中文的
            let newUrl = logUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!

            
            Alamofire.request(newUrl, method: method, parameters: parameters,encoding:JSONEncoding.default, headers: header)
                .responseJSON {
                    resp in
                    let result = resp.result
                    if result.isSuccess {
                        let json = String(data: resp.data!, encoding: String.Encoding.utf8)
                        print("接口返回: \(json)")
                        //返回json对象
                        response(json ?? "", false)

                        //如果使用缓存，就保存缓存
                        if useCache {
                            try! self.RealmDB.write {
                                let newCache = WebserviceCache()
                                newCache.url = url
                                newCache.result = json ?? ""
                                self.RealmDB.add(newCache, update: true)
                            }
                        }
                    } else {
//                        let json = String(data: result.value! as! Data, encoding: String.Encoding.utf8)


                        //返回json对象
                        response( "", false)
                    }
            }
        }

    }


    //针对提币接口，使用get方法
    /**
     调用http接口

     - parameter url:        接口地址
     - parameter parameters: 传入参数
     - parameter response:   回调处理
     */
    fileprivate func sendJsonRequestByGet(_ url: String,
                                     parameters: [String: Any],
                                     useCache: Bool = false,
                                     useWeb: Bool = true,
                                     response:@escaping (_ json: String, _ isCache: Bool) -> Void) {
//        Log.debug("接口地址: \(url)")

        // 加密参数
//        let signParams = APIParamsManager.configAuthParams(params: parameters)

//        Log.debug("传入参数: \(signParams)")

        //读取本地缓存
        if useCache {   //如果使用缓存才读取
            let caches: Results<WebserviceCache> = self.RealmDB.objects(WebserviceCache.self).filter(" url = '\(url)' ")
            if caches.count > 0 {
                let cache = caches[0]
                //                Log.debug("cache: \(cache.result)")
                if let dataFromString = cache.result.data(using: String.Encoding.utf8, allowLossyConversion: false) {

                         response(cache.result, true)
                  
                   // response(JSON(data: dataFromString), true)
                }

            }
        }

        if useWeb {
            let token = SystemConfig.token
            let header: HTTPHeaders = ["Authorization": token]

                //Alamofire.request(url, method: .post, parameters: signParams, headers: header)
                Alamofire.request(url, method: .get, parameters: parameters, headers: header)
                .responseJSON {
                    resp in
                    let result = resp.result
                    
                    if result.isSuccess {
                        let json = String(data: resp.data!, encoding: String.Encoding.utf8)
                        print("接口返回: \(json)")
                        //返回json对象
                        response(json ?? "", false)

                        //如果使用缓存，就保存缓存
                        if useCache {
                            try! self.RealmDB.write {
                                let newCache = WebserviceCache()
                                newCache.url = url
                                newCache.result = json ?? ""
                                self.RealmDB.add(newCache, update: true)
                            }
                        }
                    } else {
//                        let json = String(data: result.value! as! Data, encoding: String.Encoding.utf8)
//                        print("接口返回: \(json)")
                        //返回json对象
                        response( "", false)
                    }
            }
        }


    }

//    /**
//     上传文件接口基础方法
//
//     - parameter url:
//     - parameter parameters:
//     - parameter progress:
//     - parameter response:
//     */
//    fileprivate func uploadFile(_ url: String,
//                                parameters: [String: Any],
//                                progress:((_ percent: Float) -> Void)? = nil,
//                                response:@escaping (_ json: JSON, _ isSuccess: Bool) -> Void) {
//
//        // ***** 后台大哥不会再formdata里抓参数,所以把参数拼接到url了 *****
//        var logUrl = url
//        logUrl.append("?")
//        var dict = [String: Any]()
//        for data in parameters {
//            if data.value is String {
//                dict[data.key] = data.value
//            }
//        }
//        for (index, item) in dict.enumerated() {
//            if index == dict.count - 1{
//                logUrl.append("\(item.key)=\(item.value)")
//            }else{
//                logUrl.append("\(item.key)=\(item.value)&")
//            }
//        }
//
//
//        print("图片上传接口地址: \(logUrl)")
//        print("图片上传传入参数: \(parameters)")
//       //请求头需传
//        let headers:HTTPHeaders = [
//            "Authorization": SystemConfig.token,
//            "token":SystemConfig.token,
//            "Content-Type":"multipart/form-data",
//            "Origin":self.apiType.apiExUrl,
//            "Referer":self.apiType.apiExUrl + "/account/auth",
//            "appType": "android"
//        ]
//
//        Alamofire.upload(multipartFormData: {
//            (multipartFormData) in
//            //添加参数到httpbody
//            for (key, value) in parameters {
//                if let str_value = value as? String {
//                    multipartFormData.append(str_value.data(using: String.Encoding.utf8)!, withName: key)
//                } else if let data_value = value as? UploadFileModule {
//                    multipartFormData.append(data_value.data, withName: key, fileName: data_value.fileName, mimeType: data_value.mimeType)
//                }
//            }
//        }, to: logUrl, method: .post,headers: headers) {
//            (encodingResult) in
//
//            switch encodingResult {
//            case .success(request: let upload, streamingFromDisk: _, streamFileURL: _):
//                upload.uploadProgress() { (prog) in
//                    progress?(Float(prog.fractionCompleted))
//                    print("Upload Progress: \(prog.fractionCompleted)")
//                    }
//                    .responseJSON {
//                        resp in
//
//                        let result = resp.result
//                        if result.isSuccess {
//                            let json = JSON(result.value!)
//                            response(json, true)
//                        } else {
//                            print("图片上传失败 result = \(resp.description)")
//                            let json: JSON =  ["info": "服务器请求失败".localized(), "code": "30002"]
//                            response(json, false)
//                        }
//
//                }
//            case .failure(let encodingError):
//                print("上传图片失败\(encodingError)")
//                let json: JSON =  ["info": "服务器请求失败".localized(), "code": "30002"]
//                response(json, false)
//            }
//        }
//    }




 

    /**
     获取行情
     */
    func marketData(_ types: String,
                    callback:@escaping (BaseModel, HomeModel) -> Void) {
        
//        http://wthrcdn.etouch.cn/weather_mini?citykey=101010100
 
        
        let params = ["citykey": types]
        
        let url = APIServerEnvironmentType.pro.apiUrl + "weather_mini"

        self.sendJsonRequestByGet(url, parameters: params, useCache: true) { (json, isCache) -> Void in
            
            let baseData = BaseModel.deserialize(from: json)
            let model = HomeModel.deserialize(from: baseData?.data as?[String:Any])
            
           
            callback(baseData ?? BaseModel() , model ?? HomeModel())
        }
    }












}
