//
//  Platform.swift
//  ModelExplorer
//
//  Created by James Parkes on 1/12/18.
//  Copyright © 2018 ParkesTwins. All rights reserved.
//

import Foundation

// MARK: - Platform: Int, Codable

public enum Platform: Int, Codable {
    case linux = 3
    case n64
    case wii
    case pc
    case ps1
    case ps2
    case ps3
    case xbox = 11
    case xbox360
    case dos
    case mac
    case c64
    case amiga
    case nes = 18
    case snes
    case ds
    case gc
    case gbc
    case dc
    case gba
    case amstradCPC
    case zxSpectrum
    case msx
    case megaDrive = 29
    case sega32x
    case segaSaturn = 32
    case gameBoy
    case android
    case segaGameGear
    case xboxLiveArcade
    case nintendo3ds
    case playstationPortable
    case ios
    case wiiU = 41
    case nGage
    case tapwaveZodiac = 44
    case playstationNetwork
    case playstationVita
    case virtualConsoleNintendo
    case playstation4
    case xboxOne
    case threeDO
    case familyComputerDiskSystem
    case arcade
    case msx2
    case mobile = 55
    case wiiWare
    case wonderSwan
    case superFamicom
    case atari2600
    case atari7800
    case atariLynx
    case atariJaguar
    case atariSTSTE
    case segaMasterSystem
    case atari8Bit
    case atari5200
    case intellivision
    case colecoVision
    case bbcMicrocomputerSystem
    case vectrex
    case commodoreVIC20
    case ouya
    case blackberryOS
    case windowsPhone
    case appleII
    case sharpX1 = 77
    case segaCD
    case neoGeoMVS
    case neoGeoAES
    case webBrowser = 82
    case sg1000 = 84
    case donnerModel30
    case turboGrafx16PCEngine
    case virtualBoy
    case odyssey
    case microvision
    case commodorePET
    case ballyAstrocade
    case steamOS
    case commodore16
    case commodorePlus4
    case pdp1
    case pdp10
    case pdp8
    case decGT40
    case famicom
    case analogueElectronics
    case ferrantiNimrodComputer
    case edsac
    case pdp7
    case hp2100
    case hp3000
    case sdsSigma7
    case callAComputer
    case pdp11
    case cdcCyber70
    case plato
    case imlacPDS1
    case microcomputer
    case onLiveGameSystem
    case amigaCD32
    case appleIIGS
    case acornArchimedes
    case philipsCDI
    case fmTowns
    case neoGeoPocket
    case neoGeoPocketColor
    case sharpX68000
    case nuon
    case wonderSwanColor
    case swanCrystal
    case pc8801
    case trs80
    case fairchildChannelF
    case pcEngineSuperGrafx
    case texasInstrumentsTI99
    case nintendoSwitch
    case nintendoPlayStation
    case amazonFireTV
    case philipsVideopacG7000
    case acornElectron
    case hyperNeoGeo64
    case neoGeoCD
    case newNintendo3DS
    case vc4000
    case advancedProgrammableVideoSystem
    case ay38500
    case ay38610
    case pc50xFamily
    case ay38760
    case ay38710
    case ay38603
    case ay38605
    case ay38606
    case ay38607
    case pc98
    case turboGrafxPCEngineCD
    case trs80ColorComputer
    case fm7
    case dragon3264
    case amstradPCW
    case tatungEinstein
    case thomsonM05
    case necPC6000Series
    case commodoreCDTV
}
