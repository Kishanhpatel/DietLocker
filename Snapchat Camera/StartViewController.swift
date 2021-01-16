

import UIKit
import Firebase

class StartViewController: UIViewController {
    var gradient: CAGradientLayer?
    override func viewDidLoad() {
        super.viewDidLoad()
//        addGradient()
        self.view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if Auth.auth().currentUser != nil {
            self.performSegue(withIdentifier: "alreadyLoggedIn", sender: nil)
        }
    }
//    func addGradient() {
//        gradient = CAGradientLayer()
//        let startColor = UIColor.systemGray
//        let endColor = UIColor.systemGray
//        gradient?.colors = [startColor.cgColor,endColor.cgColor]
//        gradient?.startPoint = CGPoint(x: 0, y: 0)
//        gradient?.endPoint = CGPoint(x: 0, y:1)
//        gradient?.frame = view.frame
//        self.view.layer.insertSublayer(gradient!, at: 0)
//    }

    
}
