//
//  WeatherDataViewController.swift
//  FinalProject_2
//
//  Created by user182505 on 12/11/20.
//  Copyright © 2020 user182505. All rights reserved.
//

import UIKit

class WeatherDataViewController: UIViewController {

    @IBOutlet var humidity: UILabel!
    
    @IBOutlet var temperature: UILabel!
    
    @IBOutlet var feelsLike: UILabel!
    
    @IBOutlet var imageView: UIImageView!
    
    @IBOutlet var Condition: UILabel!
    
    @IBOutlet var City: UILabel!
    
    @IBOutlet var locationImg: UIImageView!
    
    var cityName : String?
    
   override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = cityName
        City.text = cityName
        fetchWeatherData()
        // Do any additional setup after loading the view.
    }
    
    func fetchWeatherData(){
            let manager = WeatherService()
        manager.fetchWeatherData(city: cityName ?? "", completionHandler: {
                (data) in
                DispatchQueue.main.async {
                    print("data in weather : \(data.name) ")
                    self.humidity.text = "\(data.main?.humidity ?? 0.0) %"
                    self.temperature.text = "\(data.main?.temp ?? 0.0) ˚C"
                    self.feelsLike.text = "\(data.main?.feelsLike ?? 0.0) ˚C "
                    self.Condition.text = "\(data.weather[0].main)"
                    
                    let weatherIcon = data.weather[0].icon
                    let iconUrl = URL(string: "https://openweathermap.org/img/wn/" + weatherIcon + "@2x.png")
                    
                    let iconLocation = URL(string: "https://cdn2.iconfinder.com/data/icons/bitsies/128/Location-64.png")
                    self.ImageThread(url1: iconUrl!,url2:iconLocation!)
                }
            }
        )
    }
    func ImageThread(url1 : URL,url2 : URL){
        DispatchQueue.global().async { [weak self] in
            
            if let ImageData = try? Data(contentsOf: url1){
                if let image = UIImage(data :ImageData){
                    DispatchQueue.main.async {
                        self?.imageView.image = image
                    }
                }
                
            }
            if let LocationImageData = try? Data(contentsOf: url2){
                           if let image1 = UIImage(data :LocationImageData){
                               DispatchQueue.main.async {
                                self?.locationImg.image = image1
                               }
                           }
                           
                       }
        }
        
    }

    

}
