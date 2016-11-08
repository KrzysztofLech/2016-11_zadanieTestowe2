//
//  FormVC.swift
//  formularz
//
//  Created by Black Thunder on 08.11.2016.
//  Copyright © 2016 Krzysztof Lech. All rights reserved.
//

import UIKit

protocol PersonDataSelectionDelegate {
    func didSelectData(vc: UIViewController, data: Person)
}


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
    
    
    // MARK:- Properties
    /// -----------------------------------------------------------------------------------
    
    var person = Person()
    var newEntry = true
    
    var zgoda1 = true {
        didSet {
            if zgoda1 == true {
                zgoda1Button.setImage(#imageLiteral(resourceName: "ptaszek"), for: .normal)
                person.zgoda1 = true
            } else {
                zgoda1Button.setImage(nil, for: .normal)
                person.zgoda1 = false
            }
        }
    }
    
    var zgoda2 = true {
        didSet {
            if zgoda2 == true {
                zgoda2Button.setImage(#imageLiteral(resourceName: "ptaszek"), for: .normal)
                person.zgoda2 = true
            } else {
                zgoda2Button.setImage(nil, for: .normal)
                person.zgoda2 = false
            }
        }
    }
    
    var delegate: PersonDataSelectionDelegate! = nil
    
    
    
    
    // MARK:- System Methods
    /// -----------------------------------------------------------------------------------
    
    /*
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }*/
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // jeśli edytujemy dane, to zapisujemy je do odpowiednich pól formularza
        if !newEntry { readData() }
    }
    
    

    // MARK:- Action Methods
    /// -----------------------------------------------------------------------------------
    
    @IBAction func selectedDateButton(_ sender: UIButton) {
        datePickerContainer.alpha = 1.0
    }

    @IBAction func selectedApproval1(_ sender: UIButton) { zgoda1 = !zgoda1 }

    @IBAction func selectedApproval2(_ sender: UIButton) { zgoda2 = !zgoda2 }

    // zakończenie wpisywania danych do formularza
    @IBAction func selectedWriteButton(_ sender: UIButton) {
        readDataFromForm()
        //pokazDane()
        delegate.didSelectData(vc: self, data: person)
    }
    
    
    
    
    // MARK: - Other Methods
    /// -----------------------------------------------------------------------------------
    
    // odczyt przekazanych danych i zapisanie istniejących wpisów w odpowiednie miejsca
    func readData() {
        if let imie = person.imie { imieTextField.text = imie}
        if let nazwisko = person.nazwisko { nazwiskoTextField.text = nazwisko }
        if let stanowisko = person.stanowisko { stanowiskoTextField.text = stanowisko }
        if let firma = person.firma { firmaTextField.text = firma }
        if let email = person.email { emailTextField.text = email }
        if let telefon = person.telefon { telefonTextField.text = telefon }
        if let data = person.data {
            let formatter = DateFormatter()
            formatter.locale = NSLocale(localeIdentifier: "PL") as Locale!
            formatter.dateStyle = .short
            let dataString = formatter.string(from: data)
            dataSpotkaniaTextField.text = dataString
        }
        if let zgoda = person.zgoda1 { zgoda1 = zgoda }
        if let zgoda = person.zgoda2 { zgoda2 = zgoda }
    }
    
    // odczyt danych z formularza
    func readDataFromForm() {
        person.imie = imieTextField.text
        person.nazwisko = nazwiskoTextField.text
        person.stanowisko = stanowiskoTextField.text
        person.firma = firmaTextField.text
        person.email = emailTextField.text
        person.telefon = telefonTextField.text
        person.zgoda1 = zgoda1
        person.zgoda2 = zgoda2
    }
    
    
    

/*
    func pokazDane() {
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
