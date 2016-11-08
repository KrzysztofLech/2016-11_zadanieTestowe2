//
//  FirstVC.swift
//  formularz
//
//  Created by Black Thunder on 08.11.2016.
//  Copyright © 2016 Krzysztof Lech. All rights reserved.
//

import UIKit

class FirstVC: UIViewController, PersonDataSelectionDelegate {

    var entities = [Person]()
    @IBOutlet weak var tableView: UITableView!
    
    
    
    // MARK:- System Methods
    /// -----------------------------------------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()

        przypiszPrzykladoweDane()
    }

    
    
    // MARK:- Delegate & Segue Methods
    /// -----------------------------------------------------------------------------------
    
    func didSelectData(vc: UIViewController, data: Person) {
        
        // sprawdzamy czy otrzymany wpis jest nowy, czy był edytowany
        if (vc as! FormVC).newEntry {
            entities.append(data)
        } else {
            let entitiesIndex = tableView.indexPathForSelectedRow!
            entities[entitiesIndex.row] = data
        }
        
        tableView.reloadData()
        vc.dismiss(animated: true, completion: nil)
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! FormVC
        vc.delegate = self
        
        // przekazanie danych wpisu do edycji
        if segue.identifier == "EditEntrySegue" {
            
            if let entitiesIndex = tableView.indexPathForSelectedRow {
                vc.newEntry = false
                vc.person = entities[entitiesIndex.row]
            }
        }
    }
    
    
    // MARK: - Other Methods
    /// -----------------------------------------------------------------------------------
    
    func przypiszPrzykladoweDane() {
        
        let person = Person()
        person.imie =       "Adam"
        person.nazwisko =   "Kowalski"
        person.stanowisko = "Product Manager"
        person.firma =      "Connectmedica"
        person.email =      "adam.kowalski@connectmedica.com"
        person.telefon =    nil
        person.data =       nil
        person.zgoda1 =     true
        person.zgoda2 =     true
        
        entities.append(person)
    }
 
    
/*
    func pokazDane(person: Person) {
        print("Imię: \(person.imie)")
        print("Nazwisko: \(person.nazwisko)")
        print("Stanowsiko: \(person.stanowisko)")
        print("Firma: \(person.firma)")
        print("E-mail: \(person.email)")
        print("Telefon: \(person.telefon)")
        print("Data: \(person.data)")
        print("Zgoda1: \(person.zgoda1)")
        print("Zgoda2: \(person.zgoda2)")
    }
*/
    
}


// MARK:- Table View methods
/// -----------------------------------------------------------------------------------

extension FirstVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        if let imie = entities[indexPath.row].imie, let nazwisko = entities[indexPath.row].nazwisko {
            let text = imie + " " + nazwisko
            cell.textLabel?.text = text
        }
        return cell
    }
    
    
    
}
