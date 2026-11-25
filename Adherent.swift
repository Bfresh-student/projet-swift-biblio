import Foundation

class Adherent {
    private var nom: String
    private var livresEmpruntes: [Livre]

    init(nom: String, livresEmpruntes: [Livre] = []) {
        self.nom = nom
        self.livresEmpruntes = livresEmpruntes
    }

    // --- Getters & Setters ---
    func getNom() -> String {
        return nom
    }

    func setNom(_ nom: String) {
        self.nom = nom
    }

    func getLivresEmpruntes() -> [Livre] {
        return livresEmpruntes
    }

    func setLivresEmpruntes(_ livres: [Livre]) {
        self.livresEmpruntes = livres
    }

    // --- Méthodes métier ---
    func emprunterLivre(_ livre: Livre) {
        if livresEmpruntes.count < 3 {
            if livre.getEstDisponible() {
                livre.emprunter() 
                livresEmpruntes.append(livre)
            } else {
                print("Livre \"\(livre.getTitre())\" non disponible.")
            }
        } else {
            print("\(nom) a atteint la limite d'emprunt (3 livres max).")
        }
    }

    func retournerLivre(_ livre: Livre) {
        if let index = livresEmpruntes.firstIndex(where: { $0 === livre || $0.getTitre() == livre.getTitre() }) {
            livre.retourner()
            livresEmpruntes.remove(at: index)
        } else {
            print("\(nom) n'a pas emprunté le livre \"\(livre.getTitre())\".")
        }
    }

    func afficherEmprunts() {
        print("Livres empruntés par \(nom) :")
        if livresEmpruntes.isEmpty {
            print(" - Aucun livre emprunté.")
        } else {
            for livre in livresEmpruntes {
                print(" - \(livre.getTitre())")
            }
        }
    }
}
