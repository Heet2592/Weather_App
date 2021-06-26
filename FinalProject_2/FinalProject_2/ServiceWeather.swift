//
//  ServiceWeather.swift
//  FinalProject_2
//
//  Created by user182505 on 12/12/20.
//  Copyright © 2020 user182505. All rights reserved.
//

import Foundation
class WeatherService {


    func fetchWeatherData(city:String, completionHandler : @escaping (WeatherDataModel)->Void )  {
        let url = URL(string: "http://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=65703597bef04f95cbba9320e99fd001&units=metric")!
        
        
        if(url == nil){
                    
                }else{
                        print(url)
        
                       let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                        
                           if let error = error {
                                print("error in url session")
                               print(error)
                               return
                           }
                        
                           guard let httpResponse = response as? HTTPURLResponse,
                               (200...299).contains(httpResponse.statusCode)
                               else {
                                  
                                   if let httpResponse = response as? HTTPURLResponse {
                                       print("URL: \(httpResponse.url!.path )\nStatus code: \(httpResponse.statusCode)")
                                   }
                                   return
                           }
                               if let data = data {
                               
                               // Create and configure a JSON decoder
                               let decoder = JSONDecoder()
                               decoder.dateDecodingStrategy = .iso8601
                        
                               do {
                                
                                   let result = try decoder.decode(WeatherDataModel.self, from: data)
                                   
                                print("result in url session")
                                print(result)
                               
                                   // Save the data
                                completionHandler(result)
                              
                                   
                               }
                               catch {
                                    print("error exception in url session")
                                print(error)
                               }
                           }
                       }
                       
                       // Now that "task" has been fully defined, execute it...
                       task.resume()
                  
            }
        
    }
    
}


