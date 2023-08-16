//
//  Inspection.swift
//  Beekeeper
//
//  Created by Mariusz Zając on 16/08/2023.
//

import Foundation
struct Inspection: Identifiable {
    let id = UUID()
    var title: String
    var lastInspection: Date
    
}

struct Task: Identifiable {
    let id = UUID()
    var title: String
    var isCompleted: Bool = false
}

enum InspectionPurpose {
    case HiveCheck
    case HoneyHarvest
    case HealthCheck
    case FeedingCheck
    case SwarmCheck
    case HiveSpaceManagement
    case HoneyProductionMonitoring
    case PredatorProtection
    case SeasonalPreparations
    case WaterSupply

    
    // propably temporary description
    var description: String {
            switch self {
            case .HiveCheck:
                return "Regularnie sprawdzaj stan uli, czy są wystarczająco silne, czy nie ma żadnych uszkodzeń, czy dostatecznie dużo pożywienia."
            case .HoneyHarvest:
                return "W odpowiednim czasie, usuń nadmiar miodu z uli, przetwórz go i przygotuj do przechowywania."
            case .HealthCheck:
                return "Regularnie kontroluj swoje ule pod kątem występowania chorób, takich jak warroa czy nosówka."
            case .FeedingCheck:
                return "Jeśli poziom pożywienia w ulu jest niski, konieczne może być dokarmianie pszczół syropem cukrowym, szczególnie w trudniejszych warunkach."
            case .SwarmCheck:
                return "W okresach intensywnego rojenia, monitoruj zachowanie pszczół i unikaj sytuacji, w której cały rój opuści ul."
            case .HiveSpaceManagement:
                return "Zapewnij wystarczającą przestrzeń w ulu dla pszczół, zwłaszcza w okresach intensywnego rojenia lub gromadzenia pożywienia."
            case .HoneyProductionMonitoring:
                return "Zapisuj ilości zebranego miodu, aby śledzić wydajność i planować dalsze kroki."
            case .PredatorProtection:
                return "Upewnij się, że ul jest zabezpieczony przed drapieżnikami, takimi jak myszy czy osy."
            case .SeasonalPreparations:
                return "Przygotuj ule na zmieniające się warunki sezonowe, zapewniając odpowiednią izolację i dostęp do pożywienia."
            case .WaterSupply:
                return "Umieść wodę w bliskiej odległości od uli, aby zapewnić pszczolom dostęp do wody, szczególnie w okresach upalnych."
            }
        }
}

