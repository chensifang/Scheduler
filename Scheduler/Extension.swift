//
//  Tool.swift
//  Journal
//
//  Created by 陈四方 on 2022/10/19.
//

import Foundation
import AppKit

extension NSColor {
    convenience init(hex: String) {
        let trimHex = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        let dropHash = String(trimHex.dropFirst()).trimmingCharacters(in: .whitespacesAndNewlines)
        let hexString = trimHex.starts(with: "#") ? dropHash : trimHex
        let ui64 = UInt64(hexString, radix: 16)
        let value = ui64 != nil ? Int(ui64!) : 0
        
        var components = (
            R: CGFloat((value >> 16) & 0xff) / 255,
            G: CGFloat((value >> 08) & 0xff) / 255,
            B: CGFloat((value >> 00) & 0xff) / 255,
            a: CGFloat(1)
        )
        if String(hexString).count == 8 {
            components = (
                R: CGFloat((value >> 24) & 0xff) / 255,
                G: CGFloat((value >> 16) & 0xff) / 255,
                B: CGFloat((value >> 08) & 0xff) / 255,
                a: CGFloat((value >> 00) & 0xff) / 255
            )
        }
        self.init(red: components.R, green: components.G, blue: components.B, alpha: components.a)
    }
    
    static func randomHex() -> String {
        let set:Set<String> = ["69BDF9","63D3D7","65C97A",
                               "F5C344","EF85AF","ED7770",
                               "5196D5","98A5A6","C3A38A",
                               "F19D50","B87ECD","D65745",
                               "353B3F","667C89","CFDB4B",
                               "D63864","BF3E87","6B6DC7",
        ]
        return set.first!
    }
    
    static func randomDesign() -> NSColor {
        let set:Set<String> = ["69BDF9","63D3D7","65C97A",
                               "F5C344","EF85AF","ED7770",
                               "5196D5","98A5A6","C3A38A",
                               "F19D50","B87ECD","D65745",
                               "353B3F","667C89","CFDB4B",
                               "D63864","BF3E87","6B6DC7",
        ]
        return NSColor.init(hex: set.first!)
    }
    
    static func random()->NSColor {
        let start = 60
        let length:UInt32 = 40
        let r = (CGFloat)(1 + start + Int(arc4random()%length)) / 100
        let g = (CGFloat)(1 + start + Int(arc4random()%length)) / 100
        let b = (CGFloat)(1 + start + Int(arc4random()%length)) / 100
        return NSColor.init(red: r, green: g, blue: b, alpha: 1)
        //        return .clear
    }
}

class NSLabel:NSTextField {
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init() {
        super.init(frame: NSRect.zero)
        self.isEditable = false
        self.drawsBackground = false
        self.maximumNumberOfLines = 1
        self.isBezeled = false
    }
}

extension NSView {
    var color: NSColor? {
        get {
            guard let x = self.layer?.backgroundColor else {
                return nil
            }
            return NSColor.init(cgColor: x)
        }
        set {
            self.wantsLayer = true
            self.layer?.backgroundColor = newValue?.cgColor
        }
    }
}

extension NSTableView {
    func select(index: Int) {
        let indexSet = IndexSet.init(integer: index)
        self.selectRowIndexes(indexSet, byExtendingSelection: false)
    }
}



