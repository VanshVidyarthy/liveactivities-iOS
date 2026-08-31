//
//  ViewController.swift
//  liveactivities
//
//  Created by Vansh Vidyarthy on 13/08/26.
//

import UIKit
import WebKit
class ViewController: UIViewController, WKNavigationDelegate {

    private var webView: WKWebView!
    private let nativeBridge = NativeBridge()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupWebView()
        loadAngularApp()
    }

    private func setupWebView() {

        let configuration = WKWebViewConfiguration()

        configuration.userContentController.add(
            nativeBridge,
            name: "nativeBridge"
        )
        
        configuration.userContentController.add(
            nativeBridge,
            name: "liveActivity"
        )

        webView = WKWebView(
            frame: .zero,
            configuration: configuration
        )

        webView.navigationDelegate = self

        webView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(webView)

        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor
            ),
            webView.bottomAnchor.constraint(
                equalTo: view.bottomAnchor
            ),
            webView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor
            ),
            webView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor
            )
        ])
    }

    private func loadAngularApp() {

        let urlString = "http://172.26.85.214:4201"

        guard let url = URL(string: urlString) else {
            print("❌ Invalid URL")
            return
        }

        print("🌐 Loading Angular: \(url.absoluteString)")

        webView.load(
            URLRequest(
                url: url,
                cachePolicy: .reloadIgnoringLocalCacheData
            )
        )
    }

    func webView(
        _ webView: WKWebView,
        didFinish navigation: WKNavigation!
    ) {
        print("✅ Angular loaded successfully")
    }
}
