//
//  ApplicationUtility.swift
//  Sift
//
//  Created by Edward Day on 05/03/2023.
//

import Foundation
import SwiftUI

final class ApplicationUtility{
    static var rootViewController: UIViewController{
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return .init()
        }
        guard let root = screen.windows.first?.rootViewController else {
            return .init()
        }
        return root
    }
}
