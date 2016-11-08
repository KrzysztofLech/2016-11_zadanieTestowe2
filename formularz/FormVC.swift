//
//  FormVC.swift
//  formularz
//
//  Created by Black Thunder on 08.11.2016.
//  Copyright © 2016 Krzysztof Lech. All rights reserved.
//

import UIKit

class FormVC: UIViewController {

    var person = Person()
    
    
    // MARK:- Outlets
    
    @IBOutlet weak var imieTextField: UITextField!
    @IBOutlet weak var nazwiskoTextField: UITextField!
    @IBOutlet weak var stanowiskoTextField: UITextField!
    @IBOutlet weak var firmaTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var telefonTextField: UITextField!
    @IBOutlet weak var dataSpotkaniaTextField: UILabel!
    @IBOutlet weak var zgoda1Button: UIButton!
    @IBOutlet weak var zgoda2Button: UIButton!
    
    
    // MARK:- Properties
    
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
    
    
    
    
    // MARK:- System Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        przypiszPrzykladoweDane()
    }

    // MARK:- Action Methods
    
    @IBAction func selectedDateButton(_ sender: UIButton) {
        print("Data")
    }

    @IBAction func selectedApproval1(_ sender: UIButton) { zgoda1 = !zgoda1 }

    @IBAction func selectedApproval2(_ sender: UIButton) { zgoda2 = !zgoda2 }

    @IBAction func selectedWriteButton(_ sender: UIButton) {
        pokazDane()
    }
    
    func przypiszPrzykladoweDane() {
        person.imie =       "Tomek"
        person.nazwisko =   "Jabłoński"
        person.stanowisko = "Szef"
        person.firma =      "IBM"
        person.email =      "t.jablonski@ibm.com"
        person.telefon =    "501390999"
        //person.data =
        zgoda1 =     false
        zgoda2 =     false
    }
    
    func pokazDane() {
        print("Imię: \(person.imie)")
        print("Nazwisko: \(person.nazwisko)")
        print("Stanowsiko: \(person.stanowisko)")
        print("Firma: \(person.firma)")
        print("E-mail: \(person.email)")
        print("Telefon: \(person.telefon)")
        //print("Data: \(person.data)")
        print("Zgoda1: \(person.zgoda1)")
        print("Zgoda2: \(person.zgoda2)")
    }
    
}
