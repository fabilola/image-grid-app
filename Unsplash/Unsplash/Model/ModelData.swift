//
//  ModelData.swift
//  Unsplash
//
//  Created by Fabiola Dums on 19.03.23.
//

import Foundation

final class ModelData: ObservableObject {
    @Published var images: [UnsplashImageElement] = []
    
    @Published var showAlert: Bool = false
    @Published var alertTitle: String = ""
    @Published var alertText: String = ""
        
    private let baseAPIUrl = "https://api.unsplash.com/search/photos/?"
    
    private let accesKey = Bundle.main.infoDictionary!["API_KEY"] as! String
   
    func getImages(searchKeyword: String) {
        let urlStr = buildUrl(searchKeyword: searchKeyword)
        
        guard let url = URL(string: urlStr.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "") else { fatalError("Missing URL")}
        
        let urlRequest = URLRequest(url: url)
        
        let dataTask = URLSession.shared.dataTask(with: urlRequest){ (data, response, error) in
            if let error = error {
                print("Request error: ", error)
                return
            }
            guard let response = response as? HTTPURLResponse else { return }
            
            if response.statusCode == 200 {
                guard let data = data else { return }
                DispatchQueue.main.async {
                    do {
                        let decodeImages = try JSONDecoder().decode(UnsplashImage.self, from: data)
                        if(!decodeImages.results.isEmpty) {
                            self.images = decodeImages.results
                        } else{
                            self.setAlert(title: "No Results!", text: "There are not results for the keyword: '" + searchKeyword + "'. Please try again with a different keyword.")
                        }
       
                    } catch let error {
                        print("Error decoding:", error)
                        self.setAlert(title: "Oops!", text: "Something went wrong. Please try again.")
                    }
                }
            } else {
                self.setAlert(title: "Oops!", text: "Unsplash seems unavailable. Please try again later.")
            }
        }
        dataTask.resume()
    }
    
    private func buildUrl(searchKeyword: String) -> String {
        let keyword = searchKeyword.replacingOccurrences(of: " ", with: "-")
        
        let urlStr = self.baseAPIUrl + "client_id=" + self.accesKey + "&order_by=popular&per_page=30&query=" + keyword
        return urlStr
    }
    
    func clearImages(){
        self.images = []
    }
    
    private func setAlert(title: String, text: String){
        self.alertTitle = title
        self.alertText = text
        self.showAlert = true
    }
}
