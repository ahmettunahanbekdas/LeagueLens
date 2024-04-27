
import UIKit

enum MakeAlertHelper {
    static func alertMassage(action: String,title: String, message: String, style: UIAlertController.Style, vc: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        let alertAction = UIAlertAction(title: action, style: .default)
        //let alertCancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(alertAction)
        //alert.addAction(alertCancelAction)
        vc.present(alert, animated: true)
    }
    
    
    
    static func deleteAlertMassage(action: String, title: String, message: String, style: UIAlertController.Style, vc: UIViewController, deleteAction: @escaping () -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let deleteAlertAction = UIAlertAction(title: action, style: .destructive) { _ in
            deleteAction()
        }
        let cancelAlertAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addAction(deleteAlertAction)
        alert.addAction(cancelAlertAction)
        
        vc.present(alert, animated: true)
    }
    
}


