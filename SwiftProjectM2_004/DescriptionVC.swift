//
//  DescriptionVC.swift
//  SwiftProjectM2_004
//
//  Created by Irinka Datoshvili on 10.04.24.
//

import UIKit

class DescriptionVC: UIViewController {

    var zodiacTitle: String = ""
    var zodiacDescription: String = ""
    var zodiacImageName: String = ""
    
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
        addZodiacStackView()
        addTextStackView()
        searchPolarSign()
        
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
        mainSV.spacing = 30
        mainSV.distribution = .fillProportionally
        
        
        self.view.addSubview(mainSV)
        NSLayoutConstraint.activate([
            mainSV.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            mainSV.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            mainSV.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            mainSV.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30)

        ])
    }
    
    func addZodiacStackView() {
        let zodiacImgV = UIImageView(image: UIImage(named: "\(zodiacImageName.lowercased())"))
        zodiacSv.axis = .vertical
        zodiacSv.alignment = .center
        zodiacSv.distribution = .fill
        zodiacSv.spacing = -12
        zodiacSv.translatesAutoresizingMaskIntoConstraints = false
        zodiacImgV.contentMode = .scaleAspectFill

        let title = UILabel()
        title.text = zodiacTitle
        title.textColor = .white
        title.font = UIFont.systemFont(ofSize: 24)
        
        zodiacSv.addArrangedSubview(zodiacImgV)
        zodiacSv.addArrangedSubview(title)
        mainSV.addArrangedSubview(zodiacSv)
        
        NSLayoutConstraint.activate([
            zodiacSv.topAnchor.constraint(equalTo: mainSV.topAnchor, constant: 55),
       
        ])
    }
    
    func addTextStackView() {
        textStackView.axis = .vertical
        textStackView.translatesAutoresizingMaskIntoConstraints = false
        textStackView.distribution = .fill
        
        let description = UITextView()
        
        description.text = zodiacDescription
        
        description.font = UIFont.systemFont(ofSize: 14)
        description.isEditable = false
        description.textColor = UIColor(red: 139/255, green: 139/255, blue: 139/255, alpha: 1.0)
        description.backgroundColor = .none
        description.isScrollEnabled = false

        textStackView.addArrangedSubview(description)
        
        mainSV.addArrangedSubview(textStackView)
        
        NSLayoutConstraint.activate([
//            textStackView.topAnchor.constraint(equalTo: zodiacSv.bottomAnchor, constant: 30),
//            textStackView.leadingAnchor.constraint(equalTo: mainSV.leadingAnchor)

        ])
        
    }
    
    func searchPolarSign() {
        let st = UIStackView()
        st.translatesAutoresizingMaskIntoConstraints = false
        st.distribution = .fill
        let polarSignButton = UIButton(type: .system)
        polarSignButton.setTitle("პოლარული ნიშანი", for: .normal)
        polarSignButton.setTitleColor(.white, for: .normal)
                
        polarSignButton.backgroundColor = UIColor(red: 80/255, green: 0/255, blue: 182/255, alpha: 1.0)
                
        polarSignButton.layer.cornerRadius = 12.0
        polarSignButton.layer.masksToBounds = true
        polarSignButton.translatesAutoresizingMaskIntoConstraints = false
        st.addArrangedSubview(polarSignButton)
        mainSV.addArrangedSubview(st)
        
        polarSignButton.addTarget(self, action: #selector(moveToPolarSignPage), for: .touchUpInside)
        
//        polarSignButton.contentEdgeInsets = UIEdgeInsets(top: 14, left: 0, bottom: 14, right: 0)

        
        NSLayoutConstraint.activate([
            st.topAnchor.constraint(equalTo: textStackView.bottomAnchor, constant: 10),
            st.leadingAnchor.constraint(equalTo: mainSV.leadingAnchor),
            st.trailingAnchor.constraint(equalTo: mainSV.trailingAnchor),
            st.heightAnchor.constraint(equalToConstant: 46)

            
        ])
    }
    
    @objc func moveToPolarSignPage() {
        guard let oppositeSign = Zodiac.zodiac(forName: zodiacTitle) else {
            print("Opposite sign not found")
            return
        }
    
        let polarSignPage = OppositeSignVC()
        polarSignPage.oppositeZodiac = oppositeSign.polarSign
        polarSignPage.oppositeSignImg = oppositeSign.imageName
        
        self.navigationController?.pushViewController(polarSignPage, animated: true)
    }
}

#Preview {
    DescriptionVC()
}

