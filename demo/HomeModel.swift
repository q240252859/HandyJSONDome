//
//  HomeModel.swift
//  demo
//
//  Created by luoming on 2019/12/11.
//  Copyright © 2019 SingleVideo. All rights reserved.
//

import UIKit

//class BaseModel: HandyJSON{
//    @objc dynamic var code: String = ""
//    @objc dynamic var message:String?
//    @objc dynamic var data:Any?
//    required init() {
//    }
//
//
//    func mapping(mapper: HelpingMapper) {
//        mapper <<<
//            /// 系统名冲突
//            self.message <-- "description"
//    }
//}

class loginModel: RealmObject, HandyJSON {
    @objc dynamic var flag:String = ""
    @objc dynamic var phone:String = ""
    @objc dynamic var nick:String = ""
    @objc dynamic var gender:String = ""
    @objc dynamic var birthday:String = ""
    @objc dynamic var avatar:String = ""
    @objc dynamic var accessToken:String = ""
    @objc dynamic var refreshToken:String = ""
    @objc dynamic var whiteListStatus:String = ""
    @objc dynamic var userStatus:String = ""
    @objc dynamic var isSecurityPasswordExist:String = ""
    @objc dynamic var securityTime:String = ""
    
    ///* Any 对象 不能存 数据库
    //    primaryKey() 可以设置模型的主键。
    override static func primaryKey() -> String? {
        return "accessToken"
    }
    
    /**
     获取所有数据
     */
    class func getLoginModelArrData()-> [loginModel] {
        let realmDB = RealmDBHelper.sharedInstance  //Realm数据库
        let datas: Results<loginModel> = realmDB.objects(loginModel.self)
        
        return datas.toArray()
    }
    
    /**
     查找
     */
    class func getDetailData(accessToken : String)-> loginModel?{
        let realmDB = RealmDBHelper.sharedInstance  //Realm数据库 ///增删改查 查(升序/降序)....
        let datas: Results<loginModel> = realmDB.objects(loginModel.self).filter(" accessToken = '\(accessToken)'")
        if datas.count > 0{
            return datas[0]
            
        }else{
            return nil
        }
    }
    
}

class HomeModel: RealmObject, HandyJSON {
    @objc dynamic var city:String = ""
    @objc dynamic var yesterday:HomeYesterdayModel?
    @objc dynamic var forecast:[HomeForecastModel]?
    @objc dynamic var ganmao:String = ""
    @objc dynamic var wendu:String = ""
    
    
    ///* Any 对象 不能存 数据库
    //    primaryKey() 可以设置模型的主键。
    override static func primaryKey() -> String? {
        return "city"
    }
    //忽略 数组
    override static func ignoredProperties() -> [String] {
        return ["forecast"]
    }
    
    
}
class HomeYesterdayModel: RealmObject, HandyJSON {
    
    @objc dynamic var date:String = ""
    @objc dynamic var high:String = ""
    @objc dynamic var fx:String = ""
    @objc dynamic var low:String = ""
    @objc dynamic var fl:String = ""
    @objc dynamic var type:String = ""
    
    ///* Any 对象 不能存 数据库
    //    primaryKey() 可以设置模型的主键。
    override static func primaryKey() -> String? {
        return "date"
    }
    
    
    
}
class HomeForecastModel: RealmObject, HandyJSON {
    @objc dynamic var date:String = ""
    @objc dynamic var high:String = ""
    @objc dynamic var fengli:String = ""
    @objc dynamic var low:String = ""
    @objc dynamic var fengxiang:String = ""
    @objc dynamic var type:String = ""
    
    
    ///* Any 对象 不能存 数据库
    //    primaryKey() 可以设置模型的主键。
    override static func primaryKey() -> String? {
        return "date"
    }
    
    
    
}


class BaseModel:HandyJSON  {
    @objc dynamic var status: String = ""          //返回代码
    @objc dynamic var desc: String = ""       //返回提示信息
    @objc dynamic var isCache: Bool = false   //是否本地缓存
    @objc dynamic var method: String = ""
    @objc dynamic var data:Any?
    required init() {
    }
    
}




class WebserviceCache: Object {
    
    @objc dynamic var url: String = ""
    @objc dynamic var params: String = ""
    @objc dynamic var result: String = ""
    
    override static func primaryKey() -> String? {
        return "url"
    }
}
