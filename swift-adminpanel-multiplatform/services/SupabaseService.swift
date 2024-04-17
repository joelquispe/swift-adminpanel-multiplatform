//
//  SupabaseService.swift
//  swift-adminpanel-multiplatform
//
//  Created by joel on 14/04/24.
//

import Foundation
import Supabase
class SupabaseService{
    
    
    func createBucket() async throws{
        do{
            try await SupabaseConfig.client.storage
               .getBucket("admin_panel_multiplatform")
        }catch{
            try await SupabaseConfig.client.storage
              .createBucket(
                "admin_panel_multiplatform",
                options: BucketOptions(
                  public: true,
                  fileSizeLimit: 1024, allowedMimeTypes: ["image/png"]
                )
              )
        }
        
    }
}
