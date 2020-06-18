import Foundation
import UIKit
import SnapKit

@available(iOS 13.0, *)
class ActivityIndicator {
    
    var boxView = UIView()
    let activityView = UIActivityIndicatorView(style: .large)
    let textLabel = UILabel()
    
    func configurarActivityIndicator(viewController: UIViewController){
        let vc = viewController
        
        boxView.addSubview(activityView)
        boxView.addSubview(textLabel)
        vc.view.addSubview(boxView)
        
        //Configurar box
        boxView.backgroundColor = .black
        boxView.alpha = 0.8
        boxView.layer.cornerRadius = 10
        boxView.snp.makeConstraints { (maker) in
            maker.height.width.equalTo(100)
            maker.centerX.equalTo(vc.view.frame.size.width/2)
            maker.centerY.equalTo(vc.view.frame.size.height/2)
        }
        
        //Configurar spin
        activityView.frame = CGRect(x: 30, y: 15, width: 40, height: 40)
        activityView.snp.makeConstraints { (maker) in
            maker.height.width.equalTo(40)
            maker.top.equalTo(15)
            maker.leading.equalTo(30)
        }
        
        //Configurar texto
        textLabel.snp.makeConstraints { (maker) in
            maker.width.equalTo(80)
            maker.height.equalTo(30)
            maker.top.equalTo(60)
            maker.leading.equalTo(10)
        }
        textLabel.textColor = .white
        textLabel.textAlignment = .center
        textLabel.font = UIFont(name: textLabel.font.fontName, size: 13)
        textLabel.text = "Cargando..."
    }
    
    func empezarActivityIndicator(viewController: UIViewController){
        let vc = viewController
        
        configurarActivityIndicator(viewController: vc)
        vc.view.isUserInteractionEnabled = false
        print("Inicio activity indicator")
        activityView.startAnimating()
    }
    
    func terminarActivityIndicator(viewController: UIViewController){
        let vc = viewController
        
        print("Fin activity indicator")
        boxView.removeFromSuperview()
        activityView.stopAnimating()
        vc.view.isUserInteractionEnabled = true
    }
    
}
