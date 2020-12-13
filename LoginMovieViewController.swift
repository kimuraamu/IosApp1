//
//  LoginMovieViewController.swift
//  Swift5IntroApp1
//
//  Created by 木村　洸太 on 2020/11/08.
//

import UIKit
import AVFoundation

class LoginMovieViewController: UIViewController {
    
    var player = AVPlayer()
    
    let videoName = "totakeke"
    let typeName = "mp4"

    override func viewDidLoad() {
        super.viewDidLoad()

        playVideo()
        
        //ループ処理
        //AVPlayerItemDidPlayToEndTime(アニメーションの終わり)を検知したらin以下の処理が実行される
        //AVPlayerItemDidPlayToEndTimeNotification を取得するには、オブジェクトは AVPlayerItem でなければならない
        //これを行うには、AVPlayerの.currentItemプロパティを使用する
        
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: player.currentItem, queue: .main) { (_) in
            
            self.player.seek(to: .zero)
            self.player.play()
        }
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
        
    }
    
    func playVideo(){

        //動画を流す準備
        let path = Bundle.main.path(forResource: videoName, ofType: typeName)
        player = AVPlayer(url: URL(fileURLWithPath: path!))
        
        //AVPlayerのレイヤー(層)を生成
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height)
        
        playerLayer.videoGravity = .resizeAspectFill
        playerLayer.repeatCount = 0
        playerLayer.zPosition = -1
        view.layer.insertSublayer(playerLayer, at: 0)
        
        self.player.play()
        
    }
    
    
    @IBAction func loginBtn(_ sender: Any) {
        
        player.pause()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
