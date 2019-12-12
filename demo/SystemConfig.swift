//
//  SystemConfig.swift
//  light_guide
//
//  Created by mqt on 15/8/29.
//  Copyright (c) 2015年 wetasty. All rights reserved.
//

import Foundation
//import KeychainSwift


// MARK: - 系统相关配置
struct SystemConfig {
    
 
   
    
    /// 临时图片文件的目标路径
    static var imagsFilePath: URL {
        
        let fileManager = FileManager.default
        var directoryURL = fileManager.urls(for: .cachesDirectory, in: .userDomainMask)[0]
        directoryURL = directoryURL.appendingPathComponent("imgs_file")
        
        do {
            try FileManager.default.createDirectory(at: directoryURL, withIntermediateDirectories: true, attributes: nil)
        }
        catch let error as NSError {
           print(error.description)
        }
        
        return directoryURL
    }
    
 
    /// 返回当前api环境
    static var APIServerEnvironmentType: String {
        let plistPath = Bundle.main.path(forResource: "system_setting", ofType: "plist");
        let dict = NSDictionary(contentsOfFile: plistPath!);
        let versionType: String = dict?.object(forKey: "versionType") as! String
        return versionType
    }
    
    /// 返回当前版本的渠道号
    static var channelversion: String {
        
        let infoDictionary = Bundle.main.infoDictionary!
        let majorVersion = infoDictionary["Channel versions"] as! String
        return majorVersion
        
    }
    /// 标示是否已经上传过安装统计信息
    static var isUploadCount:Bool {
        
        get {
            let value = UserDefaults.standard.bool(forKey: "SCisUploadCount");
            return value;
        }
        
        set {
            UserDefaults.standard.set(newValue, forKey: "SCisUploadCount");
            UserDefaults.standard.synchronize();
        }
    }
    
    
    /// 新的标示是否已经上传过安装统计信息
    static var isNewUploadCount:Bool {
        
        get {
            let value = UserDefaults.standard.bool(forKey: "SCisNewUploadCount");
            return value;
        }
        
        set {
            UserDefaults.standard.set(newValue, forKey: "SCisNewUploadCount");
            UserDefaults.standard.synchronize();
        }
    }
    
    /// 临时登录s上传状态的标志，为了防止重复上传
    static var isUploadDownoload:Bool {
        
        get {
            let value = UserDefaults.standard.bool(forKey: "SCisUploadDownoload");
            return value;
        }
        
        set {
            UserDefaults.standard.set(newValue, forKey: "SCisUploadDownoload");
            UserDefaults.standard.synchronize();
        }
    }
    



    
    /// 获取版本号
    static var version: String {
        let infoDictionary = Bundle.main.infoDictionary!
        let majorVersion = infoDictionary["CFBundleShortVersionString"] as! String
        return majorVersion
    }
    
    /// 获取迭代号
    static var buildCode: String {
        let infoDictionary = Bundle.main.infoDictionary!
        let buildCode = infoDictionary["CFBundleVersion"] as! String
        return buildCode
    }
    
    //获取系统已安装的版本号
    static func getVersionInstalled(_ className: String) -> String {
        let version = SystemConfig.buildCode
        let key = "v_\(className)_\(version)"
//        Log.debug("当前类名 = " + key)
        let versionInstall = UserDefaults.standard.value(forKey: key) as? String ?? ""
        return versionInstall
    }
    
