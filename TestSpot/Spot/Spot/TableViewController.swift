//
//  ViewController.swift
//  Spot
//
//  Created by ryoku on 2017/07/19.
//  Copyright © 2017 ryoku. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper

class TableViewController: UITableViewController, UISearchBarDelegate {

    @IBOutlet var searchBar: UISearchBar!
    var searchURL = "https://api.spotify.com/v1/search?q=Taylor+Swift&type=track"

    var keywords: String = ""

    let token = ""

    var serachItems = [SearchItemViewModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        callAlamo(url : searchURL)
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {

        self.view.endEditing(true)

        self.serachItems.removeAll()
        self.keywords = searchBar.text ?? ""

        print("keywords : " + self.keywords)

        callAlamo(url : searchURL)
    }

    func callAlamo(url: String) {

        let headers = [
            "Accept": "application/json",
            "Authorization": "Bearer " + self.token
        ]
        let url = SpotifyAPI.SearchItems(keyword: self.keywords, itemType: .track, limit: 5, ofset: nil)

        print("url : \(url.buildURL())")

        Alamofire.request(url.buildURL(),
                          method: url.method,
                          parameters: nil,
                          encoding: JSONEncoding.default,
                          headers: headers)
            .responseObject { (response: DataResponse<SearchItemMappable>) in

                if case (200..<300)? = response.response?.statusCode {

                    let searchItemResponse = response.result.value

                    guard let items = searchItemResponse?.tracks?.items else {
                        print("Error : Items not exist")
                        return
                    }

                    for item in items {
                        if let name = item.name,
                            let album = item.album,
                            let image = album.images?[0],
                            let artists = album.artists,
                            let imageURL = URL(string: image.url!),
                            let imageData = NSData(contentsOf: imageURL),
                            let imageUI = UIImage(data: imageData as Data) {

                            self.serachItems.append(SearchItemViewModel(name: name, artists:artists, imageUI: imageUI))

                        } else {
                            print("Error : cannot be Instantiation...")
                            debugPrint(item)
                        }

                    }
                    self.tableView.reloadData()

                } else {

                    print("Error : Status Error")
                    debugPrint(response)
                    self.showStatusErrorAlart(title: "Status Error", message: "do you want to reacquire the token?")
                }
        }
    }

    func showStatusErrorAlart(title: String, message: String?) {
        let alert = UIAlertController(title: "Status Error",
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default) {(_) -> Void  in
            print("put on ok button")
        })
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)

    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.serachItems.count

    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")

        let imageView = cell?.viewWithTag(1) as! UIImageView
        imageView.image = self.serachItems[indexPath.row].imageUI

        let songNameLabel = cell?.viewWithTag(2) as! UILabel
        songNameLabel.text = self.serachItems[indexPath.row].name
        songNameLabel.sizeToFit()

        let artistNamelabel = cell?.viewWithTag(3) as! UILabel
        let artists = self.serachItems[indexPath.row].artists

        var artistName: String = ""
        for artist in artists {
            var appendArtistName: String = artist.name ?? ""
            if artist !== artists[artists.startIndex] {
                appendArtistName = ", " + appendArtistName
            }
            artistName = artistName + appendArtistName
        }
//        let artistName = artists[0].name
        artistNamelabel.text = artistName

        return cell!
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let indexPath = self.tableView.indexPathForSelectedRow?.row
        let vc = segue.destination as! AudioVC
        vc.image = self.serachItems[indexPath!].imageUI
        vc.mainSongTitle = self.serachItems[indexPath!].name
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
