
import UIKit

enum MakeAlertHelper {
    static func alertMassage(title: String, message: String, style: UIAlertController.Style, vc: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Okay", style: .default)
        alert.addAction(alertAction)
        vc.present(alert, animated: true)
    }
}
