//
//  Constants.swift
//  Banjo
//
//  Created by Jarrod Parkes on 7/23/16.
//  Copyright © 2016 ParkesTwins. All rights reserved.
//

import ModelIO
import Foundation

class Constants {
    
    struct Models {
        
        static let testModel = fighterModel
        static let testTextures = fighterTextures
        
        static let shipModel = "realship"
        static let shipTextures: [MDLMaterialSemantic: String] = [
            .baseColor:"shipDiffuse.png"
        ]
        
        static let fighterModel = "Fighter"
        static let fighterTextures: [MDLMaterialSemantic: String] = [
            .baseColor:"Fighter_Diffuse_25.jpg",
            .specular:"Fighter_Specular_25.jpg",
            .emission:"Fighter_Illumination_25.jpg"
        ]
        
        static let crateModel = "crate"
        static let crateTexture1: [MDLMaterialSemantic: String] = [
            .baseColor:"crate_tex.jpg"
        ]
    }
}
