//
//  UIViewController+MP.swift
//  MATRIX Pay
//
//  Created by Nikolai Vazquez on 6/10/17.
//  Copyright © 2017 MATRIX Labs. All rights reserved.
//

import UIKit

extension UIViewController {

    @IBAction func exitToRoot(_ sender: Any) {
        if type(of: self) == RegisterViewController.self {
            socket.emit(cancelFor: .register)
        }
        if type(of: self) == PaymentViewController.self {
            socket.emit(cancelFor: .payment)
        }
        navigationController?.popToRootViewController(animated: true)
    }

    @IBAction func exitToPrevious(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }

    static func instantiate(from storyBoard: UIStoryboard?) -> Self? {
        func helper<T>() -> T? {
            let id = String(describing: T.self)
            let result = storyBoard?.instantiateViewController(withIdentifier: id)
            return result as? T
        }
        return helper()
    }

    func push<T: UIViewController>(viewController: T.Type, animated: Bool) {
        guard let vc = T.instantiate(from: storyboard) else {
            return
        }
        navigationController?.pushViewController(vc, animated: animated)
    }

    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    func dismissKeyboard() {
        view.endEditing(true)
    }

}
