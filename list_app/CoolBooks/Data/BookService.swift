//
//  BookService.swift
//  CoolBooks
//
//  Created by user197181 on 4/8/21.
//

import Foundation

class BookService {
    
    func getBooks() -> [Book] {
        return [
            Book(named: "The Devil in the Dark Water", description: "A supernatural murder mystery taking place on a ship in the 17th century", genre: "Mystery"),
            Book(named: "The Traitor Baru Cormorant", description: "An empire protege is sent to quell a territory prone to rebellion.", genre: "Speculative"),
            Book(named: "Semiosis", description: "A group of colonists escape Earth and attempt to survive on a distant earth-like planet.", genre: "Science Fiction"),
            Book(named: "The Three-Body Problem", description: "A cautionary tale about trying to make contact with aliens.", genre: "Science Fiction"),
            Book(named: "Anathem", description: "Philosopher monk scientists try to stave off a potential alien attack.", genre: "Speculative"),
            Book(named: "A Memory Called Empire", description: "An ambassador from am independent territory attempts to navigate empire politics and save her station from colonization.", genre: "Science Fiction (Space Opera)"),
            Book(named: "The Bird King", description: "A royal concubine and mapmaker attempt to escape Granada as a newly formed Spanish monarcy comes to power.", genre: "Fantasy"),
            Book(named: "A Desolation Called Peace", description: "Space opera in which a diplomat attempts to quell a war between a colonizing empire and invading alien armada.", genre: "Science Fiction (Space Opera)"),
            Book(named: "The Essex Serpent", description: "A recently widowed Londoner moves to Essex with her son in the 19th century and investigates the mythical Essex Serpent with a parish vicar?", genre: "Gothic / Historical Fiction"),
            Book(named: "The Song of Achilles", description: "Reimagining of the Illiad from the perspective of Patroclus.", genre: "Fantasy"),
            Book(named: "The 7 1/2 Deaths of Evelyn Hardcastle", description: "The main character relives the same day as a different party guest until he can uncover a killer.", genre: "Mystery"),
            Book(named: "A Deadly Education", description: "A scholar attending an extremely deadly magic boarding school just tries to survive.", genre: "Fantasy"),
            Book(named: "The City We Became", description: "The world's greatest cities are sentient and have human avatars. They face Lovecraftian horrors.", genre: "Urban Fantasy"),
            Book(named: "Weather", description: "Very funny perspective of a contemporary librarian navigating daily life and doomsday prepping.", genre: "Contemporary Fiction"),
            Book(named: "Children of Time", description: "A vestige of the human race attempts to survive on an old, terraformed planet that is occupied by some highly evolved tenants.", genre: "Science Fiction"),
            Book(named: "Middlegame", description: "Twins created by an alchemist to inhabit two sides of reality (math and language) try to thwart his sinister amibitions for them.", genre: "Science Fantasy / Horror"),
            Book(named: "Gnomon", description: "A detective investigates a murder in a society with ubiquitious surveillance under an ominiscient AI. Almost unintelligible.", genre: "Science Fiction"),
            Book(named: "Kings of the Wyld", description: "Epic fantasy featuring an old band of mercenaries that get back together to fight some powerful enemies. Kind of about rock bands, really.", genre: "Epic Fantasy"),
            Book(named: "Circe", description: "Modern and subversive retelling of Greek Mythology from the perspective of the sorceress Circe", genre: "Fantasy"),
            Book(named: "The City of Brass", description: "Speculative fantasy set in an alternative 18th century Middle East, featuring djinn and plenty of palace intrigue", genre: "Fantasy")
            ]
    }
}
