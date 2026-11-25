import Foundation

class Livre {
    private var titre: String
    private var auteur: String
    private var estDisponible: Bool

    init(titre: String, auteur: String, estDisponible: Bool = true) {
        self.titre = titre
        self.auteur = auteur
        self.estDisponible = estDisponible
    }

    // --- Getters & Setters ---
    func getTitre() -> String {
        return titre
    }

    func setTitre(_ titre: String) {
        self.titre = titre
    }

    func getAuteur() -> String {
        return auteur
    }

    func setAuteur(_ auteur: String) {
        self.auteur = auteur
    }

    func getEstDisponible() -> Bool {
        return estDisponible
    }

    func setEstDisponible(_ disponible: Bool) {
        self.estDisponible = disponible
    }

    // --- Méthodes métier ---
    public func afficherInformations() {
        print("Titre : \(titre), Auteur : \(auteur), Disponible : \(estDisponible)")
    }

    public func emprunter() {
        if estDisponible {
            print("Le livre \"\(titre)\" est emprunté.")
            estDisponible = false
        } else {
            print("Le livre \"\(titre)\" n'est pas disponible.")
        }
    }

    public func retourner() {
        if !estDisponible {
            print("Le livre \"\(titre)\" est retourné.")
            estDisponible = true
        } else {
            print("Le livre \"\(titre)\" n'est pas emprunté.")
        }
    }
}
