import Foundation

class Bibliotheque {
    private var catalogue: [Livre]

    init(catalogue: [Livre] = []) {
        self.catalogue = catalogue
    }

    // --- Getter & Setter ---
    func getCatalogue() -> [Livre] {
        return catalogue
    }

    func setCatalogue(_ catalogue: [Livre]) {
        self.catalogue = catalogue
    }

    // --- Méthodes métier ---
    func ajouterLivre(_ livre: Livre) {
        catalogue.append(livre)
        print("Le livre \"\(livre.getTitre())\" a été ajouté à la bibliothèque.")
    }

    func afficherCatalogue() {
        print("--- Catalogue de la Bibliothèque ---")
        if catalogue.isEmpty {
            print("Le catalogue est vide.")
        } else {
            for livre in catalogue {
                livre.afficherInformations()
            }
        }
    }

    func rechercherLivre(titre: String) -> Livre? {
        for livre in catalogue {
            if livre.getTitre().lowercased() == titre.lowercased() {
                return livre
            }
        }
        print("Aucun livre trouvé avec le titre \"\(titre)\".")
        return nil
    }
}
