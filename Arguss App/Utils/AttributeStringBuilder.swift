//
//  AttributeStringBuilder.swift
//  Arguss App
//
//  Created by Diego Atencia on 20/04/2021.
//  Copyright © 2021 Diego Atencia. All rights reserved.
//

import Foundation
import UIKit

typealias Attributes = [NSAttributedString.Key: Any]

enum FontAtrribute {
    case bold(CGFloat), semibold(CGFloat), regular(CGFloat), medium(CGFloat), light(CGFloat), extraBold(CGFloat)

    var attribute: Attributes {
        return [.font: font]
    }

    var font: UIFont {
        switch self {
        case .light(let size):
            return .montserrat(style: .light, size: size)
        case .regular(let size):
            return .montserrat(style: .regular, size: size)
        case .medium(let size):
            return .montserrat(style: .medium, size: size)
        case .semibold(let size):
            return .montserrat(style: .semiBold, size: size)
        case .bold(let size):
            return .montserrat(style: .bold, size: size)
        case .extraBold(let size):
            return .montserrat(style: .extraBold, size: size)
        }
    }
}

class AttributeStringBuilder {
    private(set) var attributes = NSMutableDictionary()

    func color(_ color: UIColor) -> AttributeStringBuilder {
        attributes.addEntries(from: [NSAttributedString.Key.foregroundColor: color])
        return self
    }

    func font(_ attribute: FontAtrribute) -> AttributeStringBuilder {
        attributes.addEntries(from: attribute.attribute)
        return self
    }

    func underline(_ style: NSUnderlineStyle) -> AttributeStringBuilder {
        attributes.addEntries(from: [NSAttributedString.Key.underlineStyle: style.rawValue])
        return self
    }

    func underlineColor(_ color: UIColor) -> AttributeStringBuilder {
       attributes.addEntries(from: [NSAttributedString.Key.underlineColor: color])
       return self
    }

    func kern(_ value: CGFloat) -> AttributeStringBuilder {
        attributes.addEntries(from: [NSAttributedString.Key.kern: value])
        return self
    }

    func strikethroughStyle(_ style: NSUnderlineStyle) -> AttributeStringBuilder {
        attributes.addEntries(from: [NSAttributedString.Key.strikethroughStyle: style.rawValue])
        return self
    }

    func strikethroughColor(_ color: UIColor) -> AttributeStringBuilder {
       attributes.addEntries(from: [NSAttributedString.Key.strikethroughColor: color])
       return self
    }

    func spacing(_ spacing: CGFloat) -> AttributeStringBuilder {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = spacing
        paragraphStyle.alignment = .center
        attributes.addEntries(from: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        return self
    }

    func build() -> Attributes {
        return (attributes as? Attributes) ?? [:]
    }
}

