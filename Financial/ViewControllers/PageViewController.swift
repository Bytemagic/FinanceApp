//
//  PageViewController.swift
//  Financial
//
//  Created by Mac on 01.12.2025.
//

import UIKit

class PageViewController: UIPageViewController {
    
    let informationScreenData =
    ["Здравствуй!",
     "С помощью приложения ты узнаешь на сколько хватит денег",
     "Введи стартовую сумму денег и средние расходы за день",
     "Удачи тебе"
    ]
    let emojiScreen =
    [
        "👋","🤑","💵","🤘"
    ]
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        dataSource = self
        
        if let viewController = createViewControllerAtIndex(0)
        {
            setViewControllers([viewController], direction: .forward, animated: true)
        }
    }
    
    
    private func createViewControllerAtIndex(_ index:Int) -> ContentViewController?
    {
        guard index >= 0 else { return nil}
        guard index < informationScreenData.count else {return nil}
        guard let viewController = storyboard?.instantiateViewController(withIdentifier: "ContentViewController") as? ContentViewController
        else {return nil}
                
        viewController.emojiText = emojiScreen[index]
        viewController.presentText = informationScreenData[index]
        viewController.currentPage = index
        viewController.numberOfPages = informationScreenData.count
     
        return viewController
    }
    
    
    
}
extension PageViewController : UIPageViewControllerDataSource
{
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        var pageNumber = (viewController as! ContentViewController).currentPage
        pageNumber -= 1
        return createViewControllerAtIndex(pageNumber)
        
    }
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        var pageNumber = (viewController as! ContentViewController).currentPage
        pageNumber += 1
        return createViewControllerAtIndex(pageNumber)
        
    }
    
    
    
}
