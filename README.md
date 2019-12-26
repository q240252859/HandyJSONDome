# HandyJSONDome
@_exported进口HandyJSON //类似PCH
@_exported导入RealmSwift

//不带数据库
类BaseModel：HandyJSON {
    @objc动态无功状态：字符串= “” //返回代码
     @objc动态无功递减：字符串= “” //返回提示信息
     @objc动态无功isCache：BOOL =假//是否本地缓存
     @objc动态无功方法：字符串=“”
     @objc动态var数据：是吗？
    必需的init（）{
    }
    
}
类PanModel：BaseModel {
    
    @objc动态变量网址：String =“”
     @objc动态变量参数：String =“”
     @objc动态变量结果：String =“”
    
   
}
//使用数据库
// Class BaseModel：HandyJSON {
//     @objc动态var代码：String =“”
//     @objc动态var消息：字符串？
//     @objc动态var数据：是吗？
//必需的init（）{
//}
//
//
// func mapping（mapper：HelpingMapper）{
//映射器<<<
// ///系统名冲突
// self.message <-“ description”
//}
//}

类loginModel：RealmObject，HandyJSON {
    @objc动态变量标志：String =“”
     @objc动态变量电话：String =“”
     @objc动态变量昵称：String =“”
     @objc动态变量性别：String =“”
     @objc动态变量生日：String =“”
     @objc动态变量 avatar：String =“”
     @objc动态变量accessToken：String =“”
     @objc动态变量refreshToken：String =“”
     @objc动态变量whiteListStatus：String =“”
     @objc动态变量userStatus：String =“”
     @objc动态var isSecurityPasswordExist：String =“”
    @objc动态var securityTime：String =“”
    
    /// *任何对象都不能保存数据库
    // primaryKey（）可以设置模型的主键。
    覆盖静态函数primaryKey（）->字符串？{
        返回“ accessToken”
    }
    
    / **
     获取所有数据
     * /
    类func getLoginModelArrData（）-> [loginModel] {
        let realmDB = RealmDBHelper.sharedInstance // Realm数据库
        让数据：结果<loginModel> = realmDB.objects（loginModel.self）
        
        返回datas.toArray（）
    }
    
    / **
     发现
     * /
    class func getDetailData（accessToken：String）-> loginModel？{
        let realmDB = RealmDBHelper.sharedInstance // Realm数据库////增删改查查（升序/降序）....
        让数据：结果<loginModel> = realmDB.objects（loginModel.self）.filter（“ accessToken ='\（accessToken）'”）
        如果datas.count> 0 {
            返回数据[0]
            
        }其他{
            返回零
        }
    }
    
}

类HomeModel：RealmObject，HandyJSON {
    @objc动态变量 city：String =“”
     @objc动态变量昨天：HomeYesterdayModel？
    @objc动态var预测：[HomeForecastModel]？
    @objc动态var ganmao：String =“”
     @objc动态var wendu：String =“”
    
    
    /// *任何对象都不能保存数据库
    // primaryKey（）可以设置模型的主键。
    覆盖静态函数primaryKey（）->字符串？{
        返回“城市”
    }
    //忽略原文
    覆盖静态函数ignoreProperties（）-> [String] {
        返回[“预测”]
    }
    
    
}
class HomeYesterdayModel：RealmObject，HandyJSON {
    
    @objc动态变量 date：String =“”
     @objc动态变量 high：String =“”
     @objc动态变量 fx：String =“”
     @objc动态变量 low：String =“”
     @objc动态变量 fl：String =“”
     @objc动态var类型：String =“”
    
    /// *任何对象都不能保存数据库
    // primaryKey（）可以设置模型的主键。
    覆盖静态函数primaryKey（）->字符串？{
        归期”
    }
    
    
    
}
class HomeForecastModel：RealmObject，HandyJSON {
    @objc动态变量 date：String =“”
     @objc动态变量 high：String =“”
     @objc动态变量fengli：String =“”
     @objc动态变量 low：String =“”
     @objc动态变量fengxiang：String =“”
     @objc动态var类型：String =“”
    
    
    /// *任何对象都不能保存数据库
    // primaryKey（）可以设置模型的主键。
    覆盖静态函数primaryKey（）->字符串？{
        归期”
    }
    
    
    
}
//使用

 让baseData = BaseModel.deserialize（来自：json）
            让模型= HomeModel.deserialize（来自：baseData？.data as？[String：Any]）
