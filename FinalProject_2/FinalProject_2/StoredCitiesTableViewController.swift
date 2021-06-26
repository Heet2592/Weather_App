//
//  StoredCitiesTableViewController.swift
//  FinalProject_2
//
//  Created by user182505 on 12/11/20.
//  Copyright © 2020 user182505. All rights reserved.
//

import UIKit

class StoredCitiesTableViewController: UITableViewController {

    @IBOutlet var addBtn: UIBarButtonItem!
 
    @IBOutlet var searchBar: UISearchBar!
    
    var fetchResultsController = CoreData.shared.fetchResultsController
    
    var allCity : [CitiesStorage] = [CitiesStorage]()

        
        override func viewDidLoad() {
            super.viewDidLoad()
            fetchCityData()
            self.searchBar.delegate = self
            // Do any additional setup after loading the view.
        }
        
        func fetchCityData()  {
            try? fetchResultsController.performFetch()
            //allCity = CoreData.shared.fetchCityFromCoreData()
            tableView.reloadData()
        }
        
      override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            print("You have Clickecd on : \(indexPath.row)")
            let weatherDataViewController = storyboard?.instantiateViewController(identifier: "WeatherController") as? WeatherDataViewController
        weatherDataViewController?.cityName = fetchResultsController.object(at: indexPath).cityName
           self.navigationController?.pushViewController(weatherDataViewController!, animated: true)
                  
       }
      override func numberOfSections(in tableView: UITableView) -> Int {
          
        return fetchResultsController.sections?.count ?? 0
       }

     override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          
        return fetchResultsController.sections?[section].numberOfObjects ?? 0
       }

       
      override  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! StoredCitiesTableViewCell

        cell.setStoredCitiesData(entity: fetchResultsController.object(at: indexPath))
           return cell
       }
       
       // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
           
           return true
       }
       
       override func viewWillAppear(_ animated: Bool) {
              super.viewWillAppear(animated)
              
          fetchCityData()
         // tableView.reloadData()
           
       }
       override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
           if editingStyle == .delete {
              
              print("\(fetchResultsController.object(at: indexPath))")
               CoreData.shared.deleteCity(city: fetchResultsController.object(at: indexPath))
                 fetchCityData()
               
           }
       }

    }


    extension StoredCitiesTableViewController : UISearchBarDelegate{
        
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            if (searchText == ""){
                try? fetchResultsController.performFetch()
                tableView.reloadData();
                //fetchCityData()
            }
            else {
            
                //allCity = CoreData.shared.search(text: searchText)
                tableView.reloadData()
            }
        }
        
    }
