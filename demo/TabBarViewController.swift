//
//  TabBarViewController.swift
//  chbtc
//
//  Created by mqt on 15/11/16.
//  Copyright © 2015年 bitbank. All rights reserved.
//

import UIKit
import Alamofire
import RealmSwift
import ESTabBarController_swift
import SnapKit

public func rgba(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat, _ ap:CGFloat) -> UIColor {
    return UIColor.init(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: ap)
}
public func RGBA(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat, _ ap:CGFloat) -> UIColor {
    return UIColor.init(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: ap)
}
let SSHei = UIScreen.main.bounds.size.height/667.0
let SSWid = UIScreen.main.bounds.size.width/375.0
//let SS_Wid(w) = UIScreen.main.bounds.size.width/375.0 * w

public func SS_Wid(w: CGFloat) -> CGFloat {
    return SSWid * w
}
class TabBarViewController: ESTabBarController {
    
    
    
    //tabbar项的字体大小
    var tabBarItemFontSize: CGFloat {
        return 8
        //        if DeviceUtils.isRuningOniPhone667() || DeviceUtils.isRuningOniPhone736() {
        //            return 13
        //        } else {
        //            return 12
        //        }
        
    }
    
   
    let manager = NetworkReachabilityManager()
    
    /// 首页Tab
    lazy var homeTabVC: UIViewController = {
        
        let ContentV = ExampleBasicContentView()
        
        let home = HoemViewController()
        //       let vi = ESTabBarItemContentView()
        let barItem = ESTabBarItem.init(ContentV, title: "首页".localized(), image: UIImage(named: "menu_ico_home")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal), selectedImage: UIImage(named: "menu_ico_home_active")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal), tag: 0)
        
        
        ContentV.titleLabel.snp.makeConstraints({ (make) in
            make.bottom.equalToSuperview().offset(-SS_Wid(w: 4))
            make.centerX.equalToSuperview()
            make.height.equalTo(SS_Wid(w: 11))
        })
        ContentV.imageView.snp.makeConstraints({ (make) in
            //            make.top.equalToSuperview().offset(SS_Wid(w: 4))
            make.top.equalToSuperview().offset(SS_Wid(w:11))
            make.centerX.equalToSuperview()
            //            make.width.equalTo(SS_Wid(w: 27))
            //            make.height.equalTo(SS_Wid(w: 27))
            make.width.equalTo(SS_Wid(w: 21.76))
            make.height.equalTo(SS_Wid(w: 20.36))
        })
        
        
        
        home.tabBarItem = barItem
        return home
    }()
    
    
    lazy var indexTabVC: UIViewController = {
        let index = UIViewController()
        let ContentV = ExampleBasicContentView()
        
        let barItem = ESTabBarItem.init(ContentV, title: "行情".localized(), image: UIImage(named: "menu_ico_market")?
            .withRenderingMode(UIImage.RenderingMode.alwaysOriginal), selectedImage: UIImage(named: "menu_ico_market_active")?
                .withRenderingMode(UIImage.RenderingMode.alwaysOriginal), tag: 1)
        
        
        
        ContentV.titleLabel.snp.makeConstraints({ (make) in
            make.bottom.equalToSuperview().offset(-SS_Wid(w: 4))
            make.centerX.equalToSuperview()
            make.height.equalTo(SS_Wid(w: 11))
        })
        ContentV.imageView.snp.makeConstraints({ (make) in
            //            make.top.equalToSuperview().offset(SS_Wid(w: 4))
            make.top.equalToSuperview().offset(SS_Wid(w:11))
            make.centerX.equalToSuperview()
            //            make.width.equalTo(SS_Wid(w: 27))
            //            make.height.equalTo(SS_Wid(w: 27))
            make.width.equalTo(SS_Wid(w: 18))
            make.height.equalTo(SS_Wid(w: 21))
        })
        
        
        index.tabBarItem = barItem
        return index
    }()
    
    
    lazy var exchangeTabVC: UIViewController = {
        let nvc = UIViewController()
        
        
        
        
        
        
        
        let ContentV = ExampleBasicContentView()
        
        let barItem = ESTabBarItem.init(ContentV, title: "交易".localized(), image: UIImage(named: "menu_ico_trans"), selectedImage: UIImage(named: "menu_ico_trans_active"), tag: 2)
        
        
        
        nvc.tabBarItem = barItem
        //        exchange.tabBarItem = barItem
        
        
        ContentV.titleLabel.snp.makeConstraints({ (make) in
            make.bottom.equalToSuperview().offset(-SS_Wid(w: 4))
            make.centerX.equalToSuperview()
            make.height.equalTo(SS_Wid(w: 11))
        })
        ContentV.imageView.snp.makeConstraints({ (make) in
            make.top.equalToSuperview().offset(SS_Wid(w: 11))
            //            make.top.equalToSuperview().offset(SS_Wid(w: 4))
            make.top.equalToSuperview().offset(SS_Wid(w:11))
            make.centerX.equalToSuperview()
            //            make.width.equalTo(SS_Wid(w: 27))
            //            make.height.equalTo(SS_Wid(w: 27))
            make.width.equalTo(SS_Wid(w: 17.32))
            make.height.equalTo(SS_Wid(w: 20))
        })
        
        
        
        return nvc
    }()
    
    
    
    /// 财务Tab
    lazy var financeTabVC: UIViewController = {
        let finance = UIViewController()
        let ContentV = ExampleBasicContentView()
        
        let barItem = ESTabBarItem.init(ContentV, title: "财务".localized(), image: UIImage(named: "menu_ico_asset"), selectedImage: UIImage(named: "menu_ico_asset_active"), tag: 3)
        
        barItem.image = UIImage(named: "menu_ico_asset")?
            .withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        barItem.selectedImage = UIImage(named: "menu_ico_asset_active")
        //        barItem.imageInsets = UIEdgeInsets(top: -self.tabBarItemPaddingBottom, left: 0, bottom: self.tabBarItemPaddingBottom, right: 0)
        barItem.title = "财务".localized()
        
        //        barItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -self.tabBarItemPaddingBottom)
        finance.tabBarItem = barItem
        
        
        ContentV.titleLabel.snp.makeConstraints({ (make) in
            make.bottom.equalToSuperview().offset(-SS_Wid(w: 4))
            make.centerX.equalToSuperview()
            make.height.equalTo(SS_Wid(w: 11))
        })
        ContentV.imageView.snp.makeConstraints({ (make) in
            //            make.top.equalToSuperview().offset(SS_Wid(w: 4))
            make.top.equalToSuperview().offset(SS_Wid(w:11))
            make.centerX.equalToSuperview()
            //            make.width.equalTo(SS_Wid(w: 27))
            //            make.height.equalTo(SS_Wid(w: 27))
            make.width.equalTo(SS_Wid(w: 20))
            make.height.equalTo(SS_Wid(w: 20))
        })
        
        return finance
    }()
    
    /// 账户Tab
    lazy var profileTabVC: UIViewController = {
        let profile = UIViewController()
        let ContentV = ExampleBasicContentView()
        let barItem = ESTabBarItem.init(ContentV, title: "账户".localized(), image: UIImage(named: "menu_ico_user"), selectedImage: UIImage(named: "menu_ico_user_active"), tag: 3)
        
        
        barItem.image = UIImage(named: "menu_ico_user")?
            .withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        barItem.selectedImage = UIImage(named: "menu_ico_user_active")?
            .withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        
        barItem.title = "账户".localized()
        //        barItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -self.tabBarItemPaddingBottom)
        profile.tabBarItem = barItem
        
        
        ContentV.titleLabel.snp.makeConstraints({ (make) in
            make.bottom.equalToSuperview().offset(-SS_Wid(w: 4))
            make.centerX.equalToSuperview()
            make.height.equalTo(SS_Wid(w: 11))
        })
        ContentV.imageView.snp.makeConstraints({ (make) in
            //            make.top.equalToSuperview().offset(SS_Wid(w: 4))
            make.top.equalToSuperview().offset(SS_Wid(w:11))
            make.centerX.equalToSuperview()
            //            make.width.equalTo(SS_Wid(w: 27))
            //            make.height.equalTo(SS_Wid(w: 27))
            make.width.equalTo(SS_Wid(w: 17))
            make.height.equalTo(SS_Wid(w: 22))
        })
        
        return profile
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //监听网络状态，新装用户可能存在延迟联网造成缓存下载失败
        self.manager?.listener = { status in
            switch status {
            case .reachable(_):
                break
            default: break
            }
        }
        
        self.manager?.startListening()
     }
    
    
    
    
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    /**
     配置UI
     */
    func setupUI() {
        
        //自定义tabbar的背景颜色和图标，只能是用代码设置才有效果
        //        self.tabBar.barTintColor = ZBStyle.zdefault.tabBarbgColor
        self.tabBar.isTranslucent = false
        self.tabBar.backgroundImage = UIImage.init()
        self.tabBar.shadowImage = UIImage.init()
        
        self.viewControllers?.removeAll()
        
        
        self.viewControllers?.append(self.homeTabVC)
        self.viewControllers?.append(self.indexTabVC)
        self.viewControllers?.append(self.exchangeTabVC)
         self.viewControllers?.append(self.financeTabVC)
        self.viewControllers?.append(self.profileTabVC)
      
        
        
        
        
    }
    
    
    
}

