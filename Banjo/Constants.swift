//
//  Constants.swift
//  Banjo
//
//  Created by Jarrod Parkes on 7/23/16.
//  Copyright © 2016 ParkesTwins. All rights reserved.
//

import ModelIO

// MARK: - Constants

class Constants {
    
    // MARK: Realm
    
    struct Realm {
        static let realmUsername = "readonly@parkestwins.com"
        static let realmPassword = "readonly"
        static let liveRealmServer = "http://127.0.0.1:9080"
        static let liveRealmBanjo = "realm://127.0.0.1:9080/banjo29"
        static let testRealmServer = "http://127.0.0.1:9080"
        static let testRealmBanjo = "realm://127.0.0.1:9080/banjo29"
    }
    
    // MARK: 3D Models (Test Feature)
    
    struct DDDModels {        
        static let testModel = fighterModel
        
        static let shipModel = (shipObj, shipTextures)
        static let shipObj = "realship"
        static let shipTextures: [MDLMaterialSemantic: String] = [
            .baseColor:"shipDiffuse.png"
        ]
        
        static let fighterModel = (fighterObj, fighterTextures)
        static let fighterObj = "Fighter"
        static let fighterTextures: [MDLMaterialSemantic: String] = [
            .baseColor:"Fighter_Diffuse_25.jpg",
            .specular:"Fighter_Specular_25.jpg",
            .emission:"Fighter_Illumination_25.jpg"
        ]
        
        static let crateModel = (crateObj, crateTextures)
        static let crateObj = "crate"
        static let crateTextures: [MDLMaterialSemantic: String] = [
            .baseColor:"crate_tex.jpg"
        ]
    }
}
