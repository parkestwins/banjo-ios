//
//  UIViewController+Alert.swift
//  Banjo
//
//  Created by Jarrod Parkes on 1/14/17.
//  Copyright © 2017 ParkesTwins. All rights reserved.
//

import UIKit

// MARK: - UIViewController (Alert)

extension UIViewController {

    func displayDismissAlert(title: String, message: String, dismissHandler: ((UIAlertAction) -> Void)?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: AppConstants.Strings.dismiss, style: .default, handler: dismissHandler)        
        alertController.addAction(dismissAction)
        present(alertController, animated: true, completion: nil)
    }
}
