//
//  FormVC.swift
//  formularz
//
//  Created by Black Thunder on 08.11.2016.
//  Copyright © 2016 Krzysztof Lech. All rights reserved.
//

import UIKit
import CoreData

class FormVC: UIViewController {
    
    // MARK:- Outlets
    /// -----------------------------------------------------------------------------------
    
    @IBOutlet weak var imieTextField: UITextField!
    @IBOutlet weak var nazwiskoTextField: UITextField!
    @IBOutlet weak var stanowiskoTextField: UITextField!
    @IBOutlet weak var firmaTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var telefonTextField: UITextField!
    @IBOutlet weak var dataSpotkaniaTextField: UILabel!
    @IBOutlet weak var zgoda1Button: UIButton!
    @IBOutlet weak var zgoda2Button: UIButton!
    @IBOutlet weak var datePickerContainer: UIView!
    @IBOutlet weak var zapiszButton: UIButton!
    
    
    // MARK:- Properties
    /// -----------------------------------------------------------------------------------
    
    var managedContext: NSManagedObjectContext!
    var person: NSManagedObject!
    
    var newEntry = true
    
    var zgoda1 = true {
        didSet {
            if zgoda1 == true {
                zgoda1Button.setImage(#imageLiteral(resourceName: "ptaszek"), for: .normal)
            } else {
                zgoda1Button.setImage(nil, for: .normal)
            }
        }
    }
    
    var zgoda2 = true {
        didSet {
            if zgoda2 == true {
                zgoda2Button.setImage(#imageLiteral(resourceName: "ptaszek"), for: .normal)
            } else {
                zgoda2Button.setImage(nil, for: .normal)
            }
        }
    }
    
    var data: Date? {
        didSet {
            let dataLabel = changeDateTypeToString(date: data!)
            dataSpotkaniaTextField.text = dataLabel
            dataSpotkaniaTextField.textColor = UIColor.black
        }
    }
    
    
    // MARK:- System Methods
    /// -----------------------------------------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // CoreData setup
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        managedContext = appDelegate.persistentContainer.viewContext
        
        // jeśli jest to nowy wpis to deklarujemy obiekt 'person'
        if newEntry {
            let entity = NSEntityDescription.entity(forEntityName: "Osoba", in: managedContext)!
            person = NSManagedObject(entity: entity, insertInto: managedContext)
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // ustawiamy śledzenie TAPnięcia - w celu schowania klawiatury po dotknięciu w ekran poza TextField
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard)))
        
