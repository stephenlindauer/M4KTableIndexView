//
//  ViewController.swift
//  SampleContactList
//
//  Created by Stephen Lindauer on 2/8/17.
//

import UIKit

class ViewController: UIViewController {

    let indexes = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var indexView: M4KTableIndexView!
    var contactsBySection: [String: Array<String>] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        getContactsFromPlist()
        
        // Setup the TableIndexView
        indexView.tableView = self.tableView
        indexView.indexes = self.indexes
        indexView.setup()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // Read the Contacts.plist file and populate contactsBySection
    func getContactsFromPlist() {
        if let path = Bundle.main.path(forResource: "Contacts", ofType: "plist") {
            contactsBySection = NSDictionary(contentsOfFile: path) as! [String: Array<String>]
        }
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return contactsBySection.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return indexes[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let contacts = contactsBySection[indexes[section]]!
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        let contacts = contactsBySection[indexes[indexPath.section]]!
        let contact = contacts[indexPath.row]
        
        cell.textLabel!.text = contact
        
        return cell
    }
    
}
