//
//  GF15Button.swift
//  GHFollowersRepetition2
//
//  Created by Jakub Gawecki on 12/06/2021.
//

import UIKit

class GF15ButtonFilled: UIButton {
   // MARK: - Initialisers
   
   
   override init(frame: CGRect) {
      super.init(frame: frame)
   }
   
   
   required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
   
   
   init(buttonTitle: String, subtitle: String?, image: UIImage?, color: UIColor) {
      super.init(frame: .zero)
      configure(buttonTitle: buttonTitle, subtitle: subtitle, image: image, color: color)
   }
   
   
   // MARK: - Configurations
   
   private func configure(buttonTitle: String, subtitle: String?, image: UIImage?, color: UIColor) {
      var configuration                   = UIButton.Configuration.filled()
      
      configuration.cornerStyle           = UIButton.Configuration.CornerStyle.large
      configuration.title                 = buttonTitle
      configuration.baseBackgroundColor   = color
      
      if ((image) != nil) {
         configuration.image              = image
//         configuration.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration.init(scale: .large)
      }
      
      configuration.buttonSize            = .large
      
      if (subtitle != nil) {
         configuration.subtitle           = subtitle
      }
      
      translatesAutoresizingMaskIntoConstraints = false
      self.configuration                        = configuration
   }
}
