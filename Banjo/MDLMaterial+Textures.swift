//
//  MDLMaterial+Textures.swift
//  Banjo
//
//  Created by Jarrod Parkes on 7/23/16.
//  Copyright © 2016 ParkesTwins. All rights reserved.
//

import ModelIO

extension MDLMaterial {
    func setTextureProperties(textures: [MDLMaterialSemantic:String]) -> Void {
        for (key,value) in textures {
            guard let url = NSBundle.mainBundle().URLForResource(value, withExtension: "") else {
                fatalError("Failed to find URL for resource \(value).")
            }
            let property = MDLMaterialProperty(name:value, semantic: key, URL: url)
            self.setProperty(property)
        }
    }
}