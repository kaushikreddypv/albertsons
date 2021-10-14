//
//  ActivityManager.swift
//  Assignment
//
//  Created by Venkata, Kaushik on 10/13/21.
//

import Foundation

import UIKit
import NVActivityIndicatorView

class ActivityManager: NSObject {
    
    static let sharedInstance = ActivityManager()
    private var activityIndicatorView: NVActivityIndicatorView?
    
    private override init() {
        
    }
    
    private func getActivityIndicatoor() -> NVActivityIndicatorView? {
        if let topVC = UIApplication.getTopMostViewController() {
            let frame = CGRect(x: (topVC.view.frame.width / 2 - 30), y:  (topVC.view.frame.height / 2 - 30), width: 60, height: 60)
            let activityIndicatorView =  NVActivityIndicatorView(frame: frame, type: .ballClipRotateMultiple, color: .blue, padding: nil)
            self.activityIndicatorView = activityIndicatorView
            return activityIndicatorView
        }
        return nil
    }
    
    
    func showActivityIndicator()  {
        if let  actView = self.activityIndicatorView {
            actView.stopAnimating()
            self.activityIndicatorView = nil
            
        }
        if let topVC = UIApplication.getTopMostViewController() {
            if let actView = getActivityIndicatoor() {
                topVC.view.addSubview(actView)
                actView.startAnimating()
            }
            
        }
        
    }
    
    func hideActivityIndicator()  {
        if let  actView = self.activityIndicatorView {
            actView.stopAnimating()
            self.activityIndicatorView = nil
            
        }
        
    }
    
}

extension UIApplication {
    class func getTopMostViewController(base: UIViewController? = UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return getTopMostViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return getTopMostViewController(base: selected)
            }
        }
        if let presented = base?.presentedViewController {
            return getTopMostViewController(base: presented)
        }
        return base
    }
}
