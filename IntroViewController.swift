//
//  IntroViewController.swift
//  Swift5IntroApp1
//
//  Created by 木村　洸太 on 2020/11/08.
//

import UIKit
import Lottie

class IntroViewController: UIViewController,UIScrollViewDelegate {
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    var onboardArray = ["10"]
    
    var onboardStringArray = ["GO!!"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.isPagingEnabled = true
        
        setUpScroll()
        
       
            
            let animationView = AnimationView()
            let animation = Animation.named(onboardArray[0])
            animationView.frame = CGRect(x: CGFloat(0) * view.frame.size.width, y: 0, width: view.frame.size.width, height: view.frame.size.height)
            animationView.animation = animation
            animationView.contentMode = .scaleAspectFit
            animationView.loopMode = .loop
            animationView.play()
            scrollView.addSubview(animationView)
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = true
    }
    
    func setUpScroll(){
        
        scrollView.delegate = self
        
        //スクロールビューの稼働領域
        scrollView.contentSize = CGSize(width: view.frame.size.width * 5, height: view.frame.size.height)
        
            
            let onboardLabel = UILabel(frame: CGRect(x: CGFloat(0) * view.frame.size.width, y: view.frame.size.height / 3, width: scrollView.frame.size.width, height: scrollView.frame.size.height))
            
            onboardLabel.font = UIFont.boldSystemFont(ofSize: 15.0)
            onboardLabel.textAlignment = .center
            onboardLabel.text = onboardStringArray[0]
            scrollView.addSubview(onboardLabel)
        
        
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
