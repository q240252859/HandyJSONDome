//
//  ViewController.swift
//  demo
//
//  Created by luoming on 2019/12/3.
//  Copyright © 2019 SingleVideo. All rights reserved.
//

import UIKit
 
@_exported import HandyJSON
@_exported import RealmSwift




class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //请求数据
        RemoteService.sharedInstance.marketData("101010100") { (BaseModel
            , HomeModel) in
            
        }
        
   
         test()
        
        
    }


}




func test() -> Void {
    
    let jsonString = "{\"code\":\"000000\",\"description\":\"success\",\"data\":[{\"flag\":\"nerUser\",\"phone\":\"18739966912\",\"nick\":\"moqigogo\",\"gender\":\"1\",\"birthday\":\"19900412\",\"avatar\":\"touxiangurl\",\"accessToken\":\"12123293829147318412fjer\",\"refreshToken\":\"28198e1euiwhdjs\",\"whiteListStatus\":\"1\",\"userStatus\":\"2\",\"isSecurityPasswordExist\":\"1\",\"securityTime\":\"123131\"}]}"
    
    let baseData = BaseModel.deserialize(from: jsonString)
    let model = loginModel.deserialize(from: baseData?.data as?[String:Any])
    let model1 = [loginModel].deserialize(from: baseData?.data as?[Any])
    
    // 存储到数据
    let realmDB = RealmDBHelper.sharedInstance
    try? realmDB.write {
        for ticker in model1 ?? []{
            realmDB.add(ticker!, update:  .modified)
        }
    }
    
    
    
    
    print("--0-",model1?[0]?.accessToken ?? "")
    
    
//    DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
        let model2 = loginModel.getLoginModelArrData()
        print("--1-",model2[0].accessToken)
//    }
    
    let model3 = loginModel.getDetailData(accessToken: model2[0].accessToken)
    
    print("--2-",model3?.accessToken ?? "")
    
    
    print("--3-",realmDB.configuration.fileURL ?? "")
    
    
    
 
}
