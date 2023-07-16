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
    
    var meds: [Med] = [
        Med(name: "Lovastatin", dose: "20mg", frequency: "once at bedtime"),
        Med(name: "Lisinopril", dose: "20mg", frequency: "once daily"),
        Med(name: "Aspirin", dose: "81 mg", frequency: "once daily")
    ]

    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        tableView.dataSource = self
        tableView.dataSource = self
    }
    
    @IBAction func addMed(_ sender: UIButton) {
        if let medName = medNameTextfield.text, let medDose = doseTextfield.text, let medFreq = frequencyTextField.text {
            db.collection(K.FStore.collectionName).addDocument(data: [
                K.FStore.nameField: medName,
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

