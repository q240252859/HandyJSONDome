@_exported import HandyJSON //类似PCH
@_exported import RealmSwift
import UIKit    
    
    
    
    
    // 不使用数据库
    class BaseModel:HandyJSON  {
    @objc dynamic var status: String = ""          //返回代码
    @objc dynamic var desc: String = ""       //返回提示信息
    @objc dynamic var isCache: Bool = false   //是否本地缓存
    @objc dynamic var method: String = ""
    @objc dynamic var data:Any?
    required init() {
    }
    
}
class PanModel: BaseModel {
    
    @objc dynamic var url: String = ""
    @objc dynamic var params: String = ""
    @objc dynamic var result: String = ""
    
   
}
//使用数据库
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



// 使用
    
      let jsonString = "{\"code\":\"000000\",\"description\":\"success\",\"data\":[{\"flag\":\"nerUser\",\"phone\":\"18739966912\",\"nick\":\"moqigogo\",\"gender\":\"1\",\"birthday\":\"19900412\",\"avatar\":\"touxiangurl\",\"accessToken\":\"12123293829147318412fjer\",\"refreshToken\":\"28198e1euiwhdjs\",\"whiteListStatus\":\"1\",\"userStatus\":\"2\",\"isSecurityPasswordExist\":\"1\",\"securityTime\":\"123131\"}]}"
    
    let baseData = BaseModel.deserialize(from: jsonString)
    let model = loginModel.deserialize(from: baseData?.data as?[String:Any])
    let model1 = [loginModel].deserialize(from: baseData?.data as?[Any])
    
    
   /**
     获取行情
     */
    func marketData(_ types: String,
                    callback:@escaping (BaseModel, HomeModel) -> Void) {
        
//        http://wthrcdn.etouch.cn/weather_mini?citykey=101010100
 
        
        let params = ["citykey": types]
        
        let url = APIServerEnvironmentType.pro.apiUrl + "weather_mini"

        self.sendJsonRequestByGet(url, parameters: params, useCache: true) { (json, isCache) -> Void in
        //使用
            let baseData = BaseModel.deserialize(from: json)
            let model = HomeModel.deserialize(from: baseData?.data as?[String:Any])
            
           
            callback(baseData ?? BaseModel() , model ?? HomeModel())
        }
    }
    
    
    //最终
      //请求数据
        RemoteService.sharedInstance.marketData("101010100") { (BaseModel
            , HomeModel) in
            
        }
        
            
            
