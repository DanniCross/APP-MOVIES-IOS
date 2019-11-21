//
//  ViewController.swift
//  Movies
//
//  Created by Prog on 11/10/19.
//  Copyright © 2019 Prog. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var TxtTitle: UITextField!
    @IBOutlet weak var LblTitle: UILabel!
    @IBOutlet weak var LblLanguage: UILabel!
    @IBOutlet weak var LblReleased: UILabel!
    @IBOutlet weak var LblRuntime: UILabel!
    @IBOutlet weak var LblGenre: UILabel!
    @IBOutlet weak var LblDirector: UILabel!
    @IBOutlet weak var LblActors: UILabel!
    @IBOutlet weak var LblPlot: UILabel!
    @IBOutlet weak var Image: UIImageView!
    
    
    @IBAction func GetInfo(_ sender: Any) {
        let movie = TxtTitle.text!
        let encMovie = movie.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        let key = "e8b83b09"
        let service = "https://www.omdbapi.com/"
        let args = "t=\(encMovie))&apikey=\(key)"
        let fullpath = "\(service)?\(args)"
        print(fullpath)
        
        if let url = URL(string: fullpath) {
            downloadInfo(url)
        }
        LblPlot.text = ""
        LblTitle.text = ""
        LblReleased.text = ""
        LblRuntime.text = ""
        LblGenre.text = ""
        LblDirector.text = ""
        LblActors.text = ""
        LblLanguage.text = ""
    }
    
    
    func downloadInfo(_ url: URL) {
        URLSession.shared.dataTask(with: url) { (data, url, error) in do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                let root: Root = try decoder.decode(Root.self, from: data!)
            
                DispatchQueue.main.async {
                    self.LblReleased.text = "\(root.Released)"
                    self.LblTitle.text = "\(root.Title)"
                    self.LblRuntime.text = "\(root.Runtime)"
                    self.LblGenre.text = "\(root.Genre)"
                    self.LblLanguage.text = "\(root.Language)"
                    self.LblDirector.text = "\(root.Director)"
                    self.LblActors.text = "\(root.Actors)"
                    self.LblPlot.text = "\(root.Plot)"
                    let ipath = "\(root.Poster)"
                    
                    if let urlI = URL(string: ipath) {
                        self.GetImage(urlI)
                    }
                }
            
        }catch{
        }
            
        }.resume()
    }
    
    func GetImage(_ url: URL) {
        URLSession.shared.dataTask(with: url) { (data, url, error) in
            if let ImgData = data {
                DispatchQueue.main.async {
                    self.Image.image = UIImage(data: ImgData)
                }
            }
            
        }.resume()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