    //获取系统已安装的版本号
    static func setVersionInstalled(_ className: String) {
        let version = SystemConfig.buildCode
        let key = "v_\(className)_\(version)"
        
        UserDefaults.standard.set(version, forKey: key)
        UserDefaults.standard.synchronize();
    }
    
   
    
   
    
   
   
    
//    /// 服务端公钥
//    static var chbtcPublicKey: String {
//
//        let type = RemoteService.sharedInstance.apiType
//        switch type {
//        case .dev:
//            // dev 测试专用
////             return "MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDipJxzYD6Q9wqpHpLNT/inkTPeupTASzMLUpFrU4RulgGBm8aNmWoT5M+Nr0IIFLHTvV96fc+b28290rvjYt6p2/Jio+HnUJGCJHHkjE7Qpw5XMSCZYBN4zF4yg1xe/L6qWXCsHCgKC9uJnt9741G91xaz1kpDi17WKu42QaUsRQIDAQAB"
////            let publicKey = UserDefaults.standard.value(forKey: "publicKey") as? String ?? ""
////            return publicKey
//            return "MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCI4H9Za0nukuGjRZzcvVczhuvkhVpIH3zlOuyBWKskqqEPC/Z1DVPRgybDvXM7mORQENK9RuBHmBTzctkNOplrpz0Zh3DoDl2huF0xIbMBnFkUjQ4KK8kzhLTdQ0E2QjuyXVETuPeW0YFgesZw5t/nOjbOwdem1FyBL7j0XTzmIQIDAQAB"
//        // pro
//        case .pro:
////            return "MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDNV231RfCad/GlkuP3d7+awQIWWVxvcmtISa0rjgywwus3VUdbVoqahCbF08Gj3O9R30C2SQcw23D3XCcvt/26EKT7dhUNyiB4N8nejocHjGieeCii1NtmpDncg+tn3thvKU1loUa3FYA+/ZWSMW/QvE7+0zzrcCHRqlt0opJAHwIDAQAB"
////            let publicKey = UserDefaults.standard.value(forKey: "publicKey") as? String ?? ""
////            return publicKey
//            return "MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCI4H9Za0nukuGjRZzcvVczhuvkhVpIH3zlOuyBWKskqqEPC/Z1DVPRgybDvXM7mORQENK9RuBHmBTzctkNOplrpz0Zh3DoDl2huF0xIbMBnFkUjQ4KK8kzhLTdQ0E2QjuyXVETuPeW0YFgesZw5t/nOjbOwdem1FyBL7j0XTzmIQIDAQAB"
//        }
//
//
//    }
    
    
    
    /// 地区更新版本号
    static var areaVersion: String {
        get {
        let value = UserDefaults.standard.value(forKey: "SCAreaVersion") as? String
        return value ?? "0";
        }
        
        set {
            UserDefaults.standard.set(newValue, forKey: "SCAreaVersion")
            UserDefaults.standard.synchronize();
        }
    }
 
    /// 国家编码的更新版本号
    static var countryVersion: String {
        get {
            let value = UserDefaults.standard.value(forKey: "SCCountryVersion") as? String
            return value ?? "0";
        }
        
        set {
            UserDefaults.standard.set(newValue, forKey: "SCCountryVersion")
            UserDefaults.standard.synchronize();
        }
    }
    
   
    
    /// 启动图的更新版本号
    static var guideUpdateVersion: String {
        get {
            let value = UserDefaults.standard.value(forKey: "GuideUpdateVersion") as? String
            return value ?? "0";
        }
        
        set {
            UserDefaults.standard.set(newValue, forKey: "GuideUpdateVersion")
            UserDefaults.standard.synchronize();
        }
    }
    
    /// 启动图的总数量
    static var guideImageTotal: String {
        get {
            let value = UserDefaults.standard.value(forKey: "GuideImageTotal") as? String
            return value ?? "0";
        }
        
        set {
            UserDefaults.standard.set(newValue, forKey: "GuideImageTotal")
            UserDefaults.standard.synchronize();
        }
    }
    
    /// 启动图是否已阅
    static var isRead:Bool {
        
        get {
            let value = UserDefaults.standard.bool(forKey: "SCisRead");
            return value;
        }
        
        set {
            UserDefaults.standard.set(newValue, forKey: "SCisRead");
            UserDefaults.standard.synchronize();
        }
    }
    
    
    
    
    
    /// 保存应用进入后台的时间戳
    static var enterBackgroundTime: String {
        get {
            let value = UserDefaults.standard.value(forKey: "SCEnterBackgroundTime") as? String
            return value ?? "0";
        }
        
        set {
            UserDefaults.standard.set(newValue, forKey: "SCEnterBackgroundTime")
            UserDefaults.standard.synchronize();
        }
    }
    
 
   
    
}

// MARK: - 用户相关配置
extension SystemConfig {
    
    /// 是否登录
    static var isLogin:Bool {
        
        get {
            let value = UserDefaults.standard.bool(forKey: "SCIsLogin");
            return value;
        }
        
        set {
            UserDefaults.standard.set(newValue, forKey: "SCIsLogin");
            UserDefaults.standard.synchronize();
        }
    }
    