// MARK: - 重载方法
extension TabBarViewController {
    
    
    
}

//MARK: EX 配置
extension TabBarViewController{
    
}


class ExampleBasicContentView: ESTabBarItemContentView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        textColor = UIColor.init(white: 175.0 / 255.0, alpha: 1.0)
        highlightTextColor = UIColor.init(red: 254/255.0, green: 73/255.0, blue: 42/255.0, alpha: 1.0)
        iconColor = UIColor.init(white: 175.0 / 255.0, alpha: 1.0)
        highlightIconColor = UIColor.init(red: 24/255.0, green: 190/255.0, blue: 160/255.0, alpha: 1.0)
        
        backdropColor = ZBStyle.zdefault.tabBarbgColor
        highlightBackdropColor = ZBStyle.zdefault.tabBarSelectedBgColorB
        
        textColor = ZBStyle.zdefault.tabBarItemTextColor
        highlightTextColor = ZBStyle.zdefault.tabBarItemSelectedTextColor
        highlightIconColor = ZBStyle.zdefault.tabBarItemSelectedTextColor
        
        insets = UIEdgeInsets.init(top: -1, left: 0, bottom: 0, right: 0)
        titleLabel.font = UIFont.boldSystemFont(ofSize: SS_Wid(w: 8))
        itemContentMode = .alwaysOriginal
        
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

