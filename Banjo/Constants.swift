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
        
        static let testModel = shipModel
        static let testTextures = shipTextures
        
        static let shipModel = "realship"
        static let shipTextures: [MDLMaterialSemantic: String] = [
            .BaseColor:"shipDiffuse.png"
        ]
        
        static let fighterModel = "Fighter"
        static let fighterTextures: [MDLMaterialSemantic: String] = [
            .BaseColor:"Fighter_Diffuse_25.jpg",
            .Specular:"Fighter_Specular_25.jpg",
            .Emission:"Fighter_Illumination_25.jpg"
        ]
        
        static let crateModel = "crate"
        static let crateTexture1: [MDLMaterialSemantic: String] = [
            .BaseColor:"crate_tex.jpg"
        ]
    }
}
