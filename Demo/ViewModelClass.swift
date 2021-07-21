//
//  ViewModelClass.swift
//  Demo
//
//  Created by Zimble on 21/07/21.
//

import Foundation
import UIKit

class ViewModelClass : NSObject {
    
    var model : Bindable<WeatherModel> = .init(WeatherModel())
   
    
    
//
//
    func getApiResponse() {
        
        NetworkManager().sendAsyncRequestWith(withUrl: "", withParam: nil, httpMethod: .get, showHud: false, fromController: nil) {[weak self] status, dict, message in
            
            guard let `self` = self else {return}
            
            if !status {
               print("Something wrong")
            }
            guard let data = dict else {return}
            let model = WeatherModel(fromDictionary: data)
            
            self.model.value = model
            
            
        }
        
    }
    
    func measureMentLbl(value : Double) -> String {
        
        let measurement = Measurement(value: value, unit: UnitTemperature.celsius)

        let measurementFormatter = MeasurementFormatter()
        measurementFormatter.unitStyle = .medium
        
        measurementFormatter.numberFormatter.maximumFractionDigits = 0
        measurementFormatter.unitOptions = .providedUnit

       return measurementFormatter.string(from: measurement)
        
    }
    
    
}