    /// 是否自动登录
    static var isAutoLogin:Bool {
        
        get {
            let value = UserDefaults.standard.bool(forKey: "SCIsAutoLogin");
            return value;
        }
        
        set {
            UserDefaults.standard.set(newValue, forKey: "SCIsAutoLogin");
            UserDefaults.standard.synchronize();
        }
    }
    
    /// 用户登录账号
    static var userLoginName: String {
        get {
            let value = UserDefaults.standard.value(forKey: "SCUserLoginName") as? String
            return value ?? "";
        }
        
        set {
            UserDefaults.standard.set(newValue, forKey: "SCUserLoginName")
            UserDefaults.standard.synchronize();
        }
    }
    
    /// 用户登录账号
    static var userCountryCode: String {
        get {
            let value = UserDefaults.standard.value(forKey: "SCUserCountryCode") as? String
            return value ?? "";
        }
        
        set {
            UserDefaults.standard.set(newValue, forKey: "SCUserCountryCode")
            UserDefaults.standard.synchronize();
        }
    }
    
    
    /// 用户登录昵称
    static var userNickName: String {
        get {
            let value = UserDefaults.standard.value(forKey: "SCUserNickName") as? String
            return value ?? "";
        }
        
        set {
            UserDefaults.standard.set(newValue, forKey: "SCUserNickName")
            UserDefaults.standard.synchronize();
        }
    }
    
    /// 用户id
    static var userId: String {
        get {
            let value = UserDefaults.standard.value(forKey: "SCUserId") as? String
            return value ?? "";
        }
        
        set {
            UserDefaults.standard.set(newValue, forKey: "SCUserId")
            UserDefaults.standard.synchronize();
        }
    }

    
    /// token
    static var token: String {
        get {
            let value = UserDefaults.standard.value(forKey: "SCToken") as? String
            return value ?? "";
        }
        
        set {
            UserDefaults.standard.set(newValue, forKey: "SCToken")
            UserDefaults.standard.synchronize();
        }
    }
    
    /// recommendCode
    static var recommendCode: String {
        get {
            let value = UserDefaults.standard.value(forKey: "SCRecommendCode") as? String
            return value ?? "";
        }
        
        set {
            UserDefaults.standard.set(newValue, forKey: "SCRecommendCode")
            UserDefaults.standard.synchronize();
        }
    }
    
    /// 环信id
    static var easemobId: String {
        get {
            let value = UserDefaults.standard.value(forKey: "SCEasemobId") as! String
            return value;
        }
        
        set {
            UserDefaults.standard.set(newValue, forKey: "SCEasemobId")
            UserDefaults.standard.synchronize();
        }
    }
    
    
    /// 设置手势密码
    static var isGesturePassword: Bool {
        get {
            
            let value = UserDefaults.standard.bool(forKey: "SCIsGesturePassword");
            return value ;
        }
        
        set {
            UserDefaults.standard.set(newValue, forKey: "SCIsGesturePassword");
            UserDefaults.standard.synchronize();
        }
    }
    
    /// 设置指纹解锁
    static var isTouchIDAppLock: Bool {
        get {
            let userId = SystemConfig.userId
            let value = UserDefaults.standard.bool(forKey: "SCIsTouchIDAppLock_\(userId)");
            return value ;
        }
        
        set {
            let userId = SystemConfig.userId
            UserDefaults.standard.set(newValue, forKey: "SCIsTouchIDAppLock_\(userId)");
            UserDefaults.standard.synchronize();
        }
    }
    
    /// 设置指纹交易
    static var isTouchIDExchange: Bool {
        get {
            let userId = SystemConfig.userId
            let value = UserDefaults.standard.bool(forKey: "SCIsTouchIDExchange_\(userId)");
            return value ;
        }
        
        set {
            //要key上补充用户id，划分不同账号
            let userId = SystemConfig.userId
            UserDefaults.standard.set(newValue, forKey: "SCIsTouchIDExchange_\(userId)");
            UserDefaults.standard.synchronize();
        }
    }
    
