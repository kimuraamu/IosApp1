//
//  BaseViewController.swift
//  Swift5IntroApp1
//
//  Created by 木村　洸太 on 2020/11/08.
//

import UIKit
import SegementSlide

class BaseViewController: SegementSlideDefaultViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        reloadData()
        //タブの初期位置
        defaultSelectedIndex = 0
    }
    

    //ヘッダーの設定
    override func segementSlideHeaderView() -> UIView? {
        
        let headerView = UIImageView()

        headerView.isUserInteractionEnabled = true
        headerView.contentMode = .scaleAspectFill
        headerView.image = UIImage(named: "てく")
        headerView.translatesAutoresizingMaskIntoConstraints = false

        let headerHeight: CGFloat

        if #available(iOS 11.0, *) {

        headerHeight = view.bounds.height/4+view.safeAreaInsets.top

        } else {

        headerHeight = view.bounds.height/4+topLayoutGuide.length

        }

        headerView.heightAnchor.constraint(equalToConstant: headerHeight).isActive = true

        return headerView
    }
    
    
    //タイトルの設定
    override var titlesInSwitcher: [String] {

    return ["Yahoo","World","Sony","Entertainment","IT"]

    }
    
    //Controllerを返している
    override func segementSlideContentViewController(at index: Int) -> SegementSlideContentScrollViewDelegate? {


    switch index {

    //TOP
    case 0:
    return Page1ViewController()

    //Abema
    case 1:
    return Page2ViewController()

    //Yahoo
    case 2:
    return Page3ViewController()

    //IT
    case 3:
    return Page4ViewController()

    //Buzz
    case 4:
    return Page5ViewController()

    default:

    return Page1ViewController()

    }


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
