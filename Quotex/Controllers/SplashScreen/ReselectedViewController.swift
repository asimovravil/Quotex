import UIKit
import WebKit
import SnapKit
import CoreMotion

final class ReselectedViewController: UIViewController {
    
    private var webView: WKWebView!
    private let lowerBarViewUpperKek = LowerBarViewMegaKek()
    
    private var viewModel: StructedSettings
    
    private var orientationLast = UIInterfaceOrientation(rawValue: 0)!
    private var motionManager: CMMotionManager?
    
    private var lastUrl: URL!
    
    init(viewModel: StructedSettings) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCookies()
        setupAppearance()
        initializeMotionManager()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if viewModel.sumChecked {
            webView.load(URLRequest(url: viewModel.termOfUse))
        } else {
            webView.load(URLRequest(url: viewModel.privacyPolicy))
        }
    }
    
    private func setupAppearance() {
        view.backgroundColor = .black
        if viewModel.sumChecked == false {
            view.backgroundColor = .white
            let rightBarButton = UIBarButtonItem(
                title: "Done",
                style: .done,
                target: self,
                action: #selector(closeButtonTapped)
            )
            navigationController?.navigationBar.topItem?.rightBarButtonItem = rightBarButton
        }
        configureBottomBarView()
        setupUI()
    }
    
    @objc private func closeButtonTapped() {
        let mainViewController = TabBarController()
        let navigationController = UINavigationController(rootViewController: mainViewController)
        navigationController.modalPresentationStyle = .fullScreen
        present(navigationController, animated: false)
    }
    
    private func setupUI() {
        webView = WKWebView(frame: .zero, configuration: webViewConfiguration)
        webView.allowsBackForwardNavigationGestures = true
        webView.allowsLinkPreview = true
        webView.addObserver(self, forKeyPath: "URL", options: [.new], context: nil)
        view.addSubview(webView)
        webView.snp.makeConstraints{ make in
            make.left.right.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(lowerBarViewUpperKek.snp.top)
            
        }
    }
    
    private var webViewConfiguration: WKWebViewConfiguration {
        let config = WKWebViewConfiguration()
        config.applicationNameForUserAgent = "Mozilla/5.0 (iPhone; CPU iPhone OS 16_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/16.3 Mobile/15E148 Safari/604.1"
        if #available(iOS 14, *) {
            config.defaultWebpagePreferences.allowsContentJavaScript = true
        }
        config.allowsPictureInPictureMediaPlayback = true
        config.allowsAirPlayForMediaPlayback = true
        config.allowsInlineMediaPlayback = true
        let pref = WKWebpagePreferences()
        pref.preferredContentMode = .mobile
        config.defaultWebpagePreferences = pref
        return config
    }
    
    private func configureBottomBarView() {
        view.addSubview(lowerBarViewUpperKek)
        lowerBarViewUpperKek.delegate = self
        lowerBarViewUpperKek.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.height.equalTo(UIDevice.hasNotch ? 52 : 40)
            make.bottom.equalToSuperview()
        }
    }
    
    override func observeValue(
        forKeyPath keyPath: String?,
        of object: Any?,
        change: [NSKeyValueChangeKey : Any]?,
        context: UnsafeMutableRawPointer?
    ) {
        if viewModel.sumChecked {
            if let url = change?[.newKey] as? URL {
                SavedSettingsManager.save(url)
                print("Сохраняем \(url.absoluteString)")
                saveCookies()
            }
        } else {
            print("Вообще ничего не делаем, это не клоака")
        }
    }
    
    func saveCookies() {
        let cookieJar: HTTPCookieStorage = HTTPCookieStorage.shared
        if let cookies = cookieJar.cookies {
            let data: Data = NSKeyedArchiver.archivedData(withRootObject: cookies)
            let ud: UserDefaults = UserDefaults.standard
            ud.set(data, forKey: "cookie")
        }
    }
    
    func loadCookies() {
        let ud: UserDefaults = UserDefaults.standard
        guard
            let data = ud.object(forKey: "cookie") as? Data,
            let cookies = NSKeyedUnarchiver.unarchiveObject(with: data) as? NSArray
        else { return }
        cookies.compactMap{ $0 as? HTTPCookie }.forEach{ cookie in
            HTTPCookieStorage.shared.setCookie(cookie)
        }
    }
    
}

extension ReselectedViewController: LowerBarMegaKekDelegate {
    
    func popToRoot() {
        guard let firstLink = webView.backForwardList.backList.first else { return }
        webView.go(to: firstLink)
    }
    
    func pop() {
        print("кнопка нажата")
        webView.goBack()
    }
    
}

extension ReselectedViewController {
    
    func initializeMotionManager() {
        motionManager = CMMotionManager()
        motionManager?.gyroUpdateInterval = 0.2
        motionManager?.accelerometerUpdateInterval = 0.2
        motionManager?.startAccelerometerUpdates(to: (OperationQueue.current)!) {
            (accelerometerData, error) -> Void in
            if error == nil {
                self.outputAccelerationData((accelerometerData?.acceleration)!)
            }
        }
    }
    
    func outputAccelerationData(_ acceleration: CMAcceleration) {
        if #available(iOS 16.0, *) {
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
            else { return }
            var orientationNew: UIInterfaceOrientation
            if acceleration.x >= 0.75 {
                orientationNew = .landscapeLeft
                windowScene.requestGeometryUpdate(.iOS(interfaceOrientations: .landscapeLeft))
                self.setNeedsUpdateOfSupportedInterfaceOrientations()
                
                lowerBarViewUpperKek.snp.remakeConstraints { make in
                    make.left.right.equalToSuperview()
                    make.height.equalTo(40)
                    make.bottom.equalToSuperview()
                }
                
            } else if acceleration.x <= -0.75 {
                orientationNew = .landscapeRight
                windowScene.requestGeometryUpdate(.iOS(interfaceOrientations: .landscapeRight))
                self.setNeedsUpdateOfSupportedInterfaceOrientations()
                
                lowerBarViewUpperKek.snp.remakeConstraints { make in
                    make.left.right.equalToSuperview()
                    make.height.equalTo(40)
                    make.bottom.equalToSuperview()
                }
                
            } else if acceleration.y <= -0.75 {
                orientationNew = .portrait
                windowScene.requestGeometryUpdate(.iOS(interfaceOrientations: .portrait))
                self.setNeedsUpdateOfSupportedInterfaceOrientations()
                
                
                lowerBarViewUpperKek.snp.remakeConstraints { make in
                    make.left.right.equalToSuperview()
                    make.height.equalTo(UIDevice.hasNotch ? 52 : 40)
                    make.bottom.equalToSuperview()
                }
                
            } else {
                return
            }
            if orientationNew == orientationLast { return }
            orientationLast = orientationNew
        }
    }
    
}

extension UIDevice {
    
    static var hasNotch: Bool {
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        guard let window = windowScene?.windows.first else { return false }
        return window.safeAreaInsets.top > 20
    }
}
