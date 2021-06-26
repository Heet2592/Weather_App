//
//  ServiceCities.swift
//  FinalProject_2
//
//  Created by user182505 on 12/11/20.
//  Copyright © 2020 user182505. All rights reserved.
//

import Foundation

protocol ServiceDelegate {
    func ServiceDelegateDidFinishWithList(list : [String])

}
class Service {

    static var shared = Service()
    
    var delegate : ServiceDelegate?
    
   // func fetchJSONData( completionHandler : @escaping ([String])->Void, searchText:String)  {
        func fetchJSONData(key:String)  {

    
                let url = URL(string: "http://gd.geobytes.com/AutoCompleteCity?q=\(key)")!
     
                        print(url)
        
                       let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                       
                           if let error = error {
                                print("error in url session")
                               print(error)
                               return
                           }
                           
                           // We want to ensure that we have a good HTTP response status
                           guard let httpResponse = response as? HTTPURLResponse,
                               (200...299).contains(httpResponse.statusCode)
                               else {
                                   // Show the URL and response status code in the debug console
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
                                
                                   let result = try decoder.decode([String].self, from: data)
                                self.delegate?.ServiceDelegateDidFinishWithList(list : result)

                                 
                                print("result in url session")
                                print(result)
            
                               }
                               catch {
                                    print("error exception in url session")
                                print(error)
                               }
                           }
                       }
                       
                     
                       task.resume()
                  
            }
        
    }
