//
//  RecipeDetailView.swift
//  EmpowermentsLabsChallenge
//
//  Created by Sergio Geovanny Giraldo Aristizabal on 1/11/22.
//

import CoreModule
import UIKit

final class RecipeDetailView: UIView, RecipeDetailViewType {
    private lazy var productImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = .white

        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var componentContainerView: UIView = {
        let view = UIView(frame: .zero)
        view.clipsToBounds = true
        view.layer.cornerCurve = .continuous
        view.layer.cornerRadius = 20.0
        view.layer.masksToBounds = true
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

    private lazy var componentStackView: UIStackView = {
        let view = UIStackView(frame: .zero)
        view.backgroundColor = .white
        view.distribution = .fillProportionally
        view.alignment = .center
        view.spacing = 5
        view.axis = .vertical

        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var titleLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.numberOfLines = 0
        view.textAlignment = .center
        view.lineBreakMode = .byWordWrapping
        view.font = UIFont.systemFont(ofSize: 20, weight: .heavy)
        view.textColor = Theme.Color.primary

        return view
    }()

    private lazy var healthScoreLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.numberOfLines = 0
        view.textColor = .darkGray
        view.textAlignment = .center
        view.lineBreakMode = .byWordWrapping
        view.font = UIFont.systemFont(ofSize: 14, weight: .light)

        return view
    }()

    private lazy var pricePerServingLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 0
        label.textColor = .darkGray
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont.systemFont(ofSize: 14, weight: .light)

        return label
    }()

    private lazy var instructionContainerView: UIView = {
        let view = UIView(frame: .zero)
        view.clipsToBounds = true
        view.layer.cornerCurve = .continuous
        view.layer.cornerRadius = 20.0
        view.layer.masksToBounds = true
        view.layer.borderWidth = 3.0
        view.layer.borderColor = UIColor.white.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

    private lazy var instructionsTextView: UITextView = {
        let view = UITextView(frame: .zero)
        view.textAlignment = .center
        view.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    fileprivate func setupMainImage() {
        addSubview(productImageView)

        NSLayoutConstraint.activate([
            productImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            productImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            productImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            productImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.4),
        ])
    }

    fileprivate func setupComponentStackView() {
        addSubview(componentContainerView)
        componentContainerView.addSubview(componentStackView)

        componentStackView.addArrangedSubview(titleLabel)
        componentStackView.addArrangedSubview(healthScoreLabel)
        componentStackView.addArrangedSubview(pricePerServingLabel)

        NSLayoutConstraint.activate([
            componentContainerView.topAnchor.constraint(equalTo: productImageView.bottomAnchor, constant: -20),
            componentContainerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            componentContainerView.trailingAnchor.constraint(equalTo: trailingAnchor),

            componentStackView.leadingAnchor.constraint(equalTo: componentContainerView.leadingAnchor, constant: 10),
            componentStackView.topAnchor.constraint(equalTo: componentContainerView.topAnchor, constant: 30),
            componentStackView.trailingAnchor.constraint(equalTo: componentContainerView.trailingAnchor, constant: -10),
            componentStackView.bottomAnchor.constraint(equalTo: componentContainerView.bottomAnchor, constant: -10),
        ])
    }

    private func initialSetup() {
        setupMainImage()
        setupComponentStackView()

        addSubview(instructionContainerView)
        instructionContainerView.addSubview(instructionsTextView)

        NSLayoutConstraint.activate([
            instructionContainerView.topAnchor.constraint(equalTo: componentStackView.bottomAnchor, constant: 15),
            instructionContainerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25),
            instructionContainerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25),
            instructionContainerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -25),

            instructionsTextView.leadingAnchor.constraint(equalTo: instructionContainerView.leadingAnchor, constant: 5),
            instructionsTextView.topAnchor.constraint(equalTo: instructionContainerView.topAnchor, constant: 5),
            instructionsTextView.trailingAnchor.constraint(equalTo: instructionContainerView.trailingAnchor, constant: -5),
            instructionsTextView.bottomAnchor.constraint(equalTo: instructionContainerView.bottomAnchor, constant: -5),
        ])
    }
}

extension RecipeDetailView {
    func setupView(with data: RecipeInformation) {
        titleLabel.text = data.title
        healthScoreLabel.text = "Health score: \(data.healthScore)"
        pricePerServingLabel.text = "Price per serving: $ \(data.pricePerServing)"

        instructionContainerView.layer.borderColor = Theme.Color.primary.cgColor
        instructionsTextView.text = data.instructions

        guard let image = data.imageURL else {
            productImageView.image = Theme.Images.notImage
            return
        }

        productImageView.downloadImage(from: image, placeHolder: Theme.Images.notImage)
    }
}