    /// 设置指纹支付
    static var isTouchIDPay: Bool {
        get {
            let userId = SystemConfig.userId
            let value = UserDefaults.standard.bool(forKey: "SCIsTouchIDPay_\(userId)");
            return value ;
        }
        
        set {
            //要key上补充用户id，划分不同账号
            let userId = SystemConfig.userId
            UserDefaults.standard.set(newValue, forKey: "SCIsTouchIDPay_\(userId)");
            UserDefaults.standard.synchronize();
        }
    }
    
    
    /// touchId密码
//    static var touchIdPassword: String {
//        get {
//            let userId = SystemConfig.userId
//            let keychain = KeychainSwift()
//            let value = keychain.get("SCTouchIdPassword_\(userId)")
//            return value ?? "0";
//        }
//
//        set {
//            let userId = SystemConfig.userId
//            let keychain = KeychainSwift()
//            keychain.set(newValue, forKey: "SCTouchIdPassword_\(userId)")
//        }
//    }
    
 
    
 
    
    /// 登录验证类型
    static var loginCheckTypeIndex:Int {
        
        get {
            let value = UserDefaults.standard.integer(forKey: "SCTypeLoginCheck")
            return value
        }
        
        set {
            UserDefaults.standard.set(newValue, forKey: "SCTypeLoginCheck");
            UserDefaults.standard.synchronize();
        }
    }
    
    
    
