//
//  SettingViewController.swift
//  Clock
//
//  Created by Nu-Ri Lee on 2017. 5. 15..
//  Copyright © 2017년 nuri lee. All rights reserved.
//

import UIKit
import GoogleMobileAds

class SettingViewController : UITableViewController, GADBannerViewDelegate{
    
    @IBOutlet weak var allHour: UISwitch!
    @IBOutlet weak var hideSeconds: UISwitch!
    
    
    @IBAction func allHourSwitch(_ sender: UISwitch) {
        if sender.isOn{
            UserDefaults.standard.set(true, forKey: "allHour");
        }else{
            UserDefaults.standard.set(false, forKey: "allHour");
        }
    }
    
    @IBAction func hideSecondsSwitch(_ sender: UISwitch) {
        if sender.isOn{
            UserDefaults.standard.set(true, forKey: "hideSeconds");
        }else{
            UserDefaults.standard.set(false, forKey: "hideSeconds");
        }
    }
    
    
    func settingInit(){
        
        //allHour
        if UserDefaults.standard.object(forKey: "allHour") as? Bool ?? false {
            allHour.isOn = true;
        }else{
            allHour.isOn = false;
        }
        
        //hideSeconds
        if UserDefaults.standard.object(forKey: "hideSeconds") as? Bool ?? false {
            hideSeconds.isOn = true;
        }else{
            hideSeconds.isOn = false;
        }
    }
    
    
    @IBAction func dismissButton(_ sender: Any) {
        let noti = Notification.init(name : Notification.Name(rawValue: "oriInit"));
        NotificationCenter.default.post(noti);
        UIApplication.shared.isStatusBarHidden = true;
        self.presentingViewController?.dismiss(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad();
        
        //UIScreen.main.brightness = 0.2;
//        
//        bannerView.delegate = self
//        bannerView.adUnitID = "ca-app-pub-8919920204791449/9304328977";
//        bannerView.rootViewController = self
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        settingInit();
        UIApplication.shared.isStatusBarHidden = false;
    }
    
    
    
    // MARK: - GADBannerViewDelegate
    // Called when an ad request loaded an ad.
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        print(#function)
    }
    
    // Called when an ad request failed.
    func adView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: GADRequestError) {
        print("\(#function): \(error.localizedDescription)")
    }
    
    // Called just before presenting the user a full screen view, such as a browser, in response to
    // clicking on an ad.
    func adViewWillPresentScreen(_ bannerView: GADBannerView) {
        print(#function)
    }
    
    // Called just before dismissing a full screen view.
    func adViewWillDismissScreen(_ bannerView: GADBannerView) {
        print(#function)
    }
    
    // Called just after dismissing a full screen view.
    func adViewDidDismissScreen(_ bannerView: GADBannerView) {
        print(#function)
    }
    
    // Called just before the application will background or terminate because the user clicked on an
    // ad that will launch another application (such as the App Store).
    func adViewWillLeaveApplication(_ bannerView: GADBannerView) {
        print(#function)
    }
    
    
    
    
}
