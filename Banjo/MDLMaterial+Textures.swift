//
//  MDLMaterial+Textures.swift
//  Banjo
//
//  Created by Jarrod Parkes on 7/23/16.
//  Copyright © 2016 ParkesTwins. All rights reserved.
//

import ModelIO

extension MDLMaterial {
    func setTextureProperties(_ textures: [MDLMaterialSemantic:String]) -> Void {
        for (key,value) in textures {
            guard let url = Bundle.main.url(forResource: value, withExtension: "") else {
                fatalError("Failed to find URL for resource \(value).")
            }
            let property = MDLMaterialProperty(name:value, semantic: key, url: url)
            self.setProperty(property)
        }
    }
}
