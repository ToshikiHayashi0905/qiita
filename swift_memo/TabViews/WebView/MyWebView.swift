//
//  ViewController.swift
//  swift_memo
//
//  Created by 林 利樹 on 2017/06/11.
//  Copyright © 2017年 林 利樹. All rights reserved.
//

import UIKit

class MyWebView: UIViewController ,UIWebViewDelegate{
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var reloadButton: UIBarButtonItem!
    @IBOutlet weak var stopButton: UIBarButtonItem!
    
    @IBOutlet weak var activity: UIActivityIndicatorView!
    
    public var selectDataDic : Dictionary<String, String> = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.activity.alpha = 0
        if let url = selectDataDic["url"] {
            self.open(urlString: url)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    public func open(urlString : String) {
        
        guard let url = URL(string: urlString) else { return }
        let urlRequest = URLRequest(url: url)
        
        self.webView.loadRequest(urlRequest)
    }

    
    @IBAction func actionBackbutton(_ sender: UIBarButtonItem) {
        self.webView.goBack()
    }

    @IBAction func actionReloadButton(_ sender: UIBarButtonItem) {
        self.webView.reload()
    }
    
    @IBAction func actionStopButton(_ sender: UIBarButtonItem) {
        self.webView.stopLoading()
    }
    
    @IBAction func actionBookMarkButton(_ sender: UIBarButtonItem) {
        self.saveBookMark()
    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        self.activity.alpha = 1
        self.activity.startAnimating()
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        self.activity.alpha = 0
        self.activity.stopAnimating()
    }
    
    func saveBookMark() {
        
        GlobalClass.showAlertOkAndCancel(presentView: self, title: "お気に入り", message: "お気に入り登録しますか？") { () in
            FavoriteDataManager.sharedManager.createRecord(newRecordData:self.selectDataDic)
        }
        
    }
}

