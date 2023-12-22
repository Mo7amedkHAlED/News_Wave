//
//  UIApplication.swift
//  News App
//
//  Created by Mohamed Khaled Gomaa on 16/12/2023.
//

import Foundation
import SwiftUI

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
