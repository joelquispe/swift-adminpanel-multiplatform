//
//  SupabaseConfig.swift
//  swift-adminpanel-multiplatform
//
//  Created by joel on 26/03/24.
//

import Foundation
import Supabase
class SupabaseConfig{
    
    static let client = SupabaseClient(supabaseURL: URL(string: ProcessInfo.processInfo.environment["SUPABASE_URL"]!)!, supabaseKey: ProcessInfo.processInfo.environment["SUPABASE_KEY"]!)
}

