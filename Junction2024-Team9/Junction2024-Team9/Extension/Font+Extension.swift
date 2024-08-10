//
//  Font+Extension.swift
//  Junction2024-Team9
//
//  Created by 박현수 on 8/10/24.
//

import Foundation
import SwiftUI

extension Font {
    static func paperlogy(size: CGFloat, weight: Font.Weight) -> Font {
        switch weight {
        case .thin:
            return  Font.custom("Paperlogy-1Thin", size: size)
        case .ultraLight:
            return  Font.custom("Paperlogy-2ExtraLight", size: size)
        case .light:
            return  Font.custom("Paperlogy-3Light", size: size)
        case .regular:
            return  Font.custom("Paperlogy-4Regular", size: size)
        case .medium:
            return  Font.custom("Paperlogy-5Medium", size: size)
        case .semibold:
            return Font.custom("Paperlogy-6SemiBold", size: size)
        case .bold:
            return Font.custom("Paperlogy-7Bold", size: size)
        case .heavy:
            return Font.custom("Paperlogy-8ExtraBold", size: size)
        case .black:
            return Font.custom("Paperlogy-9Black", size: size)
        default:
            return Font.system(size: size)
        }
    }
}