        // jeśli edytujemy dane, to zapisujemy je do odpowiednich pól formularza
        if !newEntry {
            readDataAndWriteToForm()
        } else {
            // jeśli zaczynamy od pustego formularza, to chowamy przycisk Zapisz
            zapiszButton.alpha = 0
        }
    }
    
    

    // MARK:- Action Methods
    /// -----------------------------------------------------------------------------------
    
    
    @IBAction func selectedDateButton(_ sender: UIButton) {
        datePickerAnimation(show: true)
    }

    @IBAction func selectedApproval1(_ sender: UIButton) { zgoda1 = !zgoda1 }

    @IBAction func selectedApproval2(_ sender: UIButton) { zgoda2 = !zgoda2 }

    // zakończenie wpisywania danych do formularza
    @IBAction func selectedWriteButton(_ sender: UIButton) {
        readDataFromFormAndWriteToCoreData()
        dismiss(animated: true, completion: nil)
    }
    
    
    // MARK:- Segue Method
    /// -----------------------------------------------------------------------------------
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DatePickerSegue" {
            let vc = segue.destination as! DatePickerVC
            vc.delegate = self
        }
    }
    
    
    // MARK: - CoreData Methods
    /// -----------------------------------------------------------------------------------

    func setCoreDataAttributes(attribute: Any?, name: String) {
        person.setValue(attribute, forKeyPath: name)
    }
    
    
    func saveCoreData() {
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    
    // MARK: - Other Methods
    /// -----------------------------------------------------------------------------------
    
    // odczyt przekazanych danych i zapisanie istniejących wpisów w odpowiednie miejsca
    func readDataAndWriteToForm() {
        if let imie          = person.value(forKeyPath: "imie") as? String { imieTextField.text = imie}
        if let nazwisko      = person.value(forKeyPath: "nazwisko") as? String  { nazwiskoTextField.text = nazwisko }
        if let stanowisko    = person.value(forKeyPath: "stanowisko") as? String  { stanowiskoTextField.text = stanowisko }
        if let firma         = person.value(forKeyPath: "firma") as? String  { firmaTextField.text = firma }
        if let email         = person.value(forKeyPath: "email") as? String  { emailTextField.text = email }
        if let telefon       = person.value(forKeyPath: "telefon") as? String  { telefonTextField.text = telefon }
        if let dataSpotkania = person.value(forKeyPath: "data") as? Date { data = dataSpotkania }
        if let zgoda         = person.value(forKeyPath: "zgoda1") as? Bool  { zgoda1 = zgoda }
        if let zgoda         = person.value(forKeyPath: "zgoda2") as? Bool  { zgoda2 = zgoda }
    }
    
    // odczyt danych z formularza i zapis w CoreData
    func readDataFromFormAndWriteToCoreData() {
        setCoreDataAttributes(attribute: imieTextField.text, name: "imie")
        setCoreDataAttributes(attribute: nazwiskoTextField.text, name: "nazwisko")
        setCoreDataAttributes(attribute: stanowiskoTextField.text, name: "stanowisko")
        setCoreDataAttributes(attribute: firmaTextField.text, name: "firma")
        setCoreDataAttributes(attribute: emailTextField.text, name: "email")
        setCoreDataAttributes(attribute: telefonTextField.text, name: "telefon")
        setCoreDataAttributes(attribute: data, name: "data")
        setCoreDataAttributes(attribute: zgoda1, name: "zgoda1")
        setCoreDataAttributes(attribute: zgoda2, name: "zgoda2")
        
        saveCoreData()
    }
    
    
    // metoda zamienia datę z postaci Date na String
    func changeDateTypeToString(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = NSLocale(localeIdentifier: "PL") as Locale!
        formatter.dateStyle = .short
        let dateString = formatter.string(from: date)
        return dateString
    }
    
    // chowanie klawiatury po dotknięciu poza pole tekstowe
    func dismissKeyboard() {
        view.endEditing(true)
    }

}

// MARK: - TextField Methods
/// -----------------------------------------------------------------------------------

extension FormVC: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        // sprawdzono czy pola Imię i Nazwisko są wypełnione, jeśli tak to włączamy przycisk Zapisz
        if let imie = imieTextField.text, let nazwisko = nazwiskoTextField.text {
            if imie != "" && nazwisko != "" {
                zapiszButton.alpha = 1
            }
        }
    }
    
    // chowamy klawiaturę po wciśnięciu klawisza Return
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
}

// MARK: - DatePicker Methods
/// -----------------------------------------------------------------------------------
extension FormVC: DatePickerDelegate {
    
    // zapisujemy datę otrzymaną z DatePickera
    func didSelectDate(date: Date) {
        data = date
        datePickerAnimation(show: false)
    }
    
    // pokzujemy obiekt DatePicker
    func datePickerAnimation(show: Bool) {
        

        if show {
            let viewWidth = view.frame.size.width
            let containerWidth = datePickerContainer.bounds.size.width
            let containerPosition = datePickerContainer.center.x
            let translation = viewWidth - containerPosition + containerWidth / 2
            
            // przesuwamy obiekt poza ekran i pokazujemy go
            datePickerContainer.center.x += translation
            datePickerContainer.alpha = 1.0
            
            // przesuwamy obiekt na ekran w formie animacji
            UIView.animate(withDuration: 0.4,
                           delay: 0.0,
                           options: .curveEaseOut,
                           animations: {
                            self.datePickerContainer.center.x -= translation
            })
            
        } else {
            
            // chowamy obiekt w formie animacji
            UIView.animate(withDuration: 0.4,
                           delay: 0.0,
                           options: .curveEaseIn,
                           animations: {
                            self.datePickerContainer.alpha = 0
            })
        }
    }
}
