import Foundation

final class RequestResponseManagerService {
    
    static let shared = RequestResponseManagerService()
    
    var privacyPolicy: URL = URL(string: "https://dev-g5juatkti177rij.api.raw-labs.com/sportano")!
    
    private let session: URLSession = {
        let configuration = URLSessionConfiguration.default
        return URLSession(configuration: configuration)
    }()
    
    func checkIfURLReturns404(_ url: URL, completion: @escaping (Bool) -> Void) {
        let task = session.dataTask(with: url) { (data, response, error) in
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(true) 
                return
            }
            
            completion(httpResponse.statusCode == 404)
        }
        task.resume()
    }
    
    func openGames(success: @escaping (StructedSettings) -> Void, failure: @escaping (Error) -> Void) {
        let urlString = "https://dev-g5juatkti177rij.api.raw-labs.com/sportano"
        guard let url = URL(string: urlString) else {
            failure(RequestError.invalidURL)
            return
        }
        
        let task = session.dataTask(with: url) { [weak self] data, _, error in
            if let error = error {
                DispatchQueue.main.async { failure(error) }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async { failure(RequestError.noData) }
                return
            }
            
            do {
                let settings = try JSONDecoder().decode(StructedSettings.self, from: data)
                self?.privacyPolicy = settings.privacyPolicy
                
                if settings.sumChecked {
                    self?.checkIfURLReturns404(settings.termOfUse) { is404 in
                        DispatchQueue.main.async {
                            success(StructedSettings(
                                privacyPolicy: settings.privacyPolicy,
                                termOfUse: settings.termOfUse,
                                sumChecked: !is404
                            ))
                        }
                    }
                } else {
                    DispatchQueue.main.async {
                        success(settings)
                    }
                }
            } catch {
                DispatchQueue.main.async { failure(error) }
            }
        }
        task.resume()
    }
}

extension RequestResponseManagerService {
    enum RequestError: Error {
        case invalidURL
        case noData
    }
}
