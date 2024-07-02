//
//  RecordsRealm.swift
//  RealmDemo1
//
//  Created by Arshad Shaik on 05/12/23.
//

import RealmSwift

class PatientDetails: Object {
  @Persisted var firstName: String
  @Persisted var lastName: String
  @Persisted var testList: List<TestDetails>
  
  convenience init(firstName: String, lastName: String) {
    self.init()
    self.firstName = firstName
    self.lastName = lastName
  }
}

class TestDetails: Object {
  @Persisted var testName: String
  @Persisted var testAmount: Int
  
  convenience init(testName: String, testAmount: Int) {
    self.init()
    self.testName = testName
    self.testAmount = testAmount
  }
}

//class Record: Object, Codable {
//  @Persisted var isApproved: Int = 0
//  @Persisted var comments: String = ""
//  @Persisted var userDetailsId: UserDetails?
//  @Persisted var manualSampleID: String?
//  @Persisted var sampleDate: String?
//  @Persisted var autoSampleID: Int = 0
//}
//
//class UserDetails: Object, Codable {
//  @Persisted var patientType: String = ""
//  @Persisted var lastKnownBillDate: String?
//  @Persisted var age: String = ""
//  @Persisted var address: String = ""
//  @Persisted var id: Int = 0
//  @Persisted var fullName: String = ""
//  @Persisted var sex: String = ""
//  @Persisted var contact: String = ""
//
//  // LinkingObjects property to establish the reverse relationship
//  let records = LinkingObjects(fromType: Record.self, property: "userDetailsId")
//
//  private enum CodingKeys: String, CodingKey {
//    case patientType, lastKnownBillDate, age, address, id, fullName, sex, contact
//  }
//
//  required convenience init(from decoder: Decoder) throws {
//    self.init()
//
//    let container = try decoder.container(keyedBy: CodingKeys.self)
//
//    patientType = try container.decode(String.self, forKey: .patientType)
//    age = try container.decode(String.self, forKey: .age)
//    address = try container.decode(String.self, forKey: .address)
//    id = try container.decode(Int.self, forKey: .id)
//    fullName = try container.decode(String.self, forKey: .fullName)
//    sex = try container.decode(String.self, forKey: .sex)
//    contact = try container.decode(String.self, forKey: .contact)
//    lastKnownBillDate = try container.decode(String.self, forKey: .contact)
//  }
//}
