//
//  Page1ViewController.swift
//  Swift5IntroApp1
//
//  Created by 木村　洸太 on 2020/11/09.
//

import UIKit
import SegementSlide

class Page1ViewController: UITableViewController,SegementSlideContentScrollViewDelegate,XMLParserDelegate {
    
    //XMLパーサーのインスタンス生成
    var perser = XMLParser()
    
    //RSSは『Rich Site Summary（リッチ・サイト・サマリー）』の略でWebサイトの見出しや要約・更新情報などを記述するXMLベースのフォーマット
    //RSS(XML)パース中の現在の要素名
    var currentElementName:String!
    
    //NewsItem型の配列インスタンスを作成
    var newsItem = [NewsItem]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundColor = .clear
        
        //画像をtableViewの下に置く
        let image = UIImage(named: "5")
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.tableView.frame.size.width, height: self.tableView.frame.size.height))
        
        imageView.image = image
        self.tableView.backgroundView = imageView
        
        //XMLパースの解析
        // インターネット上のXMLを取得し、XMLParserに読み込む
        //yahoo
        let urlString = "https://news.yahoo.co.jp/rss/topics/top-picks.xml"
        let url:URL = URL(string: urlString)!
        perser = XMLParser(contentsOf: url)!
        perser.delegate = self
        perser.parse()
        

       }
    
    @objc var scrollView: UIScrollView{
        
        return tableView
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        print("テーブル")
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return newsItem.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.size.height/5
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")

        cell.backgroundColor = .clear
        
        let newsItem = self.newsItem[indexPath.row]
        
        //cell 1行目
        cell.textLabel?.text = newsItem.title
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 15.0)
        cell.textLabel?.textColor = .white
        cell.textLabel?.numberOfLines = 3
        
        //cell 2行目
        cell.detailTextLabel?.text = newsItem.url
        cell.detailTextLabel?.textColor = .white

        return cell
    }
    
    // 解析中に要素の開始タグがあったときに実行されるメソッド
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        
        currentElementName = nil
        if elementName == "item"{
            
            //配列の中にNewsItem型の要素を1つ追加
            //NewsItem型は、title,url,pubDateのプロパティで構成されている
            self.newsItem.append(NewsItem())
            
            print(elementName)
            print(self.newsItem)
            
            
        }else{
            
            currentElementName = elementName
            print(elementName)
        }
        
    }
    
    // 開始タグと終了タグでくくられたデータがあったときに実行されるメソッド
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        
        print("要素:" + string)
        
        if self.newsItem.count > 0{
            
            let lastItem = self.newsItem[self.newsItem.count - 1]
            
            switch self.currentElementName {
            case "title":
                lastItem.title = string
                
            case "link":
                lastItem.url = string
                
            case "pubDate":
                lastItem.pubDate = string
                
            default:break
            
            }
        }
    }
    
    // 解析中に要素の終了タグがあったときに実行されるメソッド
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        print(elementName)
        
        self.currentElementName = nil
    }
    
    func parserDidEndDocument(_ parser: XMLParser) {
        
        print(self.newsItem)
        
        self.tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //WebViewControllerにurl(キー)を渡して表示したい
        let webView = WebViewController()
        webView.modalTransitionStyle = .crossDissolve
        let news = newsItem[indexPath.row]
        UserDefaults.standard.set(news.url, forKey: "url")
        
        //webViewに画面遷移
        present(webView, animated: true, completion: nil)
        
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
