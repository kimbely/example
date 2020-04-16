//
//  DecodeT.swift
//  store
//
//  Created by 金梅劉 on 2020/4/16.
//  Copyright © 2020 Eason Yang. All rights reserved.
//

import Foundation
struct DecodeT: Codable {
    var int :Int {
        didSet {
            let stringValue = String(int)
            let doubleValue = Double(int)
            if  stringValue != string {
                string = stringValue
            }else if doubleValue != double{
                double = doubleValue
            }
        }
    }
    
    var string:String {
        didSet {
            if let intValue = Int(string), intValue != int {
                int = intValue
            }else if let doubleValue = Double(string), doubleValue != double {
                double = doubleValue
            }
        }
    }
    
    var double:Double {
        didSet {
            let stringValue = String(double)
            let intValue = Int(double)
            if  stringValue != string {
                string = stringValue
            }else if intValue != int {
                int = intValue
            }
        }
    }
    init(from decoder: Decoder) throws {
        let singleValueContainer = try decoder.singleValueContainer()
        
        if let stringValue = try? singleValueContainer.decode(String.self)
        {
            string = stringValue
            int = Int(stringValue) ?? (Double(stringValue)?.toInt() ?? 0)
            double = Double(stringValue) ?? 0.0
            
        } else if let intValue = try? singleValueContainer.decode(Int.self)
        {
            int = intValue
            string = String(intValue);
            double = Double(intValue)
        }else if let doubleValue = try? singleValueContainer.decode(Double.self)
        {
            double = doubleValue
            string = String(doubleValue);
            int = doubleValue.toInt() ?? 0
        }else {
            int = 0
            string = ""
            double = 0.0
        }
    }
}
extension Double {
    // If you don't want your code crash on each overflow, use this function that operates on optionals
    // E.g.: Int(Double(Int.max) + 1) will crash:
    // fatal error: floating point value can not be converted to Int because it is greater than Int.max
    func toInt() -> Int? {
        if self > Double(Int.min) && self < Double(Int.max) {
            return Int(self)
        } else {
            return nil
        }
    }
}
