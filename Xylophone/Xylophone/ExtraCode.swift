//
//  ExtraCode.swift
//  Xylophone
//
//  Created by Emmett Shaughnessy on 10/25/21.
//

import Foundation
import UIKit

typealias number = Int

let defaults = UserDefaults.standard


enum note{
    case A
    case B
    case C
    case D
    case E
    case F
    case G
}






//MARK: - RGB Color Struct
/// Color data type. This data type has three attributes and one action.
struct RGB_Color {
    ///Red value on the RGB 256 scale
    var r:CGFloat = 0
    ///Green value on the RGB 256 scale
    var g:CGFloat = 0
    ///Blue value on the RGB 256 scale
    var b:CGFloat = 0
    
    ///Compiles the RGB values of the object
    ///- Returns: UIColor from the compiled RGB values
    func UIColor() -> UIColor{
        return UIKit.UIColor(red: r, green: g, blue: b, alpha: 1)
    }
    
    ///Compiles the RGB values of the object
    ///- Returns: UIColor from the compiled RGB values
    func getRGBColor() -> String{
//        return "\(String(format: "%.01f", r*256)), \(String(format: "%.01f", g*256)), \(String(format: "%.01f", b*256))"
        
        return "\(Int(r*256)), \(Int(g*256)), \(Int(b*256))"
    }
    
    ///Compiles the RGB values of the object
    ///- Returns: HEX string from the compiled RGB values
    func getHexColor() -> String {
        return UIKit.UIColor(red: r, green: g, blue: b, alpha: 1).toHexString()
    }
    
}

//MARK: - Convert to RGB_Color
extension UIColor{
    func RGB_Color() -> RGB_Color{
        let ciColor = CIColor(color: self)
        let alpha = ciColor.alpha
        let red = ciColor.red
        let blue = ciColor.blue
        let green = ciColor.green
        
        let newColor:RGB_Color = Xylophone.RGB_Color(r: red, g: green, b: blue)
        
        return newColor
    }
    
}


//MARK: - Hex String
extension UIColor {
    func toHexString() -> String {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0

        getRed(&r, green: &g, blue: &b, alpha: &a)

        let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0

        return NSString(format:"#%06x", rgb) as String
    }

    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")

        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }

}


//MARK: - Color Score
func displayScoreAsString(baseColor: RGB_Color, matchColor: RGB_Color) -> String{
    let rDiff = matchColor.r - baseColor.r
    let gDiff = matchColor.g - baseColor.g
    let bDiff = matchColor.b - baseColor.b
    
    let diff = sqrt(pow(rDiff, 2) + pow(gDiff, 2) + pow(bDiff, 2))
    let score:number = Int(((1-diff)*100))
    
    
    
    let scorePercent:number = abs(score) //absolute value of score
    
//        let displayScore = """
//                    Raw Score: \(score)
//                    Accuracy: \(scorePercent)%
//        """
            
    let displayScore = "Accuracy: \(scorePercent)%\n\nYour RGB: \(baseColor.getRGBColor())\nGoal RGB: \(matchColor.getRGBColor())"
    
    return displayScore
}

func displayScoreAsPercent(baseColor: RGB_Color, matchColor: RGB_Color) -> number{
    let rDiff = matchColor.r - baseColor.r
    let gDiff = matchColor.g - baseColor.g
    let bDiff = matchColor.b - baseColor.b
    
    let diff = sqrt(pow(rDiff, 2) + pow(gDiff, 2) + pow(bDiff, 2))
    let score:number = Int(((1-diff)*100))
    
    
    
    let scorePercent:number = abs(score) //absolute value of score
            
    
    return scorePercent
}

func displayScoreAsPercent(baseColor: RGB_Color, matchArray: [RGB_Color]) -> number{
    var scores:[number] = []
    for color in matchArray{
        let rDiff = color.r - baseColor.r
        let gDiff = color.g - baseColor.g
        let bDiff = color.b - baseColor.b
        
        let diff = sqrt(pow(rDiff, 2) + pow(gDiff, 2) + pow(bDiff, 2))
        let score:number = Int(((1-diff)*100))
        
        
        
        let scorePercent:number = abs(score) //absolute value of score
        scores.append(scorePercent)
    }
    
    var totalScore:number = 0
    for score in scores{
        totalScore += score
    }
    
    let finalScore = totalScore/scores.count
   
            
    
    return finalScore
}


//MARK: - Get Random Color
//Returns a random UIColor
func randomColor() -> RGB_Color{
    let r = Float.random(in: 0..<1)
    let g = Float.random(in: 0..<1)
    let b = Float.random(in: 0..<1)

    let randomColor = RGB_Color(r: CGFloat(r), g: CGFloat(g), b: CGFloat(b))
    
    return randomColor
}


//MARK: - Inverse Color
extension UIColor{
    func inverseColor() -> UIColor {
        var alpha: CGFloat = 1.0

        var red: CGFloat = 0.0, green: CGFloat = 0.0, blue: CGFloat = 0.0
        if self.getRed(&red, green: &green, blue: &blue, alpha: &alpha) {
            return UIColor(red: 1.0 - red, green: 1.0 - green, blue: 1.0 - blue, alpha: alpha)
        }

        var hue: CGFloat = 0.0, saturation: CGFloat = 0.0, brightness: CGFloat = 0.0
        if self.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha) {
            return UIColor(hue: 1.0 - hue, saturation: 1.0 - saturation, brightness: 1.0 - brightness, alpha: alpha)
        }

        var white: CGFloat = 0.0
        if self.getWhite(&white, alpha: &alpha) {
            return UIColor(white: 1.0 - white, alpha: alpha)
        }

        return self
    }
}