    /// 支付验证类型
    static var payCheckTypeIndex:Int {
        
        get {
            let value = UserDefaults.standard.integer(forKey: "SCTypePayCheck")
            return value
        }
        
        set {
            UserDefaults.standard.set(newValue, forKey: "SCTypePayCheck");
            UserDefaults.standard.synchronize();
        }
    }

    
    

    

    
    
//    /// 应用授权key
//    static var appKey: String {
//        let type = RemoteService.sharedInstance.apiType
//        switch type {
//        case .dev:
//
//          //  return "41rc1yLBTTOMpSYyyz9iBsLaiiFgh1NWEw3pRhpaq3B6XJ2KPD7UJdwOFvxYu2DLErMPJNlrnjR8LumDqD2ohwih"
//
////           return "41rc1yLBTTOMpSYyyz9iBsLaiiFgh1NWEw3pRhpaq3B6XJ2KPD7UJdwOFvxYu2DLErMPJNlrnjR8LumDqD2ohwih"
//
//          return "e48155f0-ca78-44d3-a906-8d1b7831e4da"
//            //WX
//            // return "1L6riJEl2U1bbPjSRz3v9Y7GmMVwm1EjUC3i2XBwkOhXUCCY2yQCvteRnIxSXlNLXL10zvj9cFlUGujiGEHpdw3L"
//
//            //GL
//           // return "TPMYe1P7OzKI2hJBq4348lBBMvhG4JGOJDZsfV1NJpMKtQGGXQHa1TbCzBVX0I69OUQpji0gVe1oybR1PRxuF0h4"
//
//
//
//        case .pro:
////            return  "n6j601l0jD3sA4FtzNm4aRyid4WYi9gLdIqfJVEZpE4Z2sorCs28xdhCOxZYV4rnTfSTR7eFHCYweUnmqrJzONuZ"
//            return "e48155f0-ca78-44d3-a906-8d1b7831e4da"
//
//        }
//    }
    
//    /// 应用授权secret
//    static var appSecret: String {
//        let type = RemoteService.sharedInstance.apiType
//        switch type {
//        case .dev:
//           //return "iQaVLfWsXJpXtKNbfNUsYq9sXxgdftgHtLzslISoazhIsobA6yzhdF1FtOEFE8TCA2nopc7GVLv0rnEhCB2u2raj"
//            
////            return "EMLgRS5g8Ox7CM2CmVHpEZgpQCxHpoctmDsARDQz13caU1sVqenV5YVlEg8Pu1mErlpOw8fneQgftZk7FXqddSFK"
//            return "06f0f7a749c66ea9d7c78eb208d07d72803c6c26"
//            
//         
//            //WX
//            //  return "fdFb6YPhh3OMnBX32ol1rw8LHSmKTaxZYtYyGDwRajXnaFFCxfiAT7KmF1aqVOaJbkSQgwewtEx4rDpi4LKNRpri"
//            
//            //GL
//         //  return "0jnhGHyTycszEV9h8rjZIxPb8macIfWZXzX08NFdjIc9aGUvXISgOXoBjnTgSYPAZpWhl9PbTO0rjW8hNDPGjD6I"
//
//            
//        case .pro:
////             return "W1Bf5AqGLiDJLQgAbGTetDfMKJSVhYkQIQ9wzSiXcg0vHlCQynSV6OzJBGMBp0jRABnE8y9IFSorcAqigSnSEqf7"
//            return "06f0f7a749c66ea9d7c78eb208d07d72803c6c26"
//        }
//        
//    }
//    
//    /// 解密加密后的域名
//    static var appDomainsPriKey: String {
//        let type = RemoteService.sharedInstance.apiType
//        switch type {
//        case .dev:
//           
//            return "MIICdgIBADANBgkqhkiG9w0BAQEFAASCAmAwggJcAgEAAoGBAKbzdrF0SHrBa+ANTERcsjfPLjKhIcgRqvB5zG3n0ArdKoPNbpVmvEim48vnTrT8PuV498vDHe8A8MGeLKRDuxvfT/dokc3LMUMih2gxSm0sfR4FR5iLoiaZXcpKVdNPi8e3o9n8g0faMNwSeoEdY0SFcAvoHeYQjn+cE19DzwcRAgMBAAECgYBesCMXjm41QVKfpqsk8rYZtSXsjTsNsAeVkF8DzsBOCRY93tvjXHtZcV4tnakkORSrLarNJILrtUrXZZDIMaoCwBVXpXZ96FasY1e6KSHeViR6KN2Z5MOo62QOyngTh3xt+iIEJm+cpP05MZoA3H0RUAYu7T2KqnjlGc+heU0cAQJBANn0GkNyknIz0Qg9wmd1nPvkUBSCm83Zjy6SsQcYr1HcdL/hP9v9/jx9ViIObap0NOHU1a8eqqpjCcNwugtamiECQQDEGCnuvTdqiOh0GNH8Kc5Nef0b7UJCTDytTc3bbYfU97MDjR0Qlcu57R0DQewzrnzEbzylQwDifPQZUMnFki7xAkAshvc6olSS6k0hPuTRmDCrMXi+x/QmuPTMkgGCrqNauQxNCyqtuhVPrFeFe6ch9L29CWtibIR3bOZYvFX17duhAkEAjWIuuadLkVBs6WgL3pf12v6dc8k5ALwe84Upa5ApY2/EbkcMMa0PWlqPlI2vVAP2iVr6it0ogiQ9ixMop36iwQJAN5dfNzpue+diGB3t9JF9TctT0+0Hywzn9qAhPq+NIoD/xyqNamnrbaEa69ErdVUpPEJzd7xzFfGzAbzsFs0Xsg=="
//            
//        case .pro:
//            return "MIICdgIBADANBgkqhkiG9w0BAQEFAASCAmAwggJcAgEAAoGBAKbzdrF0SHrBa+ANTERcsjfPLjKhIcgRqvB5zG3n0ArdKoPNbpVmvEim48vnTrT8PuV498vDHe8A8MGeLKRDuxvfT/dokc3LMUMih2gxSm0sfR4FR5iLoiaZXcpKVdNPi8e3o9n8g0faMNwSeoEdY0SFcAvoHeYQjn+cE19DzwcRAgMBAAECgYBesCMXjm41QVKfpqsk8rYZtSXsjTsNsAeVkF8DzsBOCRY93tvjXHtZcV4tnakkORSrLarNJILrtUrXZZDIMaoCwBVXpXZ96FasY1e6KSHeViR6KN2Z5MOo62QOyngTh3xt+iIEJm+cpP05MZoA3H0RUAYu7T2KqnjlGc+heU0cAQJBANn0GkNyknIz0Qg9wmd1nPvkUBSCm83Zjy6SsQcYr1HcdL/hP9v9/jx9ViIObap0NOHU1a8eqqpjCcNwugtamiECQQDEGCnuvTdqiOh0GNH8Kc5Nef0b7UJCTDytTc3bbYfU97MDjR0Qlcu57R0DQewzrnzEbzylQwDifPQZUMnFki7xAkAshvc6olSS6k0hPuTRmDCrMXi+x/QmuPTMkgGCrqNauQxNCyqtuhVPrFeFe6ch9L29CWtibIR3bOZYvFX17duhAkEAjWIuuadLkVBs6WgL3pf12v6dc8k5ALwe84Upa5ApY2/EbkcMMa0PWlqPlI2vVAP2iVr6it0ogiQ9ixMop36iwQJAN5dfNzpue+diGB3t9JF9TctT0+0Hywzn9qAhPq+NIoD/xyqNamnrbaEa69ErdVUpPEJzd7xzFfGzAbzsFs0Xsg=="
//            
//            
//        }
//        
//    }


