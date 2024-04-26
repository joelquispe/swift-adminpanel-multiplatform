//
//  SupabaseService.swift
//  swift-adminpanel-multiplatform
//
//  Created by joel on 14/04/24.
//

import Foundation
import Supabase
class SupabaseService{
    let bucketName = ProcessInfo.processInfo.environment["SUPABASE_BUCKET"]!
    
    func createBucket() async throws -> Bool{
        do{
            _ = try await SupabaseConfig.client.storage
                .getBucket(bucketName)
            return false
            
        }catch{
            try await SupabaseConfig.client.storage
              .createBucket(
                bucketName,
                options: BucketOptions(
                  public: true,
                  fileSizeLimit: 1024, allowedMimeTypes: ["image/png"]
                )
              )
            return true
        }
        
    }
    
    func generateSignedUrl(path:String,fileName: String) async throws -> String {
        let signedURL = try await SupabaseConfig.client.storage
          .from(bucketName)
          .createSignedURL(path: "public/\(path)/\(fileName)", expiresIn: 120)
        return signedURL.absoluteString
    }
    
    func deleteFile(path:String, fileName:String)async throws{
        let _ = try await SupabaseConfig.client.storage
          .from(bucketName)
          .remove(paths: ["public/\(path)/\(fileName)"])
    }
}
