//
//  CountryFlagImageView.swift
//  LeagueLens
//
//  Created by Ahmet Tunahan Bekdaş on 6.04.2024.
//
/*
import UIKit
import SVGKit

final class CountryFlagImageView: UIImageView {
    private var svgImageView: SVGKFastImageView?
    private var dataTask: URLSessionDataTask?
    
    override init (frame: CGRect) {
        super.init(frame: frame)
       //translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")

    }
    
    func downloadLeagueFlagImage(league: ResponseLeague) {
        let headers = APIUrls.APIKey()
        guard let url = URL(string: APIUrls.leagueImageView(leagueCode: (league.country?.code ?? "TR").lowercased())) else {return}
        dataTask = NetworkManager.shared.download(url: url, headers: headers, completion: { [weak self] result in
            guard let self = self else {
                return print("downloadLeagueFlagImage else Error")
            }
            switch result {
            case.success(let data):
                DispatchQueue.main.sync {
                    self.loadSVGImage(data: data)
                }
            case .failure(let error):
                return print("downloadLeagueFlagImage fetcData Error \(error.localizedDescription)")
            }
        })
    }
    
    // Yeni fonksiyon: SVG dosyasını yükler ve UIImage'a dönüştürür
       private func loadSVGImage(data: Data) {
           if let svgImage = SVGKImage(data: data) {
               // SVG dosyasını UIImage'a dönüştür
               let uiImage = svgImage.uiImage
               
               // UIImage'ı ImageView'a yükle
               self.image = uiImage
           } else {
               print("SVG dosyası yüklenemedi.")
           }
       }
}
*/
