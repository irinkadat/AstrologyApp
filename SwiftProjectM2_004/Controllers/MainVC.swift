//
//  ViewController.swift
//  SwiftProjectM2_004
//
//  Created by Irinka Datoshvili on 10.04.24.
//

import UIKit


class MainVC: UIViewController, ColorUpdateDelegate {
    
    
    
    let backgroundImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "backgroundImg"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let mainSV = UIStackView()
    let inputField = UITextField()
    let textStackView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(backgroundImageView)
        configureBackground()
        addMainSV()
        addTextStackView()
        addInputField()
        addNextButton()
        
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
        mainSV.spacing = 91
        mainSV.distribution = .fill
        
        
        self.view.addSubview(mainSV)
        NSLayoutConstraint.activate([
            mainSV.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 71),
            mainSV.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            mainSV.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
        ])
    }
    
    func addTextStackView() {
        textStackView.axis = .vertical
        textStackView.translatesAutoresizingMaskIntoConstraints = false
        textStackView.distribution = .fill
        textStackView.spacing = 20
        
        let title = UILabel()
        let description = UITextView()
        
        title.text = "მიშა ცაგარელის ჰაბი"
        title.textColor = .white
        title.font = UIFont.systemFont(ofSize: 24)
        
        description.text = "მოცემულ აპლიკაციაში შეგიძლიათ გაიგოთ თქვენი ზოდიაქოს ყველაზე გამოკვეთილი უნარები და თვისებები."
        
        description.font = UIFont.systemFont(ofSize: 16)
        description.isEditable = false
        description.textColor = UIColor(red: 139/255, green: 139/255, blue: 139/255, alpha: 1.0)
        description.backgroundColor = .none
        description.isScrollEnabled = false
        
        
        textStackView.addArrangedSubview(title)
        textStackView.addArrangedSubview(description)
        
        
        mainSV.addArrangedSubview(textStackView)
        
        NSLayoutConstraint.activate([
            textStackView.topAnchor.constraint(equalTo: mainSV.topAnchor, constant: 4)
        ])
    }
    
    func addInputField() {
        let inputFieldSV = UIStackView()
        inputFieldSV.axis = .vertical
        inputFieldSV.translatesAutoresizingMaskIntoConstraints = false
        inputFieldSV.distribution = .fillProportionally
        inputFieldSV.spacing = 4
        
        let zodiacLabel = UILabel()
        zodiacLabel.text = "ზოდიაქოს სახელი"
        zodiacLabel.textColor = .white
        zodiacLabel.font = UIFont.systemFont(ofSize: 12)
        
        inputField.placeholder = "მერწყული"
        inputField.textColor = .white
        inputField.font = UIFont.systemFont(ofSize: 12)
        
        inputField.layer.borderWidth = 1.0
        inputField.layer.cornerRadius = 4.0
        inputField.layer.borderColor = UIColor(red: 221/255, green: 221/255, blue: 221/255, alpha: 1.0).cgColor
        
        inputField.layer.borderWidth = 1.0
        inputField.layer.masksToBounds = true
        
        let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: 1))
        inputField.leftView = leftPaddingView
        inputField.leftViewMode = .always
        
        let placeholderColor = UIColor(red: 125/255, green: 126/255, blue: 131/255, alpha: 1.0)
        let attributedPlaceholder = NSAttributedString(string: inputField.placeholder!, attributes: [NSAttributedString.Key.foregroundColor: placeholderColor])
        
        inputField.attributedPlaceholder = attributedPlaceholder
        inputFieldSV.addArrangedSubview(zodiacLabel)
        inputFieldSV.addArrangedSubview(inputField)
        
        mainSV.addArrangedSubview(inputFieldSV)
        
        NSLayoutConstraint.activate([
            inputFieldSV.heightAnchor.constraint(equalToConstant: 70)
        ])
        
    }
    
    func addNextButton() {
        let nextButton = UIButton(type: .system)
        nextButton.setTitle("შესვლა", for: .normal)
        nextButton.setTitleColor(.white, for: .normal)
        
        nextButton.backgroundColor = UIColor(red: 80/255, green: 0/255, blue: 182/255, alpha: 1.0)
        
        nextButton.layer.cornerRadius = 12.0
        nextButton.layer.masksToBounds = true
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(nextButton)
        
        nextButton.addTarget(self, action: #selector(handleNextButton), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            nextButton.topAnchor.constraint(equalTo: mainSV.bottomAnchor, constant: 25),
            nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextButton.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
            nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            nextButton.heightAnchor.constraint(equalToConstant: 46)
        ])
        
    }
    
    @objc func handleNextButton() {
        guard let userInput = inputField.text else {
            print("User input is empty")
            return
        }
        
        if let zodiac = Zodiac.zodiac(forName: userInput) {
            print("Zodiac found: \(zodiac.sign)")
            print("Description: \(zodiac.description)")
            print("Opposite sign: \(zodiac.polarSign)")
            
            let signInfoPage = DescriptionVC()
            signInfoPage.zodiacTitle = zodiac.sign
            signInfoPage.zodiacDescription = zodiac.description
            signInfoPage.zodiacImageName = zodiac.imageName
            
            self.navigationController?.pushViewController(signInfoPage, animated: true)
            
        } else {
            print("Zodiac not found")
        }
        
    }
    func updateBackgroundColor(to colour: UIColor) {
        
        self.view.backgroundColor = colour
    }
}

#Preview {
    MainVC()
}

