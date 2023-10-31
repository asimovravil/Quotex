

import Foundation

enum ManagerKey: String {
    case lastUrl
    case isBottomBarNeeded
}

final class SavedSettingsManager {
    
    static var lastUrl: String? {
        get { UserDefaults.get(forKey: ManagerKey.lastUrl.rawValue) as? String }
        set { UserDefaults.set(newValue, forKey: ManagerKey.lastUrl.rawValue) }
    }
    
    
    static func save(_ url: URL) { lastUrl = url.absoluteString }
    
    static var cachedViewModel: StructedSettings? {
        if let lastUrl = lastUrl {
            return StructedSettings(
                privacyPolicy: URL(string: lastUrl)!,
                termOfUse: URL(string: lastUrl)!,
                sumChecked: true
            )
        } else {
            return nil
        }
    }
    
}

extension UserDefaults {
    
    struct Timeout {
        let timestamp: Date = Date()
        let interval: TimeInterval?
    }
    
    static private var timeoutByKeyList: [String: Timeout] = [:]
    
    class func set(_ value: Any?, forKey key: String, timeout: TimeInterval? = nil) {
        guard let value = value else {
            return UserDefaults.standard.removeObject(forKey: key)
        }
        UserDefaults.standard.set(value, forKey: key)
        UserDefaults.timeoutByKeyList[key] = Timeout(interval: timeout)
    }
    
    class func get(forKey key: String) -> Any? {
        guard
            let timeout = UserDefaults.timeoutByKeyList[key],
            let interval = timeout.interval,
            Date().timeIntervalSince(timeout.timestamp) > interval
        else {
            return UserDefaults.standard.object(forKey: key)
        }
        UserDefaults.timeoutByKeyList.removeValue(forKey: key)
        UserDefaults.standard.removeObject(forKey: key)
        return nil
    }
    
    class func clear() {
        if let appDomain = Bundle.main.bundleIdentifier {
            UserDefaults.standard.removePersistentDomain(forName: appDomain)
        }
    }
}
