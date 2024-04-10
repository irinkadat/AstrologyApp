//
//  OppositeSignVC.swift
//  SwiftProjectM2_004
//
//  Created by Irinka Datoshvili on 10.04.24.
//

import UIKit

class OppositeSignVC: UIViewController {
    var oppositeZodiac: String = ""
    var colorUpdateDelegate: ColorUpdateDelegate?
    var oppositeSignImg: String = ""
    
    let mainSV = UIStackView()
    let zodiacSv = UIStackView()
    let textStackView = UIStackView()
    
    let backgroundImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "backgroundImg"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(backgroundImageView)
        configureBackground()
        
        addMainSV()
        addPolarZodiacSign()
        addButtonsSV()
        
        if let mainVC = self.navigationController?.viewControllers.first as? MainVC {
            colorUpdateDelegate = mainVC
        }
        
    }
    
    func configureBackground() {
        self.view.backgroundColor = UIColor(red: 30/255.0, green: 31/255.0, blue: 36/255.0, alpha: 1.0)
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
    }
    
    func addMainSV() {
        mainSV.axis = .vertical
        mainSV.translatesAutoresizingMaskIntoConstraints = false
        mainSV.spacing = 135
        mainSV.distribution = .fill
        
        
        self.view.addSubview(mainSV)
        NSLayoutConstraint.activate([
            
            mainSV.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            mainSV.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            mainSV.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            //            mainSV.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
            
        ])
    }
    
    func addPolarZodiacSign() {
        let zodiacImgV = UIImageView(image: UIImage(named: "\(oppositeSignImg.lowercased())"))
        zodiacSv.axis = .vertical
        zodiacSv.alignment = .center
        zodiacSv.spacing = 8
        zodiacSv.translatesAutoresizingMaskIntoConstraints = false
        zodiacImgV.contentMode = .scaleAspectFill
        
        let title = UILabel()
        title.text = oppositeZodiac
        title.textColor = .white
        title.font = UIFont.systemFont(ofSize: 24)
        
        zodiacSv.addArrangedSubview(zodiacImgV)
        zodiacSv.addArrangedSubview(title)
        mainSV.addArrangedSubview(zodiacSv)
        
        NSLayoutConstraint.activate([
            zodiacSv.topAnchor.constraint(equalTo: mainSV.topAnchor, constant: 208),
            zodiacSv.heightAnchor.constraint(equalToConstant: 156),
            zodiacSv.widthAnchor.constraint(equalToConstant: 156),
            zodiacSv.centerXAnchor.constraint(equalTo: mainSV.centerXAnchor),
            
        ])
    }
    
    func addButtonsSV() {
        let buttonStackView = UIStackView()
        buttonStackView.axis = .vertical
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        buttonStackView.spacing = 32
        buttonStackView.distribution = .fillEqually
        mainSV.addArrangedSubview(buttonStackView)
        
        let redColor = UIColor(red: CGFloat(0x00) / 255.0, green: CGFloat(0x49) / 255.0, blue: CGFloat(0xB6) / 255.0, alpha: 1.0)
        let blueColor = UIColor(red: CGFloat(0xB6) / 255.0, green: CGFloat(0x16) / 255.0, blue: CGFloat(0x00) / 255.0, alpha: 1.0)
        
        let redButton = createButton(title: "ლურჯი ღილაკი", colour: redColor)
        let blueButton = createButton(title: "წითელი ღილაკი", colour: blueColor)
        
        
        buttonStackView.addArrangedSubview(redButton)
        buttonStackView.addArrangedSubview(blueButton)
        
        mainSV.addSubview(buttonStackView)
        
    }
    
    @objc func backToMain(sender: UIButton) {
        let button = sender
        self.navigationController?.popToRootViewController(animated: true)
        if let delegate = colorUpdateDelegate {
            delegate.updateBackgroundColor(to: button.backgroundColor!)
        } else {
            print("Colour update delegate not set")
        }
    }
    
    func createButton(title: String, colour: UIColor) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 46).isActive = true
        button.backgroundColor = colour
        button.addTarget(self, action: #selector(backToMain(sender: )), for: .touchUpInside)
        
        return button
    }
    
}

#Preview {
    OppositeSignVC()
}

