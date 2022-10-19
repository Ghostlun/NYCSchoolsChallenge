//
//  CellReusable.swift
//  NYCSchoolsFinder
//
//  Created by Yoonha Kim on 10/16/22.
//
import Foundation

protocol CellReusable {
    static var reuseIdentifier: String { get }
}

extension CellReusable {
    static var reuseIdentifier: String {
        String(describing: self)
    }
}
