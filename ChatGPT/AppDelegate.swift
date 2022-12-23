import UIKit
import WebKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, WKNavigationDelegate {

    var window: UIWindow?
    var webView: WKWebView!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Set up the window and web view
        window = UIWindow(frame: UIScreen.main.bounds)
        webView = WKWebView(frame: window!.frame)
        webView.autoresizingMask = [.flexibleWidth, .flexibleHeight] // Add this line to set the autoresizing mask
        webView.navigationDelegate = self

        // Create a view controller to contain the web view
        let rootViewController = UIViewController()
        rootViewController.view.addSubview(webView)
        window!.rootViewController = rootViewController

        // Load the website
        let url = URL(string: "https://chat.openai.com")!
        webView.load(URLRequest(url: url))

        window!.makeKeyAndVisible()
        return true
    }

    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping     (WKNavigationActionPolicy) -> Void) {
        // Get the host of the URL
        guard let host = navigationAction.request.url?.host else {
            decisionHandler(.cancel)
            return
        }
    
        // Check the host of the URL and decide whether to allow it to be loaded in the app's web view or open it in Safari
        switch host {
        case "chat.openai.com", "auth0.openai.com", "www.recaptcha.net":
            decisionHandler(.allow)
        default:
            UIApplication.shared.open(navigationAction.request.url!)
            decisionHandler(.cancel)
        }
    }
}
