//
//  SceneDelegate.swift
//  WeatherApp_ADS_105
//
//  Created by Priyanka PS on 21/4/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let _ = (scene as? UIWindowScene) else { return }
        guard let location = Location.stored() else { return }
        print("location\(location)")
       
       let forecastID = UserDefaults.standard.integer(forKey: "forecastID")
            print("check\(forecastID)")
        
        guard let navController = self.window?.rootViewController as? UINavigationController else { return }
        
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let locationVC = storyboard.instantiateViewController(identifier: "LocationViewController")
        
        let forecastVC: ForecastTableViewController = (storyboard.instantiateViewController(identifier: "ForecastViewController")as? ForecastTableViewController)!
        forecastVC.location = location
        if forecastID == 0 {
            let currentVC: CurrentWeatherTableViewController = (storyboard.instantiateViewController(identifier: "CurrentWeatherViewController")as? CurrentWeatherTableViewController)!
            currentVC.location = location
            navController.viewControllers = [locationVC,forecastVC, currentVC]
        } else if forecastID == 1 {
            let hourlyVC: HourlyWeatherTableViewController = (storyboard.instantiateViewController(identifier: "HourlyWeatherViewController")as? HourlyWeatherTableViewController)!
            hourlyVC.location = location
            navController.viewControllers = [locationVC,forecastVC, hourlyVC]
        } else {
            let dailyVC: DailyWeatherTableViewController = (storyboard.instantiateViewController(identifier: "DailyWeatherViewController")as? DailyWeatherTableViewController)!
            dailyVC.location = location
            navController.viewControllers = [locationVC,forecastVC, dailyVC]
        }
        
        
        
//
//        navController.viewControllers = [locationVC,forecastVC, currentVC, hourlyVC, dailyVC]
        
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

