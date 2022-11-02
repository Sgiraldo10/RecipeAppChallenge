//
//  ProducListCollectionViewCell.swift
//  ProductList
//
//  Created by Sergio Giraldo on 01/11/22.
//  Copyright © 2022 Cebollitas. All rights reserved.
//

import CoreModule
import UIKit

final class ProducListCollectionViewCell: UICollectionViewCell, CellConfigurable {
    typealias DataType = ProductInformation

    private lazy var mainContainerView: UIView = {
        let view = UIView(frame: .zero)
        view.clipsToBounds = true
        view.layer.cornerCurve = .continuous
        view.layer.cornerRadius = 10.0
        view.layer.masksToBounds = true

        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var productImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = .white
        imageView.layer.opacity = 0.9

        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 0
        label.textColor = .white
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont.systemFont(ofSize: 24, weight: .heavy)
        label.textAlignment = .center
        label.numberOfLines = 2

        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var titleContainer: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .black
        view.alpha = 0.2
        view.clipsToBounds = true
        view.layer.masksToBounds = true
        view.layer.opacity = 0.5
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

    override func awakeFromNib() {
        fatalError("Interface builder has not been implemented")
    }

    private func initialSetup() {
        setupProductImageView()
        setupTitleLabel()
        setupImageContainer()
    }

    private func setupProductImageView() {
        mainContainerView.addSubview(productImageView)

        NSLayoutConstraint.activate([
            productImageView.topAnchor.constraint(equalTo: mainContainerView.topAnchor),
            productImageView.trailingAnchor.constraint(equalTo: mainContainerView.trailingAnchor),
            productImageView.bottomAnchor.constraint(equalTo: mainContainerView.bottomAnchor),
            productImageView.leadingAnchor.constraint(equalTo: mainContainerView.leadingAnchor),
        ])
    }

    private func setupTitleLabel() {
        mainContainerView.addSubview(titleContainer)
        mainContainerView.addSubview(titleLabel)

        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: mainContainerView.leadingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: mainContainerView.bottomAnchor, constant: -5),
            titleLabel.trailingAnchor.constraint(equalTo: mainContainerView.trailingAnchor),

            titleContainer.leadingAnchor.constraint(equalTo: mainContainerView.leadingAnchor),
            titleContainer.bottomAnchor.constraint(equalTo: mainContainerView.bottomAnchor),
            titleContainer.trailingAnchor.constraint(equalTo: mainContainerView.trailingAnchor),
            titleContainer.heightAnchor.constraint(equalTo: titleLabel.heightAnchor, constant: 10),
        ])
    }

    private func setupImageContainer() {
        contentView.addSubview(mainContainerView)

        NSLayoutConstraint.activate([
            mainContainerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            mainContainerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            mainContainerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),
            mainContainerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
        ])
    }

    func configure(with data: ProductInformation) {
        titleLabel.text = data.title
        productImageView.downloadImage(from: data.imageURL, placeHolder: Theme.Images.notImage)
    }
}
