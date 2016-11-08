//
//  DatePickerVC.swift
//  formularz
//
//  Created by Black Thunder on 08.11.2016.
//  Copyright © 2016 Krzysztof Lech. All rights reserved.
//

import UIKit

protocol DatePickerDelegate {
    func didSelectDate(date: Date)
}


class DatePickerVC: UIViewController {

    @IBOutlet weak var datePicker: UIDatePicker!
    var delegate: DatePickerDelegate! = nil
    
    
    @IBAction func readDate(_ sender: UIButton) {
        
        /*
        let formatter = DateFormatter()
        formatter.locale = NSLocale(localeIdentifier: "PL") as Locale!
        formatter.dateStyle = .short
        
        let date = formatter.string(from: datePicker.date)
        print(date)
        */
 
        delegate.didSelectDate(date: datePicker.date)
    }
}
