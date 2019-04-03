//
//  WebViewViewController.swift
//  BopSee
//
//  Created by Vamsi  on 18/07/17.
//  Copyright © 2017 Vamsi. All rights reserved.
//

import UIKit
import WebKit
class WebViewViewController: UIViewController,WKUIDelegate {
    
    var progressView: UIProgressView!
    var webView: WKWebView!
    var myContext = 0
    
    init(html:String?, url:NSURL?){
        super.init(nibName: nil, bundle: nil)
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        webView.navigationDelegate = self
        if(html != nil){
            webView.loadHTMLString(html!, baseURL: nil)
        }else if(url != nil){
            let request = URLRequest.init(url: url! as URL)
            webView.load(request)
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //deinit
    deinit {
        //remove all observers
        webView.removeObserver(self, forKeyPath: "title")
        webView.removeObserver(self, forKeyPath: "estimatedProgress")
        //remove progress bar from navigation bar
        progressView.removeFromSuperview()
    }
    override func loadView() {
        super.loadView()
        view = webView
        //add progresbar to navigation bar
        progressView = UIProgressView(progressViewStyle: .default)
        progressView.autoresizingMask = [.flexibleWidth, .flexibleTopMargin]
        progressView.tintColor =  UIColor.themeColor
        navigationController?.navigationBar.addSubview(progressView)
        let navigationBarBounds = self.navigationController?.navigationBar.bounds
        progressView.frame = CGRect(x: 0, y: navigationBarBounds!.size.height - 2, width: navigationBarBounds!.size.width, height: 1.5)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "Close", style: .done, target: self, action: #selector(WebViewViewController.didTapDone))
        self.navigationController?.navigationBar.tintColor =  UIColor.themeColor
        self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedStringKey.font: UIFont.appFont(.Regular, size: 22) , NSAttributedStringKey.foregroundColor : UIColor.themeColor];
        // // add observer for key path
        webView.addObserver(self, forKeyPath: "title", options: .new, context: &myContext)
        webView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: &myContext)
    }
    @objc func didTapDone(){
        self.navigationController?.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    //observer
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        guard let change = change else { return }
        if context != &myContext {
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
            return
        }
        if keyPath == "title" {
            if let title = change[NSKeyValueChangeKey.newKey] as? String {
                //self.navigationItem.title = title
            }
            return
        }
        if keyPath == "estimatedProgress" {
            if let progress = (change[NSKeyValueChangeKey.newKey] as AnyObject).floatValue {
                progressView.progress = progress;
            }
            return
        }
    }
}
extension WebViewViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        progressView.isHidden = true
    }
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        progressView.isHidden = false
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        progressView.isHidden = true
    }
}

