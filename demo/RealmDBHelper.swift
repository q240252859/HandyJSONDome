//
//  RealmDBHelper.swift
//  chbtc
//
//  Created by mqt on 15/12/13.
//  Copyright © 2015年 bitbank. All rights reserved.
//

import UIKit
import RealmSwift

class RealmDBHelper: NSObject {
    /// **数据模型属性增加或删除时的数据迁移，每次模型属性变化时，将 dbVersion 加 1 即可，Realm 会自行检测新增和需要移除的属性，然后自动更新硬盘上的数据库架构，移除属性的数据将会被删除
    static let kRealmDBVersion: UInt64 = 3
    
    //数据库路径
    static var databaseFilePath: URL {
        let fileManager = FileManager.default
        var directoryURL = fileManager.urls(for: .cachesDirectory, in: .userDomainMask)[0]
        directoryURL = directoryURL.appendingPathComponent("api_cache_mode_data")
        
        if !fileManager.fileExists(atPath: directoryURL.path) {
            try! fileManager.createDirectory(atPath: directoryURL.path, withIntermediateDirectories: true, attributes: nil)
        }
        return directoryURL
    }
    
    /// 全局唯一实例
    static let sharedInstance: Realm = {
        // 通过配置打开 Realm 数据库
        var path = RealmDBHelper.databaseFilePath.appendingPathComponent("realmDB")
        path = path.appendingPathExtension("realm")
        let config = Realm.Configuration(fileURL: path,
                                         schemaVersion: RealmDBHelper.kRealmDBVersion,
                                         migrationBlock: { (migration, oldSchemaVersion) in
                                            if (oldSchemaVersion < RealmDBHelper.kRealmDBVersion) {
                                                //更新
                                            }
        })
        
        let realm = try! Realm(configuration: config)
        return realm
    }()
    
    
//    func updateToDB<T: RealmObject>(object: T) {
//        DispatchQueue.main.async {
//            try? RealmDBHelper.sharedInstance.write {
//                RealmDBHelper.sharedInstance.add(object, update: true)
//            }
//        }
//    }
//
//    func saveToDB<T: RealmObject>(objects: [T]) {
//        DispatchQueue.main.async {
//            try? RealmDBHelper.sharedInstance.write {
//                RealmDBHelper.sharedInstance.add(objects, update: true)
//            }
//        }
//    }
    
    public func delete<T: RealmObject>(object: T) {
        DispatchQueue.main.async {
            try? RealmDBHelper.sharedInstance.write {
                RealmDBHelper.sharedInstance.delete(object)
            }
        }
    }
    
    public func deleteAll() {
        DispatchQueue.main.async {
            try? RealmDBHelper.sharedInstance.write {
                RealmDBHelper.sharedInstance.deleteAll()
            }
        }
    }
    
    public func object<T: RealmObject>(primaryKey: String, doneHandle: @escaping (T?) -> Void) {
        DispatchQueue.main.async {
            let object = RealmDBHelper.sharedInstance.object(ofType: T.self, forPrimaryKey: primaryKey)
            doneHandle(object)
        }
    }
    
    public func select<T: RealmObject>(filter predicate: NSPredicate? = nil, doneHandle: @escaping ([T]) -> Void) {
        var result = RealmDBHelper.sharedInstance.objects(T.self)
        result = predicate == nil ? result : result.filter(predicate!)
        var objects = [T]()
        for objc in result {
            objects.append(objc)
        }
        doneHandle(objects)
    }
}

// MARK: - 扩展Results
extension Results {
    
    /**
     转为普通数组
     
     - returns:
//     */
//    func toArray() -> [T] {
//        var arr = [T]()
//        for obj in self {
//            arr.append(obj)
//        }
//        return arr
//    }
    
    /**
     转为普通数组
     
     - returns:
     */
    func toArray<T:Object>() -> [T] {
        var arr = [T]()
        for obj in self {
            arr.append(obj as! T)
        }
        return arr
    }
    
}

/**
 本类是由于想在Realm数据库中存储String数组,但是List<Object>中的Object只能是继承自Object类的才可以,所以创建了此类
 */
class RealmString: Object {
    
    @objc dynamic var str: String = ""
    
    override class func primaryKey() -> String? {
        return "str"
    }
    
    convenience init(with strValue: String) {
        self.init()
        str = strValue
    }
}

class RealmObject: Object {
    
//    func saveToDB() {
//        RealmDBHelper.sharedInstance.add(self, update: true)
//    }
    
//    func deleteFromDB() {
//        RealmDBHelper.sharedInstance.delete(self)
//    }
    
    
}
