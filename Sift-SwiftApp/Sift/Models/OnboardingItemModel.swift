//
//  OnboardingItemModel.swift
//  Sift
//
//  Created by Edward Day on 14/02/2023.
//

import SwiftUI
import Lottie

struct OnboardingItem: Identifiable, Equatable{
    var id: UUID = .init()
    var title: String
    var subtitle: String
    var lottieView: LottieAnimationView = .init()
}
