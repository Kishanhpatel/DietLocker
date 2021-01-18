import UIKit
import Firebase
import HealthKit
import HealthKitUI

class HomeViewController: UIViewController {
    
    let healthStore = HKHealthStore()
    //    @IBOutlet weak var activityRingView: HKActivityRingView!
    
    
    //hey hey
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        addGradient()
        self.view.backgroundColor =  #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        testActivitySummaryQuery()
//        GoalComp.text = "Goals Not Met"
    }
    
  
    @IBOutlet weak var GoalComp : UILabel!
    
    
    private let authorizeHealthKitSection = 2
    
    private func authorizeHealthKit() {
        
        HealthKitSetupAssistant.authorizeHealthKit { (authorized, error) in
            
            guard authorized else {
                
                let baseMessage = "HealthKit Authorization Failed"
                
                if let error = error {
                    print("\(baseMessage). Reason: \(error.localizedDescription)")
                } else {
                    print(baseMessage)
                }
                
                return
            }
            
            print("HealthKit Successfully Authorized.")
        }
        
    }
    
    
    
    @IBAction func AuthHealth(_ sender: Any) {
        do {
            authorizeHealthKit()
        }
    }
    
    
    
    
    
    private func testActivitySummaryQuery() {
        print("Reached testActivitySummaryQuery.\n")
        if #available(iOS 9.3, *) {
            let query = HKActivitySummaryQuery.init(predicate: nil) { (query, summaries, error) in
                let calendar = Calendar.current
                for summary in summaries! {
                    let dateComponants = summary.dateComponents(for: calendar)
                    
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd"
                    
                    
                    
                    
                    
                    let date = dateComponants.date
                    
                    if ((dateFormatter.string(from: date!)) == "2018-04-18") {
                        
                        let energyUnit   = HKUnit.jouleUnit(with: .kilo)
                        let standUnit    = HKUnit.count()
                        let exerciseUnit = HKUnit.second()
                        
                        let energy   = summary.activeEnergyBurned.doubleValue(for: energyUnit)
                        let stand    = summary.appleStandHours.doubleValue(for: standUnit)
                        let exercise = summary.appleExerciseTime.doubleValue(for: exerciseUnit)
                        
                        let energyGoal   = summary.activeEnergyBurnedGoal.doubleValue(for: energyUnit)
                        let standGoal    = summary.appleStandHoursGoal.doubleValue(for: standUnit)
                        let exerciseGoal = summary.appleExerciseTimeGoal.doubleValue(for: exerciseUnit)
                        
                        if (energy > energyGoal && stand > standGoal && exercise > exerciseGoal) {
                            print("Goals completed\n")
//                            self.GoalComp.text = "Goals completed"
                        } else {
                            print("Goals not completed\n")
//                            self.GoalComp.text = "Goals not completed"
                        }
                        
//                        @IBOutlet var labelCollection: [UILabel]!
                        
                       
                        let screenSize: CGRect = UIScreen.main.bounds
                        let ringView = HKActivityRingView(frame: CGRect(x: screenSize.width/2 - 150, y: 150, width:  300, height: 300))
                        self.view.addSubview(ringView)
                        ringView.setActivitySummary(summary, animated: true)
                        
                        
                        
                        
                        
                        print("Date: \(dateFormatter.string(from: date!)), Active Energy Burned: \(summary.activeEnergyBurned), Active Energy Burned Goal: \(summary.activeEnergyBurnedGoal)")
                        print("Date: \(dateFormatter.string(from: date!)), Exercise Time: \(summary.appleExerciseTime), Exercise Goal: \(summary.appleExerciseTimeGoal)")
                        print("Date: \(dateFormatter.string(from: date!)), Stand Hours: \(summary.appleStandHours), Stand Hours Goal: \(summary.appleStandHoursGoal)")
                        print("----------------")
                    }
                }
            }
            
            
            
            
            query.updateHandler = { query, summaries, error in
                DispatchQueue.main.async { () -> Void in
                    print("Done (Empty)")
                    
                    //                        self.activityRingView.setActivitySummary((summaries?.first)!, animated: true)
                }
            }
            
            healthStore.execute(query)
        } else {
            // Fallback on earlier versions
        }
    }
    
    
    
    
    
    
    
    
    @IBAction func logOutAction(_ sender: Any) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let initial = storyboard.instantiateInitialViewController()
        UIApplication.shared.keyWindow?.rootViewController = initial
    }
    
}

