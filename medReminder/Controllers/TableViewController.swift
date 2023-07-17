//
//  medReminder
//
//  Created by VANESSA DOWD on 7/8/23.
//

import UIKit
import FirebaseCore
import FirebaseFirestore

class TableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {


    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var medNameTextfield: UITextField!
    
    @IBOutlet weak var doseTextfield: UITextField!
    
    @IBOutlet weak var frequencyTextField: UITextField!
    
    let db = Firestore.firestore()
    
    var meds: [Med] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        tableView.dataSource = self
        tableView.dataSource = self
        
        loadMedications()
    }
    
    func loadMedications(){

        
//        displays medications from from database
        db.collection(K.FStore.collectionName)
            .order(by:K.FStore.nameField)
            .addSnapshotListener {(querySnapshot, err) in
            
            self.meds = []
            
            
            if let err = err {
                print("Error getting medication list: \(err)")
            } else {
                if let snapshotDocuments = querySnapshot?.documents{
                    for document in snapshotDocuments {
                        let data = document.data()
                        if let medName = data[K.FStore.nameField] as? String, let medDose = data[K.FStore.doseField] as? String, let medFrequency = data[K.FStore.freqField] as? String {
                            let newMed = Med(name: medName.capitalized, dose: medDose, frequency: medFrequency)
                            self.meds.append(newMed)

                            
//                            reloads app to show updated list
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                            }
                        }
                    }
                }
            }
        }
    }
    
//    button function submitting a new entry to the database
    @IBAction func addMed(_ sender: UIButton) {
        if let medName = medNameTextfield.text, let medDose = doseTextfield.text, let medFreq = frequencyTextField.text {
            db.collection(K.FStore.collectionName).addDocument(data: [
                K.FStore.nameField: medName.capitalized,
                K.FStore.doseField: medDose,
                K.FStore.freqField: medFreq
            ]) { error in
                if let e = error {
                    print("There was an issue adding your medication")
                } else {
                    print("Medication successfully added")
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meds.count
        
    }
//
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MedCell") as! MedCell
        
        let med = meds[indexPath.row]
        let medName = med.name
        let medDose = med.dose
        let medFreq = med.frequency
//        let medTaken = med.lastTaken
//        let medRemaining = med.remaining
        
        cell.nameLabel.text = medName
        cell.doseLabel.text = medDose
        cell.frequencyLabel.text = medFreq
//        cell.takenLabel.text = medTaken
//        cell.remainingLabel.text = medRemaining
        
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
    
// INFORMATION FOR WHEN READY TO ADD DETAILS!!
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
//        print("Loading up the details screen")
////find selected medication
//        let cell = sender as! UITableViewCell
//        let indexPath = tableView.indexPath(for:cell)!
//        let med = meds[indexPath.row]
//
//// pass the selected med to the details view controller
//        let detailsViewController = segue.destination as! MedDetailsViewController
//
//        detailsViewController.med = med
//    }
//
}

