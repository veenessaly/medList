//
//  medReminder
//
//  Created by VANESSA DOWD on 7/8/23.
//

import UIKit

class TableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {


    @IBOutlet weak var tableView: UITableView!
    
    var meds: [Med] = [
        Med(name: "Lovastatin", dose: "20mg", frequency: "once at bedtime", lastTaken: "7/7/23, 8:00 PM", remaining: "28"),
        Med(name: "Lisinopril", dose: "20mg", frequency: "once daily", lastTaken: "7/7/23, 8:00 PM", remaining: "28"),
        Med(name: "Aspirin", dose: "81 mg", frequency: "once daily", lastTaken: "7/7/23, 8:00 PM", remaining: "28")
    ]

    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        tableView.dataSource = self
        tableView.dataSource = self
            
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
        let medTaken = med.lastTaken
        let medRemaining = med.remaining
        
        cell.nameLabel.text = medName
        cell.doseLabel.text = medDose
        cell.frequencyLabel.text = medFreq
        cell.takenLabel.text = medTaken
        cell.remainingLabel.text = medRemaining
        
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        print("Loading up the details screen")
//find selected medication
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPath(for:cell)!
        let med = meds[indexPath.row]
        
// pass the selected med to the details view controller
        let detailsViewController = segue.destination as! MedDetailsViewController
        
        TableViewController.med = meds
        
    }

}