    /// 滚轮选择类型
    static var pickViewSelectIndex:Int {
        
        get {
            let value = UserDefaults.standard.integer(forKey: "SCpickViewSelectIndex")
            return value
        }
        
        set {
            UserDefaults.standard.set(newValue, forKey: "SCpickViewSelectIndex");
            UserDefaults.standard.synchronize();
        }
    }
    
    
    // 后台是否开启通知 
    static var isOpenNoti:Int {
        
        get {
            let value = UserDefaults.standard.integer(forKey: "SCisOpenNoti")
            return value
        }
        
        set {
            UserDefaults.standard.set(newValue, forKey: "SCisOpenNoti");
            UserDefaults.standard.synchronize();
        }
    }
    
    // 是否开启提醒更新
    static var isCloseUpdate:Bool {
        
        get {
            let value = UserDefaults.standard.bool(forKey: "SCisOpenUPdate")
            return value
        }
        
        set {
            UserDefaults.standard.set(newValue, forKey: "SCisOpenUPdate");
            UserDefaults.standard.synchronize();
        }
    }


    // 关闭提醒的版本号
    static var ignoreUpdateVersion:String {
        
        get {
            let value = UserDefaults.standard.string(forKey: "SCIgnoreUpdateVersion")
            return value ?? ""
        }
        
        set {
            UserDefaults.standard.set(newValue, forKey: "SCIgnoreUpdateVersion");
            UserDefaults.standard.synchronize();
        }
    }
    
    // 下次提醒的版本号
    static var ignoreUpdateNextVersion:Bool {
        
        get {
            let value = UserDefaults.standard.bool(forKey: "ignoreUpdateNextVersion")
            return value
        }
        
        set {
            UserDefaults.standard.set(newValue, forKey: "ignoreUpdateNextVersion");
            UserDefaults.standard.synchronize();
        }
    }
    ///标识是否使用备用的域名
    static var isUseBackUp: Bool {
        get {
            
            let value = UserDefaults.standard.bool(forKey: "SCIsUseBackUp");
            return value ;
        }
        
        set {
            UserDefaults.standard.set(newValue, forKey: "SCIsUseBackUp");
            UserDefaults.standard.synchronize();
        }
    }
    
    ///域名
    static var AppDomain: String {
        get {
            
            let value = UserDefaults.standard.string(forKey: "SCAppDomain");
            return value ?? "zeotu.com";
        }
        
        set {
            UserDefaults.standard.set(newValue, forKey: "SCAppDomain");
            UserDefaults.standard.synchronize();
        }
    }

   
    
    // 如果苹果商店审核，只开放 ,审核过后，开放所有
    static var isAppStoreCheck:Bool {
        
        get {
            let value = UserDefaults.standard.bool(forKey: "SCIsAppStoreCheck")
            return value
        }
        
        set {
            UserDefaults.standard.set(newValue, forKey: "SCIsAppStoreCheck");
            UserDefaults.standard.synchronize();
        }
    }
    
    // 如果苹果商店版本，用户自己操作开启专业版本
    static var isAppStoreUserSet:Bool {
        
        get {
            let value = UserDefaults.standard.bool(forKey: "SCIsAppStoreUserSet")
            return value
        }
        
        set {
            UserDefaults.standard.set(newValue, forKey: "SCIsAppStoreUserSet");
            UserDefaults.standard.synchronize();
        }
    }
    
    //标识是否弹出广告
    static var isPopPosterView:Bool {
        
        get {
            let value = UserDefaults.standard.bool(forKey: "SCIsPopPosterView")
            return value
        }
        
        set {
            UserDefaults.standard.set(newValue, forKey: "SCIsPopPosterView");
            UserDefaults.standard.synchronize();
            print("\(newValue)")
        }
    }

    
    
    //是否隐藏全部已读，站内信 公告
    static var isHiddenPublicIsRead:Bool {
        
        get {
            let value = UserDefaults.standard.bool(forKey: "SCIsHiddenPublicIsRead")
            return value
        }
        
        set {
            UserDefaults.standard.set(newValue, forKey: "SCIsHiddenPublicIsRead");
            UserDefaults.standard.synchronize();
        }
    }
    
