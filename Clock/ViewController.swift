//
//  ViewController.swift
//  Clock
//
//  Created by Nu-Ri Lee on 2017. 4. 3..
//  Copyright © 2017년 nuri lee. All rights reserved.
//

import UIKit
import GoogleMobileAds

class ViewController: UIViewController, UIViewControllerTransitioningDelegate, GADInterstitialDelegate {
    
    
    var interstitial: GADInterstitial!
    
    
    let clock:Clock = Clock();
    
    //전역변수
    var timer:Timer?
    var count2:Int = 0;
    
    var Clock_font_size : CGFloat = 30;
    
    var fontWeight : CGFloat = 8.5;
    
    
    var temp : CGFloat = 0.0;
    
    
    
    let transition = CircularTransition();
    
    
    
    
    @IBOutlet weak var timeLabel: UILabel!
    
    
    func createAndLoadInterstitial()->GADInterstitial {
        let interstitial = GADInterstitial(adUnitID: "ca-app-pub-8919920204791449/2870782561")
        interstitial.delegate = self
        interstitial.load(GADRequest())
        
        return interstitial
    }
    
    var isShowAd = false;
    
    
    
    func showAds(){
        
        if ( isShowAd == false ){
            
            if self.interstitial.isReady {
                self.interstitial.present(fromRootViewController: self)
                //print("됨");
                isShowAd = true;
            } else {
                print("Ad wasn't ready")
                isShowAd = false;
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    
                    self.showAds();
                    
                }
                
            }//else
            
        }//if
        
    }//showAds()
    
    
    //앱 실행 이후
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        self.interstitial = self.createAndLoadInterstitial()
    
        
        showAds();
        
        
        
        
        labelTapPoint = view.center;
        
        // Do any additional setup after loading the view, typically from a nib.
        
        //화면꺼짐 방지
        UIApplication.shared.isIdleTimerDisabled = true
        
        UIApplication.shared.isStatusBarHidden = true;
        
        
        let tapGeustureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.labelTap(recognizer:)))
        tapGeustureRecognizer.numberOfTapsRequired = 1;
        timeLabel.isUserInteractionEnabled = true;
        timeLabel.addGestureRecognizer(tapGeustureRecognizer);
        
        
        font_size_check(ch : 1);
        
        font_resize(size: Clock_font_size);

        
        
        
        
        updateTimeLabel();
        
        
        //방송국 옵저버 등록
        let name = Notification.Name("fore");
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.updateTimeLabel), name: name, object: nil)
        
        let name2 = Notification.Name("oriInit");
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.orientationInit), name: name2, object: nil)

        startTimer();
        
        //최초 1회 실행
        let first = UserDefaults.standard.object(forKey: "first") as? Bool ?? false;
        
        if !first{
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                
                let alertController = UIAlertController(title: NSLocalizedString("app", comment: "app"), message: NSLocalizedString("info", comment: "info"), preferredStyle: .alert)
                
                
                let  okButton = UIAlertAction(title: NSLocalizedString("move", comment: "move"), style: .destructive, handler: { (action) -> Void in
                    self.performSegue(withIdentifier: "toSetting", sender: self);
                    
                })
                
                let cancelButton = UIAlertAction(title: NSLocalizedString("cancel", comment: "cancel"), style: .cancel, handler: { (action) -> Void in
                    //print("Cancel button tapped")
                })
                
                
                alertController.addAction(okButton)
                alertController.addAction(cancelButton)
                
                self.present(alertController, animated: true, completion: nil)
            }
            UserDefaults.standard.set(true, forKey: "first");
        }
    }
    
    
    
    var labelTapPoint : CGPoint!;
    //tap 제스쳐
    @objc func labelTap(recognizer : UITapGestureRecognizer){
        labelTapPoint = recognizer.location(in: view);
        //print(labelTapPoint);
        
        self.performSegue(withIdentifier: "toSetting", sender: self);
        
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toSetting" {
            let secondVC = segue.destination as! UINavigationController
            secondVC.transitioningDelegate = self as UIViewControllerTransitioningDelegate
            secondVC.modalPresentationStyle = .custom
        }
        
    }
    
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        transition.transitionMode = .present;
        transition.startingPoint = labelTapPoint;
        
        
        
        
        
        //다크모드 체크
        if #available(iOS 12.0, *) { //12버전 이상일때
            if self.traitCollection.userInterfaceStyle == .dark {
                // User Interface is Dark
                transition.circleColor = UIColor(red: 28 / 255.0, green: 28 / 255.0, blue: 30 / 255.0, alpha: 1.0);
            } else {
                // User Interface is Light
                transition.circleColor = UIColor(red: 239 / 255.0, green: 239 / 255.0, blue: 244 / 255.0, alpha: 1.0);
            }
        } else {
            // Fallback on earlier versions
            transition.circleColor = UIColor(red: 239 / 255.0, green: 239 / 255.0, blue: 244 / 255.0, alpha: 1.0);
        }
        
      
        
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .dismiss
        transition.startingPoint = labelTapPoint;
        
        
        //다크모드 체크
        if #available(iOS 12.0, *) {
            if self.traitCollection.userInterfaceStyle == .dark {
                // User Interface is Dark
                transition.circleColor = UIColor(red: 28 / 255.0, green: 28 / 255.0, blue: 30 / 255.0, alpha: 1.0);
            } else {
                // User Interface is Light
                transition.circleColor = UIColor(red: 239 / 255.0, green: 239 / 255.0, blue: 244 / 255.0, alpha: 1.0);
            }
        } else {
            // Fallback on earlier versions
        }
        
        return transition
        
    }
    
    var ccc : Int = 0;
    @objc func updateTimeLabel(){
        
        //print("updateTimeLabel");
        
        clock.reload_time();
        //timeLabel.text = clock.get_date();
        
        // hh : mm
        if UserDefaults.standard.object(forKey: "allHour") as? Bool ?? false && UserDefaults.standard.object(forKey: "hideSeconds") as? Bool ?? false{
            if ccc == 0{
                //기본
                timeLabel.text = clock.get_hhour() + " : " + clock.get_minute()
                ccc = 1;
            }else{
                timeLabel.text = clock.get_hhour() + "   " + clock.get_minute()
                ccc = 0;
            }
            
        }else if ((UserDefaults.standard.object(forKey: "allHour") as? Bool ?? false) == true && UserDefaults.standard.object(forKey: "hideSeconds") as? Bool ?? false == false){
            // hh : mm : ss
            timeLabel.text = clock.get_hhour() + " : " + clock.get_minute() + " : " + clock.get_seconds()
            
        }else if ((UserDefaults.standard.object(forKey: "allHour") as? Bool ?? false) == false && UserDefaults.standard.object(forKey: "hideSeconds") as? Bool ?? false == true){
            // h : mm a
            if ccc == 0{
                //기본
                timeLabel.text = clock.get_hour() + " : " + clock.get_minute() + " " + clock.get_ampm()
                ccc = 1;
            }else{
                timeLabel.text = clock.get_hour() + "   " + clock.get_minute() + " " + clock.get_ampm()
                ccc = 0;
            }
            
        }else{
            timeLabel.text = clock.get_hour() + " : " + clock.get_minute() + " : " + clock.get_seconds() + " " + clock.get_ampm();
        }
        
      
        
    }
    
    
    //실행 다된 직전
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        
//        
//        //네이게이션바 숨기기
//        self.navigationController?.isNavigationBarHidden = true;
    }

    //실행 된후
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    
    //떠나기 직전
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //NSLog("willAppear");
    }
    
    
    //떠난 후
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NSLog("didappear");
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
        
    }
    
    
    func startTimer(){
        
        timer = Timer.scheduledTimer(timeInterval:0.5, target: self, selector: #selector(self.update), userInfo: nil, repeats: true);
    }
    
    @objc func update(){
        //0.1초마다 반복
        
        
        
        updateTimeLabel();

        
        
        //self.stopTimer(t_el : timer!);
        
    }
    
    func stopTimer(t_el:Timer){
        t_el.invalidate()
        // t_el = nil
    }

    
    
    
    func font_size_check(ch : Int)
    {
        
        
        if UserDefaults.standard.object(forKey: "allHour") as? Bool ?? false && UserDefaults.standard.object(forKey: "hideSeconds") as? Bool ?? false{
            fontWeight = 4.5;
            
        }else if ((UserDefaults.standard.object(forKey: "allHour") as? Bool ?? false) == true && UserDefaults.standard.object(forKey: "hideSeconds") as? Bool ?? false == false){
            fontWeight = 7.0;
        }else if ((UserDefaults.standard.object(forKey: "allHour") as? Bool ?? false) == false && UserDefaults.standard.object(forKey: "hideSeconds") as? Bool ?? false == true){
            fontWeight = 6.5;
            
        }else{
            fontWeight = 8.5;
        }
        
        
        //screen
        let screenSize = UIScreen.main.bounds;
        let screenSizeWidth = screenSize.width;
        let screenSizeHeight = screenSize.height;
        
        if ch == 1{
            if screenSizeWidth >= screenSizeHeight{
                //가로
                Clock_font_size = screenSizeWidth/(fontWeight-1);
                //print("가로");
            }else{
                //세로
                Clock_font_size = screenSizeWidth/(fontWeight-1);
                //print("세로");
            }
        }else{
            Clock_font_size = screenSizeHeight/(fontWeight-1);
        }
        
    
    }
    
    func font_resize(size : CGFloat)
    {
        timeLabel.font = timeLabel.font.withSize(size);
    }
    
    //회전 유무
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator)
    {
        
        //screen
//        let screenSize = UIScreen.main.bounds;
//        let screenSizeWidth = screenSize.width;
//        let screenSizeHeight = screenSize.height;
//        
//        print("width - ");
//        print(screenSizeWidth);
//        print("height - ");
//        print(screenSizeHeight);
//        print("---");
    
        
        
        
        if temp == size.width
        {
            
        }else{
            temp = size.width;
            
            //폰일땐 반대
            if UIDevice.current.userInterfaceIdiom == .phone{
                font_size_check(ch : 2);
            }else{
                font_size_check(ch : 1);
            }
            
            font_resize(size: Clock_font_size);
        }
    }
    
    @objc func orientationInit(){
       
        font_size_check(ch : 1);
        font_resize(size: Clock_font_size);
        
    }
    
    
    /// Tells the delegate an ad request succeeded.
    func interstitialDidReceiveAd(_ ad: GADInterstitial) {
        print("interstitialDidReceiveAd")
    }
    
    /// Tells the delegate an ad request failed.
    func interstitial(_ ad: GADInterstitial, didFailToReceiveAdWithError error: GADRequestError) {
        print("interstitial:didFailToReceiveAdWithError: \(error.localizedDescription)")
    }
    
    /// Tells the delegate that an interstitial will be presented.
    func interstitialWillPresentScreen(_ ad: GADInterstitial) {
        print("interstitialWillPresentScreen")
    }
    
    /// Tells the delegate the interstitial is to be animated off the screen.
    func interstitialWillDismissScreen(_ ad: GADInterstitial) {
        print("interstitialWillDismissScreen")
    }
    
    /// Tells the delegate the interstitial had been animated off the screen.
    func interstitialDidDismissScreen(_ ad: GADInterstitial) {
        print("interstitialDidDismissScreen")
    }
    
    /// Tells the delegate that a user click will open another app
    /// (such as the App Store), backgrounding the current app.
    func interstitialWillLeaveApplication(_ ad: GADInterstitial) {
        print("interstitialWillLeaveApplication")
    }
    
    
    
    
    

}

