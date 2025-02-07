//
//  IntentViewController.swift
//  BookRestaurantUI
//
//  Created by Domiziano Scarcelli on 04/04/23.
//

import IntentsUI
import IntentKit

// As an example, this extension's Info.plist has been configured to handle interactions for INSendMessageIntent.
// You will want to replace this or add other intents as appropriate.
// The intents whose interactions you wish to handle must be declared in the extension's Info.plist.

// You can test this example integration by saying things to Siri like:
// "Send a message using <myApp>"

class IntentViewController: UIViewController, INUIHostedViewControlling {
                
    // Prepare your view controller for the interaction to handle.
    func configureView(for parameters: Set<INParameter>, of interaction: INInteraction, interactiveBehavior: INUIInteractiveBehavior, context: INUIHostedViewContext, completion: @escaping (Bool, Set<INParameter>, CGSize) -> Void) {
      
        guard let intent = interaction.intent as? BookRestaurantIntent else {
            completion(false, Set(), .zero)
            return
        }

      if interaction.intentHandlingStatus == .success ||
          interaction.intentHandlingStatus == .ready {
          if let response = interaction.intentResponse as? BookRestaurantIntentResponse {
            let viewController = ReservationConfirmedViewController(for: intent, with: response)
            attachChild(viewController)
              completion(true, parameters, desiredSize)
          }
        }
        completion(false, parameters, .zero)
      }
    
      private func attachChild(_ viewController: UIViewController) {
        addChild(viewController)
        if viewController.view == nil {
        }
        if let subview = viewController.view {
            view.addSubview(subview)
            subview.translatesAutoresizingMaskIntoConstraints = false
//            // Set the child controller's view to be the exact same size as the parent controller's view.
//            subview.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
//            subview.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
//
//            subview.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//            subview.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        }

//        viewController.didMove(toParent: self)
    }
    
//    var desiredSize: CGSize {
//        return self.extensionContext!.hostedViewMaximumAllowedSize
//    }
      private var desiredSize: CGSize {
          let width = self.extensionContext?.hostedViewMaximumAllowedSize.width ?? 320
          return CGSize(width: width, height: 150)
      }
    
}
