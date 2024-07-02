//
//  DatabaseHelper.swift
//  RealmDemo1
//
//  Created by Arshad Shaik on 05/12/23.
//

import RealmSwift

class DatabaseHelper{
  
  static let shared = DatabaseHelper()
  /// Open the local-only default realm
  private var realm = try! Realm()
  
  func getDatabasePath() -> URL?{
    return Realm.Configuration.defaultConfiguration.fileURL
  }
  
  func saveToRealm<T: Object>(details: T) {
    try! realm.write({
      realm.add(details)
    })
  }
  
  func updatePatientDetails(oldObject: PatientDetails, newObject: PatientDetails){
    try! realm.write{
      oldObject.firstName = newObject.firstName
      oldObject.lastName = newObject.lastName
      oldObject.testList.append(objectsIn: newObject.testList)
    }
  }
  
  func deleteFromRealm<T: Object>(details: T){
    try! realm.write{
      realm.delete(details)
    }
  }
  
  func getAllObjects<T: Object>(ofType type: T.Type) -> [T] {
    // Retrieve all objects of the specified type
    let objects = realm.objects(type)
    
    // Convert Results<T> to [T]
    return Array(objects)
  }
  
}

//  private func mapResponseFromJsonFile(fileName: String) {
//    if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
//      do {
//        let data = try Data(contentsOf: url)
//        let recordsContainer = try JSONDecoder().decode([String: [Record]].self, from: data)
//        let records = recordsContainer["records"]!
//        print("data response is ", records)
//        //        saveRecordsToRealm(records: records)
//      } catch {
//        print("Error: \(error)")
//      }
//    }
//  }
