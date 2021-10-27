//
//  UIView+Extension.swift
//  Weather Forecast
//
//  Created by Thu Hien on 24/10/2021.
//

import UIKit

enum PositionType {
    case horizontally
    case vertically
}

class EdgeInsets {
    var top: CGFloat?
    var left: CGFloat?
    var bottom: CGFloat?
    var right: CGFloat?

    static var zero: EdgeInsets = .init(top: 0, left: 0, bottom: 0, right: 0)
    static var zeroTop: EdgeInsets = .init(top: 0)
    static var zeroLeft: EdgeInsets = .init(left: 0)
    static var zeroRight: EdgeInsets = .init(right: 0)
    static var zeroBottom: EdgeInsets = .init(bottom: 0)

    static func all(_ value: CGFloat) -> EdgeInsets {
        return EdgeInsets(
            top: value,
            left: value,
            bottom: value,
            right: value
        )
    }

    static func pairs(vertical: CGFloat? = nil, horizontal: CGFloat? = nil) -> EdgeInsets {
        let insets = EdgeInsets()
        if let vertical = vertical {
            insets.top = vertical
            insets.bottom = vertical
        }
        if let horizontal = horizontal {
            insets.left = horizontal
            insets.right = horizontal
        }
        return insets
    }

    static func some(top: CGFloat) -> EdgeInsets { return EdgeInsets(top: top) }
    static func some(left: CGFloat) -> EdgeInsets { return EdgeInsets(left: left) }
    static func some(bottom: CGFloat) -> EdgeInsets { return EdgeInsets(bottom: bottom) }
    static func some(right: CGFloat) -> EdgeInsets { return EdgeInsets(right: right) }

    init(
        top: CGFloat? = nil,
        left: CGFloat? = nil,
        bottom: CGFloat? = nil,
        right: CGFloat? = nil
    ) {
        self.top = top
        self.left = left
        self.bottom = bottom
        self.right = right
    }
}

extension UIView {
    
    func prepareForConstraints() {
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func addViewIfNeeded(_ view: UIView) {
        if subviews.contains(view) == false {
            addSubview(view)
        }
    }
    
    private func activateConstraints(to otherView: UIView, insets: EdgeInsets, relation: NSLayoutConstraint.Relation) {
        otherView.addViewIfNeeded(self)
        if let top = insets.top {
            NSLayoutConstraint(
                item: self,
                attribute: .top,
                relatedBy: relation,
                toItem: otherView,
                attribute: .top,
                multiplier: 1,
                constant: top
            ).isActive = true
        }
        if let left = insets.left {
            NSLayoutConstraint(
                item: self,
                attribute: .leading,
                relatedBy: relation,
                toItem: otherView,
                attribute: .leading,
                multiplier: 1,
                constant: left
            ).isActive = true
        }
        if let bottom = insets.bottom {
            NSLayoutConstraint(
                item: otherView,
                attribute: .bottom,
                relatedBy: relation,
                toItem: self,
                attribute: .bottom,
                multiplier: 1,
                constant: bottom
            ).isActive = true
        }
        if let right = insets.right {
            NSLayoutConstraint(
                item: otherView,
                attribute: .trailing,
                relatedBy: relation,
                toItem: self,
                attribute: .trailing,
                multiplier: 1,
                constant: right
            ).isActive = true
        }
    }

    
    func pinEdges(to otherView: UIView, equalTo insets: EdgeInsets) {
        activateConstraints(to: otherView, insets: insets, relation: .equal)
    }
    
    func center(_ positioning: PositionType? = nil, in parent: UIView, horizontalPriority: Float = 1000, verticalPriority: Float = 1000) {
        if positioning == nil || positioning! == .horizontally {
            let constraint = NSLayoutConstraint(item: self, attribute: .centerX, relatedBy: .equal, toItem: parent, attribute: .centerX, multiplier: 1, constant: 0)
            constraint.priority = UILayoutPriority(rawValue: horizontalPriority)
            constraint.isActive = true
        }

        if positioning == nil || positioning! == .vertically {
            let constraint = NSLayoutConstraint(item: self, attribute: .centerY, relatedBy: .equal, toItem: parent, attribute: .centerY, multiplier: 1, constant: 0)
            constraint.priority = UILayoutPriority(rawValue: verticalPriority)
            constraint.isActive = true
        }
    }
    
    func constraintTo(width: CGFloat? = nil, height: CGFloat? = nil, widthPriority: Float = 1000, heightPriority: Float = 1000) {
        if let width = width {
            let constraint = NSLayoutConstraint(item: self, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1, constant: width)
            constraint.priority = UILayoutPriority(rawValue: widthPriority)
            constraint.isActive = true
        }
        if let height = height {
            let constraint = NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: height)
            constraint.priority = UILayoutPriority(rawValue: heightPriority)
            constraint.isActive = true
        }
    }
    
    func chain(_ direction: PositionType, to view: UIView, with constant: CGFloat = 0, relation: NSLayoutConstraint.Relation = .equal) {
        switch direction {
        case .horizontally:
            NSLayoutConstraint(
                item: self,
                attribute: .leading,
                relatedBy: relation,
                toItem: view,
                attribute: .trailing,
                multiplier: 1,
                constant: constant
            )
            .isActive = true
        case .vertically:
            NSLayoutConstraint(
                item: self,
                attribute: .top,
                relatedBy: relation,
                toItem: view,
                attribute: .bottom,
                multiplier: 1,
                constant: constant
            )
            .isActive = true
        }
    }
}

// MARK: - Loading View
extension UIView {
    
    static let loadingViewTag = 1992121601
    
    func showLoading(style: UIActivityIndicatorView.Style = .large, color: UIColor? = .gray) {
        var loading = viewWithTag(UIView.loadingViewTag) as? UIActivityIndicatorView
        if loading == nil {
            loading = UIActivityIndicatorView(style: style)
        }
        if let color = color {
            loading?.color = color
        }
        loading?.translatesAutoresizingMaskIntoConstraints = false
        loading!.startAnimating()
        loading!.hidesWhenStopped = true
        loading?.tag = UIView.loadingViewTag
        addSubview(loading!)
        loading?.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        loading?.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }

    func stopLoading() {
        let loading = viewWithTag(UIView.loadingViewTag) as? UIActivityIndicatorView
        loading?.stopAnimating()
        loading?.removeFromSuperview()
    }
}
