//
//  Clock.swift
//  Clock
//
//  Created by Nu-Ri Lee on 2017. 4. 3..
//  Copyright © 2017년 nuri lee. All rights reserved.
//

import Foundation

class Clock {
    
    
    var date:Date = Date();
    
    //포멧 시간
    var form = DateFormatter();
    
    var dateType:String = "";
    
    
    var stringDate:String = "";
    
    
    init(){
        form.amSymbol="AM";
        form.pmSymbol = "PM";
        dateType = "h : mm : ss a";
        form.dateFormat = dateType;
        stringDate = form.string(from: date);
    }
    
    func reload_time(){
        date = Date();
        form.amSymbol="AM";
        form.pmSymbol = "PM";
        form.dateFormat = dateType;
        stringDate = form.string(from: date);
    }
    
    func get_hhour()->String{
        var temp:String = "";
        form.dateFormat = "hh";
        temp = form.string(from: date);
        return temp;
    }
    
    func get_hour()->String{
        var temp:String = "";
        form.dateFormat = "h";
        temp = form.string(from: date);
        return temp;
    }
    
    func get_minute()->String{
        var temp:String = "";
        form.dateFormat = "mm";
        temp = form.string(from: date);
        return temp;
    }
    
    func get_seconds()->String{
        var temp:String = "";
        form.dateFormat = "ss";
        temp = form.string(from: date);
        return temp;
    }
    
    func get_ampm()->String{
        var temp:String = "";
        form.dateFormat = "a";
        temp = form.string(from: date);
        return temp;
    }
    
    func get_date()->String{
        form.dateFormat = dateType;
        return stringDate;
    }
    
    
    
}
