
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Bu metot, bir sahne uygulamaya bağlandığında çağrılır.
        guard let windowScene = (scene as? UIWindowScene) else { return }  // Bu satırda, gelen sahnenin bir UIWindowScene olup olmadığı kontrol edilir.
        window = UIWindow(frame: windowScene.coordinateSpace.bounds) // Yeni bir UIWindow oluşturulur ve boyutu, gelen sahnenin koordinat uzayının boyutuna ayarlanır.
        window?.windowScene = windowScene // Oluşturulan UIWindow'ın windowScene özelliği, gelen sahnenin UIWindowScene'ine atanır.
        window?.rootViewController = MainTabViewController() // UIWindow'ın kök view controller'ı ViewController sınıfından bir örnek olarak atanır.
        window?.makeKeyAndVisible() // Oluşturulan UIWindow anahtar (key) yapılır ve görünür hale getirilir.
    }
}

