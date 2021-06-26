//
//  APIDataTableViewController.swift
//  FinalProject_2
//
//  Created by user182505 on 12/11/20.
//  Copyright © 2020 user182505. All rights reserved.
//

import UIKit

class APIDataTableViewController: UITableViewController ,UISearchBarDelegate,ServiceDelegate{

  
        var city : [String] = [String]()
        override func viewDidLoad() {
            super.viewDidLoad()

        }

        func ServiceDelegateDidFinishWithList(list: [String]) {
              DispatchQueue.main.async {
                self.city = list
                self.tableView.reloadData()
            }
        }
        
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
                print(searchText)
            Service.shared.delegate = self
            Service.shared.fetchJSONData(key: searchText)
        }
    override func numberOfSections(in tableView: UITableView) -> Int {
            
            return 1
        }

        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            
            return city.count
        }

        
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)


            let cityData = city[indexPath.row].components(separatedBy: ",")
            if(cityData.count>1){
                print(city[indexPath.row])
                cell.textLabel?.text = cityData[0]
                cell.detailTextLabel?.text = cityData[2]
            }else{
                cell.textLabel?.text = ""
                cell.detailTextLabel?.text = ""
            }
            return cell
        }
        
        
       override  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
            let cityData = city[indexPath.row].components(separatedBy: ",")
            print(cityData[0])
            save(city: cityData[0], country: cityData[2])
            
        }
        
        func save(city:String,country:String){
            
            let alert = UIAlertController.init(title: "Save \(city) ?", message: "Do you want to add \(city) into your Phone Memory ?", preferredStyle: .alert)
                   var textField = UITextField()
                   
                   let saveDataAction = UIAlertAction.init(title: "Save", style: .default) { (action) in
                     
                    CoreData.shared.insertCity(city: city,country:country)
                    self.navigationController?.popViewController(animated: true)
                    }
                   let cancelAction = UIAlertAction.init(title: "Cancel", style: .default) { (action) in
                       self.dismiss(animated: true, completion: nil)
                       }
                       
                   alert.addAction(saveDataAction)
                   alert.addAction(cancelAction)
                   present(alert, animated: true, completion: nil)
            
        }
        
        
        
    }

