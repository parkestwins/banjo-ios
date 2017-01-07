//
//  DDDDisplayVC.swift
//  Banjo
//
//  Created by Jarrod Parkes on 7/18/16.
//  Copyright © 2016 ParkesTwins. All rights reserved.
//

import UIKit
import SceneKit
import SceneKit.ModelIO

// MARK: - DDDDisplayVC: UIViewController

class DDDDisplayVC: UIViewController {
    
    // MARK: Outlets
    
    @IBOutlet weak var sceneView: SCNView!
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        load3DModel()
    }

    func load3DModel() {
        // load .obj file
        guard let url = Bundle.main.url(forResource: Constants.DDDModels.testModel.0, withExtension: "obj") else {
            fatalError("Failed to find model file.")
        }
        
        let asset = MDLAsset(url:url)
        guard let object = asset.object(at: 0) as? MDLMesh else {
            fatalError("Failed to get mesh from asset.")
        }
        
        // create a material from the various textures
        let scatteringFunction = MDLScatteringFunction()
        let material = MDLMaterial(name: "baseMaterial", scatteringFunction: scatteringFunction)
        material.setTextureProperties(Constants.DDDModels.testModel.1)
      
        // apply the texture to every submesh of the asset
        for  submesh in object.submeshes!  {
            if let submesh = submesh as? MDLSubmesh {
                submesh.material = material
            }
        }
        
        // wrap the object in a SceneKit object
        let node = SCNNode(mdlObject: object)
        node.scale = SCNVector3(x: 0.5, y: 0.5, z: 0.5)
        let scene = SCNScene()
        scene.rootNode.addChildNode(node)
        
        // set up the scene
        sceneView.autoenablesDefaultLighting = true
        sceneView.allowsCameraControl = true
        sceneView.scene = scene        
        sceneView.backgroundColor = UIColor.clear
    }
}
