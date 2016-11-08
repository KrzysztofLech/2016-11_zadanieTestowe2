//
//  DatePickerVC.swift
//  formularz
//
//  Created by Black Thunder on 08.11.2016.
//  Copyright © 2016 Krzysztof Lech. All rights reserved.
//

import UIKit

class DatePickerVC: UIViewController {

    @IBOutlet weak var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    
    @IBAction func readDate(_ sender: UIButton) {
        let formatter = DateFormatter()
        formatter.locale = NSLocale(localeIdentifier: "PL") as Locale!
        formatter.dateStyle = .short
        
        let date = formatter.string(from: datePicker.date)
        
        print(date)
    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    

    

}