    //是否隐藏全部已读，站内信 活动
    static var isHiddenActivityIsRead:Bool {
        
        get {
            let value = UserDefaults.standard.bool(forKey: "SCIsHiddenActivityIsRead")
            return value
        }
        
        set {
            UserDefaults.standard.set(newValue, forKey: "SCIsHiddenActivityIsRead");
            UserDefaults.standard.synchronize();
        }
    }
    

    ///记录站内信的时间戳
    static var zbInfoTimeStamp: String {
        get {
            
            let value = UserDefaults.standard.string(forKey: "SCzbInfoTimeStamp");
            return value ?? "";
        }
        
        set {
            UserDefaults.standard.set(newValue, forKey: "SCzbInfoTimeStamp");
            UserDefaults.standard.synchronize();
        }
    }
    
    ///记录站内信第一次安装的处理
    static var isZbInfoFirstInstall:Bool {
        
        get {
            let value = UserDefaults.standard.bool(forKey: "SCIsZbInfoFirstInstall")
            return value
        }
        
        set {
            UserDefaults.standard.set(newValue, forKey: "SCIsZbInfoFirstInstalld");
            UserDefaults.standard.synchronize();
        }
    }
    
    /// 开屏广告下标数据
    static var fullScreenIndex: String {
        get {
            let value = UserDefaults.standard.value(forKey: "SCfullScreenIndex") as? String
            return value ?? "0";
        }
        
        set {
            UserDefaults.standard.set(newValue, forKey: "SCfullScreenIndex")
            UserDefaults.standard.synchronize();
        }
    }
    
    
    /// 记录站内信跳转母页
    static var ZbInfoWindowIndex:Int {
        
        get {
            let value = UserDefaults.standard.integer(forKey: "SCZbInfoWindowIndex")
            return value
        }
        
        set {
            UserDefaults.standard.set(newValue, forKey: "SCZbInfoWindowIndex");
            UserDefaults.standard.synchronize();
        }
    }
    
    //标识是否点击了开屏广告
    static var isClickFullView:Bool {
        
        get {
            let value = UserDefaults.standard.bool(forKey: "SCIsClickFullView")
            return value
        }
        
        set {
            UserDefaults.standard.set(newValue, forKey: "SCIsClickFullView");
            UserDefaults.standard.synchronize();
        }
    }

    ///记录开屏跳转
    static var isZbInfoFull:Bool {
        
        get {
            let value = UserDefaults.standard.bool(forKey: "SCIsZbInfoFull")
            return value
        }
        
        set {
            UserDefaults.standard.set(newValue, forKey: "SCIsZbInfoFull");
            UserDefaults.standard.synchronize();
        }
    }
    
    /// 记录弹窗弹出此次
    static var ZbInfoWindowNum:Int {
        
        get {
            let value = UserDefaults.standard.integer(forKey: "SCZbInfoWindowNum")
            return value
        }
        
        set {
            UserDefaults.standard.set(newValue, forKey: "SCZbInfoWindowNum");
            UserDefaults.standard.synchronize();
        }
    }
    
   
    
    // 是否为横版，否则为竖版
    static var isHorizontalForSpot:Bool {
        get {
            let value = UserDefaults.standard.bool(forKey: "SCisHorizontalForSpot")
            return value
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "SCisHorizontalForSpot");
            UserDefaults.standard.synchronize();
        }
    }
    
    // 是否为横版，否则为竖版
    static var isHorizontalForLever:Bool {
        get {
            let value = UserDefaults.standard.bool(forKey: "SCisHorizontalForLever")
            return value
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "SCisHorizontalForLever");
            UserDefaults.standard.synchronize();
        }
    }
    
    /// 长链接URL
    static var wsNetWorkUrl: String
    {
        get {
            let value = UserDefaults.standard.value(forKey: "wsNetWorkUrl") as? String
            return value ?? "";
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "wsNetWorkUrl")
            UserDefaults.standard.synchronize();
        }
    }
    
    /// 长链接URL
    static var userMarkets: [String]
    {
        get {
            let value = UserDefaults.standard.value(forKey: "userMarkets") as? [String]
            return value ?? []
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "userMarkets")
            UserDefaults.standard.synchronize();
        }
    }
    
}
