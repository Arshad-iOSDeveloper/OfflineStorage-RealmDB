//
//  ViewController.swift
//  RealmDemo1
//
//  Created by Arshad Shaik on 05/12/23.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {
  
  @IBOutlet weak var patientTableView: UITableView!
  
  var patientArray = [PatientDetails]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configuration()
  }
  
  // MARK: - Actions -
  @IBAction func addPatientDetails(_ sender: UIBarButtonItem) {
    self.patientConfiguration(isAdd: true)
  }
}

extension ViewController: UITableViewDataSource{
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    patientArray.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard var cell = tableView.dequeueReusableCell(withIdentifier: "cell") else{
      return UITableViewCell()
    }
    
    cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
    
    cell.textLabel?.text = patientArray[indexPath.row].firstName
    cell.detailTextLabel?.text = patientArray[indexPath.row].lastName
    
    return cell
  }
  
}

extension ViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
    
    let edit = UIContextualAction(style: .normal, title: "Edit") { _, _, _ in
      self.patientConfiguration(isAdd: false, index: indexPath.row)
    }
    edit.backgroundColor = .magenta
    
    let delete = UIContextualAction(style: .destructive, title: "Delete") { _, _, _ in
      DatabaseHelper.shared.deleteFromRealm(details: self.patientArray[indexPath.row])
      self.patientArray.remove(at: indexPath.row)
      self.patientTableView.reloadData()
    }
    
    let swipeConfiguration = UISwipeActionsConfiguration(actions: [delete, edit])
    return swipeConfiguration
    
  }
}

extension ViewController{
  func configuration(){
    patientTableView.dataSource = self
    patientTableView.delegate = self
    patientArray = DatabaseHelper.shared.getAllObjects(ofType: PatientDetails.self)
    patientTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
  }
  
  func patientConfiguration(isAdd: Bool, index: Int = 0){
    
    let alertController = UIAlertController(title: isAdd ?  "Add Patient Details" : "Update Patient Details", message: isAdd ? "Please enter patient details" : "Please update patient details", preferredStyle: .alert)
    
    let save = UIAlertAction(title: isAdd ? "Save" : "Update", style: .default) { _ in
      if let firstName = alertController.textFields?.first?.text,
         let lastName = alertController.textFields?[1].text,
         !firstName.isEmpty, !lastName.isEmpty {
        if isAdd{
          //Append
          let patientDetails = PatientDetails(firstName: firstName, lastName: lastName)
          self.patientArray.append(patientDetails) //Append
          DatabaseHelper.shared.saveToRealm(details: patientDetails)
        }else{
          //Update
          let patientData = self.patientArray[index]
          let patientDetails = PatientDetails(firstName: firstName, lastName: lastName)
          patientDetails.testList.append(TestDetails(testName: "Lipid Profile", testAmount: 1500))
          DatabaseHelper.shared.updatePatientDetails(oldObject: self.patientArray[index], newObject: patientDetails)
        }
        self.patientTableView.reloadData()
      }
    }
    
    let cancel = UIAlertAction(title: "Cancel", style: .cancel) { _ in
      print("cancel tapped")
    }
    
    alertController.addTextField { firstNameField in
      firstNameField.placeholder = isAdd ? "Enter your firstName" : self.patientArray[index].firstName
    }
    
    alertController.addTextField { lastNameField in
      lastNameField.placeholder = isAdd ? "Enter your lastName": self.patientArray[index].lastName
    }
    
    alertController.addAction(save)
    alertController.addAction(cancel)
    
    self.present(alertController, animated: true)
    
  }
  
}
