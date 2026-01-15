//
//  TouchanleLabel.swift
//  Financial
//
//  Created by Roman on 15.01.2026.
//

import UIKit

class TouchableLabel: UILabel
{
    var onTap: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTap()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupTap()
    }
    
    func setupTap()
    {
        let tapGestureStart = UITapGestureRecognizer(target: self, action: #selector(tap))
        addGestureRecognizer(tapGestureStart)
        
        
        
    }
    
    @objc private func tap()
    {
        onTap?()
        
    }
    
    func setText(text: String)
    {
        self.text = text
        
        
        
    }
    
    
    
}
