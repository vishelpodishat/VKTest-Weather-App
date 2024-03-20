//
//  UIFont+Extension.swift
//  WeatherApp
//
//  Created by Alisher Saideshov on 20.03.2024.
//

import UIKit


extension UIFont {
    enum SFPro {
        enum medium {
            static func size(of size: CGFloat) -> UIFont {
                return UIFont(name: Constants.SFPro.medium, size: size)!
            }
        }
        enum thin {
            static func size(of size: CGFloat) -> UIFont {
                return UIFont(name: Constants.SFPro.thin, size: size)!
            }
        }
        enum bold {
            static func size(of size: CGFloat) -> UIFont {
                return UIFont(name: Constants.SFPro.bold, size: size)!
            }
        }
        enum semiBold {
            static func size(of size: CGFloat) -> UIFont {
                return UIFont(name: Constants.SFPro.semiBold, size: size)!
            }
        }
        enum regular {
            static func size(of size: CGFloat) -> UIFont {
                return UIFont(name: Constants.SFPro.regular, size: size)!
            }
        }
    }
}

private extension UIFont {
    enum Constants {
        enum SFPro {
            static let medium = "SF-Pro-Display-Medium"
            static let thin = "SF-Pro-Display-Thin"
            static let bold = "SF-Pro-Display-Bold"
            static let semiBold = "SF-Pro-Display-Semibold"
            static let regular = "SF-Pro-Display-Regular"
        }
    }
}
