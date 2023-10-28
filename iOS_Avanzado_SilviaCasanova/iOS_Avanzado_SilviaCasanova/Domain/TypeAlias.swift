//
//  TypeAlias.swift
//  iOS_Avanzado_SilviaCasanova
//
//  Created by Silvia Casanova Martinez on 28/10/23.
//

import Foundation
typealias userData = (email: String, password: String)
typealias sucesssLogin = (userData) -> String

typealias sucessClosure = ([Any]) -> Void
typealias errorClosure = () -> Void
