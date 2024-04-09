
import UIKit

enum UIHelper {
    
    static func createCollectionViewFlowLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        let cellWidth = CGFloat.deviceWidth
        let padding: CGFloat = 16
        
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: cellWidth - (2 * padding), height: cellWidth / 3)
        layout.minimumLineSpacing = 3
        
        return layout
    }
}
