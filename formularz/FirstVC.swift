//
//  FirstVC.swift
//  formularz
//
//  Created by Black Thunder on 08.11.2016.
//  Copyright © 2016 Krzysztof Lech. All rights reserved.
//

import UIKit
import CoreData

class FirstVC: UIViewController {

    var entities: [NSManagedObject] = []
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var button: Przycisk1!
    
    
    
    // MARK:- System Methods
    /// -----------------------------------------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // metoda buttonTap generuje animację przycisku i wyzwala segue do FormVC
        button.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(buttonTap)))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        readCoreData()
        
        // jeśli jest to pierwsze uruchomienie to przypisujemy przykładowe dane
        if entities.count == 0 { przypiszPrzykladoweDane() }

        tableView.reloadData()
    }

    
    
    // MARK:- Segue Methods
    /// -----------------------------------------------------------------------------------
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! FormVC
        
        // przekazanie danych wpisu do edycji
        if segue.identifier == "EditEntrySegue" {
            
            if let entitiesIndex = tableView.indexPathForSelectedRow {
                vc.newEntry = false
                vc.person = entities[entitiesIndex.row]
            }
        }
    }
    

    // MARK: - CoreData Methods
    /// -----------------------------------------------------------------------------------

    func readCoreData() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Osoba")
        
        do {
            entities = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    
    
    func przypiszPrzykladoweDane() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Osoba", in: managedContext)!
        let person = NSManagedObject(entity: entity, insertInto: managedContext)
        
        person.setValue("Adam", forKeyPath: "imie")
        person.setValue("Kowalski", forKeyPath: "nazwisko")
        person.setValue("Product Manager", forKeyPath: "stanowisko")
        person.setValue("Connectmedica", forKeyPath: "firma")
        person.setValue("adam.kowalski@connectmedica.com", forKeyPath: "email")
        person.setValue(true, forKeyPath: "zgoda1")
        person.setValue(true, forKeyPath: "zgoda2")
        
        do {
            try managedContext.save()
            entities.append(person)
            
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    
    // MARK: - Other Methods
    /// -----------------------------------------------------------------------------------
    
    // metoda animuje przycisk i wywołuje segue do FormVC
    func buttonTap() {
        UIView.animate(withDuration: 0.2,
                       delay: 0.0,
                       usingSpringWithDamping: 0.2,
                       initialSpringVelocity: 0.0,
                       options: [],
                       animations: {
                        self.button.bounds.size.width += 50.0 },
                       completion: {_ in
                        self.performSegue(withIdentifier: "NewEntrySegue", sender: self)
        })
    }
  
}


// MARK:- Table View methods
/// -----------------------------------------------------------------------------------

extension FirstVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let entity = entities[indexPath.row]
        if let imie = entity.value(forKeyPath: "imie") as? String, let nazwisko = entity.value(forKeyPath: "nazwisko") as? String {
            let text = imie + " " + nazwisko
            cell.textLabel?.text = text
        }
        
        return cell
    }
}
