//
//  GiftPackageCollectionCell.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 29.09.2023.
//

import UIKit
import RevenueCat

final class GiftPackageCollectionCell: UICollectionViewCell {
    static let identifier = "GiftPackageCollectionCell"
    
    //MARK: - Creating UI Elements
    private lazy var selectImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = .init(named: "chat_checkmark_circle")
        imageView.tintColor = .white.withAlphaComponent(0.5)
        return imageView
    }()
    
    private lazy var packageInfoVStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 5
        return stackView
    }()
    
    private lazy var packageTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .white
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var packageInfoHStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 5
        return stackView
    }()
    
    private lazy var expensivePackageLabel: StrikethroughLabel = {
        let label = StrikethroughLabel()
        label.textAlignment = .left
        label.textColor = .white.withAlphaComponent(0.5)
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var cheapPackageLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .white
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.numberOfLines = 2
        return label
    }()

    //MARK: - Init Methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Layout Subviews
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = 12
        self.layer.masksToBounds = true
        
    }
    
    
    func configure(with packageTuple: (expensivePackage: Package, cheapPackage: Package)) {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            switch packageTuple.cheapPackage.packageType {
            case .weekly:
                packageTitleLabel.text = "Weekly".localized()

                expensivePackageLabel.strikeThroughText = packageTuple.expensivePackage.localizedPriceString

                cheapPackageLabel.text = packageTuple.cheapPackage.localizedPriceString
            case .monthly:
                packageTitleLabel.text = "Monthly".localized()

                expensivePackageLabel.strikeThroughText = packageTuple.expensivePackage.localizedPriceString

                cheapPackageLabel.text = packageTuple.cheapPackage.localizedPriceString
            case .annual:
                packageTitleLabel.text = "Yearly".localized()

                expensivePackageLabel.strikeThroughText = packageTuple.expensivePackage.localizedPriceString

                cheapPackageLabel.text = packageTuple.cheapPackage.localizedPriceString
            default:
                break
            }
        }
    }

    func selectCell() {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            let growAnimation = CABasicAnimation(keyPath: "borderWidth")
            growAnimation.fromValue = 0
            growAnimation.toValue = 2.5
            growAnimation.duration = 0.3
            growAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
            self.layer.add(growAnimation, forKey: "grow")
            self.layer.borderWidth = 2.5
            self.layer.borderColor = UIColor.main.cgColor
            selectImageView.image = .init(named: "chat_checkmark_circle_fill")
        }
    }
    
    func deselectCell() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            // Çekilmek istenen animasyon
            let shrinkAnimation = CABasicAnimation(keyPath: "borderWidth")
            shrinkAnimation.fromValue = 2.5
            shrinkAnimation.toValue = 1.5
            shrinkAnimation.duration = 0.3
            shrinkAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
            
            // Hücrenin kenarlık genişliğini küçültme animasyonunu ekleyin
            self.layer.add(shrinkAnimation, forKey: "shrink")
            
            // Hücrenin kenarlık genişliğini sıfıra ayarlayın
            self.layer.borderWidth = 1.5
            
            // Hücrenin kenarlık rengini istediğiniz renge ayarlayın
            self.layer.borderColor = UIColor.white.withAlphaComponent(0.3).cgColor
            
            // Deselect görüntüsünü değiştirin (örneğin, bir boş işaretleme simgesine)
            selectImageView.image = .init(named: "chat_checkmark_circle")
        }
        
    }
}



//MARK: - AddSubview / Constraints
extension GiftPackageCollectionCell {
    private func setupViews() {
        backgroundColor = .clear
        addSubview(selectImageView)
        
        addSubview(packageInfoVStackView)
        packageInfoVStackView.addArrangedSubview(packageTitleLabel)
        packageInfoVStackView.addArrangedSubview(packageInfoHStackView)
        
        packageInfoHStackView.addArrangedSubview(expensivePackageLabel)
        packageInfoHStackView.addArrangedSubview(cheapPackageLabel)
        
        selectImageView.snp.makeConstraints { make in
            make.leading.equalTo(self.safeAreaLayoutGuide.snp.leading).offset(10)
            make.centerY.equalTo(self.safeAreaLayoutGuide.snp.centerY)
            make.height.width.equalTo(self.safeAreaLayoutGuide.snp.height).multipliedBy(0.5)
        }
        
        packageInfoVStackView.snp.makeConstraints { make in
            make.centerY.equalTo(self.safeAreaLayoutGuide.snp.centerY)
            make.height.lessThanOrEqualTo(self.safeAreaLayoutGuide.snp.height)
            make.leading.equalTo(selectImageView.snp.trailing).offset(10)
            make.trailing.lessThanOrEqualTo(self.safeAreaLayoutGuide.snp.trailing).offset(-10)
        }
    }
}

