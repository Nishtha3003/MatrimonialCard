//
//  GlobalComponent.swift
//  MatrimonialApp
//
//  Created by Nishtha Verma on 19/12/24.
//

import SwiftUI
import Foundation

func baseUrl() -> String {
    #if DEBUG
    return "https://randomuser.me/"
    #elseif TESTING
    return "https://randomuser.me/"
    #elseif STAGING
    return "https://randomuser.me/"
    #elseif PRODUCTION
    return "https://randomuser.me/"
    #elseif RELEASE
    return "https://randomuser.me/"
    #endif
    return "https://randomuser.me/"
}

extension Font {
    static let regular12Font = Font.custom("Parkinsans-Regular", size: 12)
    static let bold16Font = Font.custom("Parkinsans-Bold", size: 16)
    static let bold24Font = Font.custom("Parkinsans-Bold", size: 24)
    static let bold32Font = Font.custom("Parkinsans-Bold", size: 32)
    static let regular16Font = Font.custom("Parkinsans-Regular", size: 16)
}
