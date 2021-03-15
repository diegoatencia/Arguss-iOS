//
//  NibDesignable.swift
//
//  Copyright (c) 2014 Morten Bøgh
//
//  IMPORTANT: We're keeping this file integrated into the project until NibDesignable's pod is updated to Swift 4.

import UIKit

public protocol NibDesignableProtocol: NSObjectProtocol {
    /**
     Identifies the view that will be the superview of the contents loaded from
     the Nib. Referenced in setupNib().
     
     - returns: Superview for Nib contents.
     */
    var nibContainerView: UIView { get }
    // MARK: - Nib loading

    /**
     Called to load the nib in setupNib().
     
     - returns: UIView instance loaded from a nib file.
     */
    func loadNib() -> UIView
    /**
     Called in the default implementation of loadNib(). Default is class name.
     
     - returns: Name of a single view nib file.
     */
    func nibName() -> String
}

extension NibDesignableProtocol {
    // MARK: - Nib loading

    /**
     Called to load the nib in setupNib().
     
     - returns: UIView instance loaded from a nib file.
     */
    public func loadNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: self.nibName(), bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil)[0] as! UIView // swiftlint:disable:this force_cast
    }

    // MARK: - Nib loading

    /**
     Called in init(frame:) and init(aDecoder:) to load the nib and add it as a subview.
     */
    fileprivate func setupNib() {
        let view = self.loadNib()
        self.nibContainerView.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        let bindings = ["view": view]
        self.nibContainerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[view]|", options: [], metrics: nil, views: bindings))
        self.nibContainerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[view]|", options: [], metrics: nil, views: bindings))
    }
}

extension UIView {
    /**
     Called in the default implementation of loadNib(). Default is class name.
     
     - returns: Name of a single view nib file.
     */
    open func nibName() -> String {
        return type(of: self).description().components(separatedBy: ".").last!
    }
}

@IBDesignable
open class NibDesignable: UIView, NibDesignableProtocol {
    public var nibContainerView: UIView {
        return self
    }

    // MARK: - Initializer
    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.setupNib()
    }

    // MARK: - NSCoding
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupNib()
    }
}

@IBDesignable
open class NibDesignableTableViewCell: UITableViewCell, NibDesignableProtocol {
    public var nibContainerView: UIView {
        return self.contentView
    }

    // MARK: - Initializer
    override public init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupNib()
    }

    // MARK: - NSCoding
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupNib()
    }
}

@IBDesignable
open class NibDesignableTableViewHeaderFooterView: UITableViewHeaderFooterView, NibDesignableProtocol {

    public var nibContainerView: UIView {
        return self.contentView
    }

    // MARK: - Initializer
    override public init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.setupNib()
    }

    // MARK: - NSCoding
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupNib()
    }
}

@IBDesignable
open class NibDesignableControl: UIControl, NibDesignableProtocol {
    public var nibContainerView: UIView {
        return self
    }

    // MARK: - Initializer
    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.setupNib()
    }

    // MARK: - NSCoding
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupNib()
    }
}

@IBDesignable
open class NibDesignableCollectionReusableView: UICollectionReusableView, NibDesignableProtocol {
    public var nibContainerView: UIView {
        return self
    }

    // MARK: - Initializer
    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.setupNib()
    }

    // MARK: - NSCoding
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupNib()
    }
}

@IBDesignable
open class NibDesignableCollectionViewCell: UICollectionViewCell, NibDesignableProtocol {
    public var nibContainerView: UIView {
        return self.contentView
    }

    // MARK: - Initializer
    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.setupNib()
    }

    // MARK: - NSCoding
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupNib()
    }
}
