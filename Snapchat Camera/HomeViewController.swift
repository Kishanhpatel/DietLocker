
import UIKit
import Firebase
import HealthKit
import HealthKitUI

class HomeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        addGradient()
        self.view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
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

