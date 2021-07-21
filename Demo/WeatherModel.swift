//
//  WeatherModel.swift
//  Demo
//
//  Created by Zimble on 21/07/21.
//

import Foundation

class WeatherModel : NSObject, NSCoding{

    var feelsLike : Double!
    var grndLevel : Int!
    var humidity : Int!
    var pressure : Int!
    var seaLevel : Int!
    var temp : Double!
    var tempMax : Double!
    var tempMin : Double!


    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    
    override init() {
        
    }
    init(fromDictionary dictionary: [String:Any]){
        feelsLike = dictionary["feels_like"] as? Double
        grndLevel = dictionary["grnd_level"] as? Int
        humidity = dictionary["humidity"] as? Int
        pressure = dictionary["pressure"] as? Int
        seaLevel = dictionary["sea_level"] as? Int
        temp = dictionary["temp"] as? Double
        tempMax = dictionary["temp_max"] as? Double
        tempMin = dictionary["temp_min"] as? Double
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if feelsLike != nil{
            dictionary["feels_like"] = feelsLike
        }
        if grndLevel != nil{
            dictionary["grnd_level"] = grndLevel
        }
        if humidity != nil{
            dictionary["humidity"] = humidity
        }
        if pressure != nil{
            dictionary["pressure"] = pressure
        }
        if seaLevel != nil{
            dictionary["sea_level"] = seaLevel
        }
        if temp != nil{
            dictionary["temp"] = temp
        }
        if tempMax != nil{
            dictionary["temp_max"] = tempMax
        }
        if tempMin != nil{
            dictionary["temp_min"] = tempMin
        }
        return dictionary
    }

    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        feelsLike = aDecoder.decodeObject(forKey: "feels_like") as? Double
        grndLevel = aDecoder.decodeObject(forKey: "grnd_level") as? Int
        humidity = aDecoder.decodeObject(forKey: "humidity") as? Int
        pressure = aDecoder.decodeObject(forKey: "pressure") as? Int
        seaLevel = aDecoder.decodeObject(forKey: "sea_level") as? Int
        temp = aDecoder.decodeObject(forKey: "temp") as? Double
        tempMax = aDecoder.decodeObject(forKey: "temp_max") as? Double
        tempMin = aDecoder.decodeObject(forKey: "temp_min") as? Double
    }

    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if feelsLike != nil{
            aCoder.encode(feelsLike, forKey: "feels_like")
        }
        if grndLevel != nil{
            aCoder.encode(grndLevel, forKey: "grnd_level")
        }
        if humidity != nil{
            aCoder.encode(humidity, forKey: "humidity")
        }
        if pressure != nil{
            aCoder.encode(pressure, forKey: "pressure")
        }
        if seaLevel != nil{
            aCoder.encode(seaLevel, forKey: "sea_level")
        }
        if temp != nil{
            aCoder.encode(temp, forKey: "temp")
        }
        if tempMax != nil{
            aCoder.encode(tempMax, forKey: "temp_max")
        }
        if tempMin != nil{
            aCoder.encode(tempMin, forKey: "temp_min")
        }
    }
}
