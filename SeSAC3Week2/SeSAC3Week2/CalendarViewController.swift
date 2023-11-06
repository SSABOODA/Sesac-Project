//
//  CalendarViewController.swift
//  SeSAC3Week2
//
//  Created by 한성봉 on 2023/07/25.
//

import UIKit

class CalendarViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("CalendarViewController", #function)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("CalendarViewController", #function)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("CalendarViewController", #function)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("CalendarViewController", #function)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("CalendarViewController", #function)
    }
    
    // ViewController 이름 따서 해주는게 명시적임.
    @IBAction func unwindToCalendar(_ seque: UIStoryboardSegue) {
        
    }

}
