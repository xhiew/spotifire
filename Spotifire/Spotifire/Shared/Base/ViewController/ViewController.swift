//
//  ViewController.swift
//  Spotifire
//
//  Created by xhieu on 13/8/24.
//

import UIKit

class ViewController: UIViewController {
    // MARK: Lifecycle
    init() { super.init(nibName: Self.aka, bundle: .main) }
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
        xlog("deinit \(self)")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        xlog("viewDidLoad \(self)")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        xlog("viewWillAppear \(self)")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        xlog("viewDidAppear \(self)")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        xlog("viewWillDisappear \(self)")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        xlog("viewDidDisappear \(self)")
    }
}
